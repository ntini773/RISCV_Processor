`ifndef ALU
`define ALU

`include "add.v"
`include "sub.v"
`include "and.v"
// `include "or.v"
// `include "xor.v"
// `include "sll.v"
// `include "srl.v"
// `include "slt.v"
// `include "sra.v"

module bit_Or(input [63:0]a,input [63:0]b,output [63:0]out);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:
          assign out[i] = a[i] | b[i];
        end
    endgenerate
endmodule

module alu(
    input [63:0] a,
    input [63:0] b,
    input [3:0] alu_op,
    output reg [63:0] out
);

wire [63:0] shiftleft, shiftright, bitAnd, bitXor, bitOr, shiftRightArithmetic;
wire lessThan, lessThanUnsigned;
wire [63:0] add, sub;

bit_Adder o1(.a(a), .b(b), .cin(1'b0), .sum(add), .cout());
bit_Subtractor o2(.a(a), .b(b), .difference(sub), .borrow());
// bit_And o3(.a(a), .b(b), .output(bitAnd));
// bit_Or o4(.a(a), .b(b), .output(bitOr));
// bit_Xor o5(.a(a), .b(b), .output(bitXor));
shift_left_logical o6(.a(a), .b(b[4:0]), .out(shiftleft));
shift_right_logical o7(.a(a), .b(b[4:0]), .out(shiftright));
shift_right_arithmetic o8(.a(a), .b(b[4:0]), .out(shiftRightArithmetic));
set_less_than o9(.a(a), .b(b), .less(lessThan));
set_less_than_unsigned o10(.a(a), .b(b), .less(lessThanUnsigned));

always @(*) begin 
    case (alu_op)
        4'b0000 : out = add;
        4'b0001 : out = sub;
        4'b0010 : out = bitAnd;
        4'b0011 : out = bitOr;
        4'b0100 : out = bitXor;
        4'b0101 : out = shiftleft;
        4'b0110 : out = shiftright;
        4'b0111 : out = shiftRightArithmetic;
        4'b1000 : out = {63'b0, lessThan};         // Convert 1-bit to 64-bit
        4'b1001 : out = {63'b0, lessThanUnsigned}; // Convert 1-bit to 64-bit
        default : out = 64'b0;
    endcase
end

endmodule

`endif // ALU
