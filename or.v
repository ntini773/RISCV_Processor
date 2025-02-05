module 64bit_Or(input a[63:0],input b[63:0],output out[63:0]);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:or_gen
            or(out[i],a[i],b[i]);
        end
    endgenerate
endmodule