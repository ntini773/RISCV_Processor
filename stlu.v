module strictly_less_than_unsigned(input a[63:0],input b[63:0],output less);
    genvar i;
    wire lt[63:0];
    wire eq;
    generate
        for(i=63;i>=0;i=i-1) begin:less_gen
            wire nor_a;
            not(nor_a,a[i]);
            and(lt[i], not_a, b[i]);  // lt[i] = ~a[i] & b[i] (a < b condition)
            
        end

    endgenerate

    wire chain[63:0];
    assign chain[63] = lt[63];
    generate
        for(i=62;i>=0;i=i-1) begin:chain_gen
            or(chain[i],lt[i],chain[i+1]); //if lt is 1 ,chain is already 1 from then
        end
    endgenerate

    assign less = chain[0];
endmodule