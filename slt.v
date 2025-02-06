`include "sub.v"
module set_less_than(input [63:0]a,input [63:0]b,output wire less);
    wire [63:0] diff;
    wire borrow;
    bit_Subtractor sub1(.a(a),.b(b),.difference(diff),.borrow(borrow));
    assign less = diff[63];

endmodule
