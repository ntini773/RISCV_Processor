'include "slt.v"
module shift_right_arithmetic(input [63:0]a,input [4:0]b,output [63:0]out);
    genvar i;
    generate
        for(int i=0;i<64;i=i+1) begin:sra
            wire slt;
            wire shift_amount=64-{59'b0,i};
            set_less_than slt1(.a(shift_amount),.b(b),.less(slt));
            mux2 sramux(.sel(slt), .in0(a[63]), .in1(a[i+b]), .out(out[i]));

        end
        endgenerate
endmodule