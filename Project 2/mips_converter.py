#!/usr/bin/env python
# coding: utf-8

# In[3]:


reg = {}
for i in range(32):
    if i == 0:
        reg[i] = 'zero'
    elif i == 1:
        reg[i] = 'at'
    elif i == 2 or i==3:
        reg[i] = 'v' + str(i-2)
    elif i>=4 and i<= 7:
        reg[i] = 'a' + str(i-4)
    elif i >=8 and i<=15:
        reg[i] = 't' + str(i-8)
    elif i == 24 or i==25:
        reg[i] = 't' + str(i-24+8)
    elif i >=16 and i <=23:
        reg[i] = 's' + str(i-16)
    elif i==26 or i == 27:
        reg[i] = 'k' + str(i-26)
    elif i==28:
        reg[i] = 'gp'
    elif i==29:
        reg[i] = 'sp'
    elif i==30:
        reg[i] = 'fp'
    elif i==31:
        reg[i] = 'ra'


# In[119]:


reg_a = {}
for i in reg.keys():
    reg_a[reg[i]] = i


# In[118]:


def R_convert(instr):
    op = instr[0]
    a = instr[1]
    b = instr[2]
    c = instr[3]
    
    funct = {
    'add' : 21,
    'sub' : 22,
    'and' : 23,
    'or' : 24,
    'srl': 25,
    'sll': 26
    }
    
    out = '{'
    # op    
    if op in ['add','sub','and','or','srl','sll']:
        out += "6'd54,"
    
    # rs
    if op in ['add','sub','and','or']:
        out += "5'd{},".format(reg_a[b])
    elif op in ['srl','sll']:
        out += "5'd0,"
    
    #rt
    if op in ['add','sub','and','or']:
        out += "5'd{},".format(reg_a[c])
    elif op in ['srl','sll']:
        out += "5'd{},".format(reg_a[b])
    
    #rd
    if op in ['add','sub','and','or','srl','sll']:
        out += "5'd{},".format(reg_a[a])
    
    #shamt
    if op in ['add','sub','and','or']:
        out += "5'd0,"
    elif op in ['srl','sll']:
        out += "5'd{},".format(c)
    
    #funct
    if op in ['add','sub','and','or','srl','sll']:
        out += "6'd{}".format(funct[op])
    
    out += '}'
    return out


# In[120]:


r_instr = [
    'add t0 t1 t2',
    'sub t1 t1 t2',
    'and t3 t5 t3',
    'or t5 t3 t5',
    'srl t3 t4 2',
    'sll t5 t7 5'
]


# In[122]:


def R_instrs(r_instr):
    for i in range(len(r_instr)):
        s = 'Instr[{}] = '.format(i) + R_convert(r_instr[i].split(' ')) + ';'
        print(s)


# In[123]:


R_instrs(r_instr)


# In[75]:


def I_convert(instr):
    op = instr[0]
    if op in ['sw','lw']:
        rs = instr[3]
        im = instr[2]
        rt = instr[1]
    elif op in ['addi','subi']:
        rt = instr[1]
        rs = instr[2]
        im = instr[3]
    elif op == 'beq':
        rs = instr[1]
        rt = instr[2]
        im = instr[3]
    
    out = '{'
    
    #op
    if op == 'sw':
        out += "6'd39,"
    elif op == 'lw':
        out += "6'd40,"
    elif op == 'addi':
        out += "6'd41,"
    elif op == 'subi':
        out += "6'd42,"
    elif op == 'beq':
        out += "6'd31,"
    
    #rs
    if op in ['sw','lw','addi','subi','beq']:
        out += "5'd{},".format(reg_a[rs])
    
    #rt
    if op in ['sw','lw','addi','subi','beq']:
        out += "5'd{},".format(reg_a[rt])
        
    #im
    out += "16'd{}".format(im)
    
    out += "}"
    
    return out


# In[76]:


i_instr = [
    'sw t0 2 t3',
    'lw s3 2 t3',
    'lw s4 3 t3',
    'sw t0 2 t2',
    'sw s4 4 t1',
    'addi s5 s4 40',
    'addi s6 s5 22',
    'subi s3 s6 8',
    'subi s7 s0 2',
    'beq t4 t6 4',
    'beq t4 t8 4',
    'beq s3 s5 4',
    'beq t8 t9 1'
]


# In[128]:


def I_instrs(i_instr):
    for i in range(len(i_instr)):
        print('Instr[{}] = '.format(i) + I_convert(i_instr[i].split(' ')) + ';')


# In[129]:


I_instrs(i_instr)


# In[132]:


def J_convert(instr):
    op = instr[0]
    im = instr[1]
    out = "{"
    if op == 'j':
        out += "6'd32,"
        out += "26'd{}".format(im)
    out += "}"
    return out


# In[133]:


j_instr = [
    'j 125',
    'j 18'
]


# In[146]:


def J_instrs(j_instr):
    for i in range(len(j_instr)):
        print('Instr[{}] = '.format(i) + J_convert(j_instr[i].split(' ')) + ';')
    


# In[147]:


J_instrs(j_instr)


# In[152]:


a = ['addi s0 zero 666',
'addi s1 zero 777',
'addi s0 s0 111',
'subi s1 s1 111'
]
I_instrs(a)


# In[151]:


a = [
    'sub t0 s2 s1',
    'srl t0 t0 31'
]
R_instrs(a)


# In[153]:


a = [
'addi t1 zero 1',
'beq t0 t1 1',
'addi s2 zero 555',
'addi s2 zero 888',
'addi t0 zero 0',
'sw s0 0 t0',
'sw s1 4 t0',
'sw s2 8 t0'
]
I_instrs(a)


# In[ ]:




