`ifndef SLTU
`define SLTU
module set_less_than_unsigned(input [63:0]a,input [63:0]b,output less);
    genvar i;
    wire [63:0]lt;
    generate
        for(i=0;i<64;i=i+1) begin:less_gen
            wire not_a;
            not(not_a,a[i]);
            and(lt[i], not_a, b[i]);  // lt[i] = ~a[i] & b[i] (a < b condition)
            
        end
    endgenerate

    wire [63:0]chain;
    assign chain[63] = lt[63];

    generate
        for(i=62;i>=0;i=i-1) begin:chain_gen
            or(chain[i],lt[i],chain[i+1]); //if lt is 1 ,chain is already 1 from then
        end
    endgenerate

    assign less = chain[0];
endmodule

`endif SLTU