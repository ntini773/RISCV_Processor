module 64bit_Xor(input a[63:0],input b[63:0],output out[63:0]);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:xor_gen
            xor(out[i],a[i],b[i]);
        end
    endgenerate
endmodule
