`ifndef BIT_AND
`define BIT_AND
module bit_And(input [63:0] a ,input [63:0] b,output [63:0]out);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:and_gen
            and(out[i],a[i],b[i]);
        end
    endgenerate
endmodule
`endif BIT_AND