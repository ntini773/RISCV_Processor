module shift_right_arithmetic(input a[63:0],input b[5:0],output out[63:0]);
    genvar i;
    generate
        for(int i=0;i<64;i=i+1) begin:sra
            assign out[i]=(i>=b)?a[i-b]:a[63];
        end
        endgenerate
endmodule