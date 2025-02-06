module shift_left_logical(input a[63:0],input b[5:0],output out[63:0]);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:shift_gen
            assign out[i] = (i < 64 - b) ? a[i + b] : 1'b0;
        end
    endgenerate
endmodule