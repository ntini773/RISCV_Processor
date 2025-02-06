
module bit_Adder(input [63:0]a,input [63:0]b,input cin,output [63:0]sum,output cout);
    //dummy var
    wire [63:0]p;
    wire [63:0]g;
    wire [64:0]c;
     
    //P,G gen
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:prop_gen
            xor(p[i],a[i],b[i]);
            and(g[i],a[i],b[i]);
        end
        
    endgenerate
    
    assign c[0] = cin; 

    //Sum,Carry gen
    generate
        for(i=0;i<=63;i=i+1) begin:carry_gen
            wire and_term;
            and(and_term, p[i], c[i]);  
            or(c[i + 1], g[i], and_term);  
            xor(sum[i], p[i], c[i]);  
        end
    endgenerate

    //Last bit
    assign cout = c[64];


endmodule