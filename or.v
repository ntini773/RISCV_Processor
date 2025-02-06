module bit_Or(input [63:0]a,input [63:0]b,output [63:0]out);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:or_gen
            or(out[i],a[i],b[i]);
        end
    endgenerate
endmodule