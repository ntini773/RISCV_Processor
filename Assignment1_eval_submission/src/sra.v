`ifndef SRA
`define SRA
`include "slt.v"
module shift_right_arithmetic(input [63:0]a,input [4:0]b,output [63:0]out);
    genvar i;
    generate
        for(int i=0;i<64;i=i+1) begin:sra
            wire slt;
            wire [63:0]shift_amount;
            assign shift_amount = {59'b0,b};
            wire [63:0] shift_value = 64 - i;

            set_less_than slt1(.a(shift_amount),.b(shift_value),.less(slt)); //b<64-i

            mux2 srlmux(.sel(slt), .in0(a[63]), .in1(a[i+b]), .out(out[i]));

        end
        endgenerate
endmodule
`endif 