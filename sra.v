'include "slt.v"
module shift_right_arithmetic(input a[63:0],input b[5:0],output out[63:0]);
    genvar i;
    generate
        for(int i=0;i<64;i=i+1) begin:sra
            wire slt;
            strictly_less(.a(i),.b(b),.less(slt));
            mux2 sramux(.sel(slt), .in0(a[i-b]), .in1(a[63]), .out(out[i]));

        end
        endgenerate
endmodule