`timescale 1ns / 1ps

module PipelineCPU_tb;

	// Inputs
	reg [31:0] Addr_in;
	reg clk;

	// Outputs
	wire [31:0] Addr_o;

	// Instantiate the Unit Under Test (UUT)
	PipelineCPU uut (
		.Addr_in(Addr_in), 
		.clk(clk), 
		.Addr_o(Addr_o)
	);

	initial begin
		// Initialize Inputs
		Addr_in = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#5000
		$finish;
        
		// Add stimulus here
	end
	
	always begin
		#10 clk <= ~clk;
		#10 clk <= ~clk;
			 Addr_in <= Addr_o;
	end
      
endmodule

