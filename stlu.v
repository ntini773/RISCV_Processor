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
        for(i=63;i>=0;i=i-1) begin:chain_gen
            or(chain[i-1],lt[i-1],chain[i]); //if lt is 1 ,chain is already 1 from then
        end
    endgenerate

    assign less = chain[0];
endmodule