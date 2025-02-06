`ifndef SRL
`define SRL
`include "slt.v"
`include "mux2.v"
module shift_right_logical(input [63:0]a,input [4:0]b,output [63:0]out);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:shift
            wire slt;
            wire [63:0]shift_amount;
            assign shift_amount = {59'b0,b};
            wire [63:0] shift_value = 64 - i;

            set_less_than slt1(.a(shift_amount),.b(shift_value),.less(slt)); //b<64-i

            mux2 srlmux(.sel(slt), .in0(1'b0), .in1(a[i+b]), .out(out[i]));
        end
    endgenerate
endmodule
`endif SRL