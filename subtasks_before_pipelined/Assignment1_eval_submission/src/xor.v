
module bit_Xor(input [63:0]a,input [63:0]b,output [63:0]out);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:xor_gen
            xor(out[i],a[i],b[i]);
        end
    endgenerate
endmodule
