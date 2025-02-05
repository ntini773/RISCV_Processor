module 64bit_Adder(
    input a[63:0],input b[63:0],input cin,
    output sum[63:0],output cout
);
    //dummy var
    wire p[63:0],g[63:0],c[64:0];
     
    //P,G gen
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:prop_gen
            xor(p[i],a[i],b[i]);
            and(g[i],a[i],b[i]);
        end

    endgenerate
    
    assign c[0] = cin; 
    // and(c[0],cin,1'b0); // to assign c[0] = cin
    // and(c[0],cin,0'b0); // to assign c[0] = 0

    //Sum,Carry gen
    generate
        for(i=0;i<63;i=i+1) begin:carry_gen
            wire and_term;
            and(and_term, p[i], c[i]);  
            or(c[i + 1], g[i], and_term);  
            xor(sum[i], p[i], c[i]);  
        end
    endgenerate

    //Last bit
    xor(sum[63], p[63], c[63]);
    assign cout = c[64];




endmodule