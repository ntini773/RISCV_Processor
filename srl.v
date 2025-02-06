module shift_right_logical(input a[63:0],input b[5:0],output[63:0]);
    genvar i;
    generate
        for(int i=0;i<64;i=i+1) begin:shift
            assign out[i]=(i>=b)?a[i-b]:1'b0;
        end
    endgenerate
endmodule