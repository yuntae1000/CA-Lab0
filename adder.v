`define XOR xor #50
`define AND and #50
`define OR or #50

module behavioralFullAdder(sum, carryout, a, b, carryin);
	output sum, carryout;
	input a, b, carryin;
	assign {carryout, sum}=a+b+carryin;
endmodule

module oneBitAdder(out, carryout, a, b, carryin);
	output out, carryout;
	input a, b, carryin;
	
	wire a, b, carryin, carryout, out;
	wire x0, a0, a1;

	`XOR(x0, a, b);
	`XOR(out, x0, carryin);

	`AND(a0, x0, carryin);
	`AND(a1, a, b);

	`OR(carryout, a0, a1);
endmodule

module FullAdder4bit(
	output[3:0] sum,
	output carryout,
	output overflow,
	input[3:0] a,
	input[3:0] b
	);

	wire c0, c1, c2;

	oneBitAdder adder0 (sum[0], c0, a[0], b[0], 0);
	oneBitAdder adder1 (sum[1], c1, a[1], b[1], c0);
	oneBitAdder adder2 (sum[2], c2, a[2], b[2], c1);
	oneBitAdder adder3 (sum[3], carryout, a[3], b[3], c2);

	`XOR(overflow, c2, carryout);
endmodule

module testFullAdder;
	wire [3:0] sum;
	wire carryout;
	reg [3:0] a;
	reg [3:0] b;
	reg carryin;
	wire overflow;

	FullAdder4bit adder(sum, carryout, overflow, a, b);

	initial begin
		//$dumpfile("adder.vcd");
		//$dumpvars(0, testFullAdder);

		$display(" A     B     Carryin |   Sum       Carryout | Overflow   Expected sum   Expected Carryout|", a, b, carryin, sum, carryout);

		$display("Test Overflow:");
		a=4'b0101; b=4'b0011; carryin=0; #1000
		$display(" %b  %b     %b    |   %b         %b     |    %b           1000                 0      |", a, b, carryin, sum, carryout, overflow);
		a=4'b1001; b=4'b1110; carryin=0; #1000
		$display(" %b  %b     %b    |   %b         %b     |    %b           0111                 1      |", a, b, carryin, sum, carryout, overflow);
		a=4'b0101; b=4'b0010; carryin=0; #1000
		$display(" %b  %b     %b    |   %b         %b     |    %b           0111                 0      |", a, b, carryin, sum, carryout, overflow);
		a=4'b1101; b=4'b1011; carryin=0; #1000
		$display(" %b  %b     %b    |   %b         %b     |    %b           1000                 1      |", a, b, carryin, sum, carryout, overflow);

		$display("Adding negative/positive:");
		a=4'b1011; b=4'b0011; carryin=0; #1000
		$display(" %b  %b     %b    |   %b         %b     |    %b           1110                 0      |", a, b, carryin, sum, carryout, overflow);
		a=4'b1011; b=4'b0110; carryin=0; #1000
		$display(" %b  %b     %b    |   %b         %b     |    %b           0001                 1      |", a, b, carryin, sum, carryout, overflow);

		$display("Adding two negatives:");
		a=4'b1110; b=4'b1100; carryin=0; #1000
		$display(" %b  %b     %b    |   %b         %b     |    %b           1010                 1      |", a, b, carryin, sum, carryout, overflow);
		a=4'b1111; b=4'b1101; carryin=0; #1000
		$display(" %b  %b     %b    |   %b         %b     |    %b           1100                 1      |", a, b, carryin, sum, carryout, overflow);

		$display("Adding two positives:");
		a=4'b0010; b=4'b0100; carryin=0; #1000
		$display(" %b  %b     %b    |   %b         %b     |    %b           0110                 0      |", a, b, carryin, sum, carryout, overflow);
		a=4'b0001; b=4'b0011; carryin=0; #1000
		$display(" %b  %b     %b    |   %b         %b     |    %b           0100                 0      |", a, b, carryin, sum, carryout, overflow);
		//$finish;
	end

endmodule
