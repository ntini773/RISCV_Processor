'include "sub.v"
module set_less_than(input a[63:0],input b[63:0],output less);
    wire [63:0] diff;
    wire borrow;
    bit_Subtractor sub(.a(a),.b(b),.diff(diff),.borrow(borrow));
    assign less = diff[63];

endmodule
