'include "slt.v"
module shift_right_logical(input a[63:0],input b[5:0],output[63:0]);
    genvar i;
    generate
        for(int i=0;i<64;i=i+1) begin:shift
            wire slt;
            strictly_less(.a(i),.b(b),.less(slt));
            mux2 srlmux(.sel(slt), .in0(a[i-b]), .in1(1'b0), .out(out[i]));
        end
    endgenerate
endmodule