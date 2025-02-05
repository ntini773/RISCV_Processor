module complement(input [63:0] a,output [63:0] comp);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:comp_gen
           xor(comp[i],a[i],1'b1);
        end
    endgenerate
endmodule

module 64bit_Subtractor(input a[63:0],input b[63:0]
,output difference[63:0],output borrow);
    // A+(~B)+1
    //logic = assign a to difference and add ~b
    wire [63:0] b1;
    complement comp_b1(.a(b),.comp(b1));

    wire cin;
    assign cin = 1'b1;
    
    64bit_Adder adder(.a(a),.b(b1),.cin(cin),.sum(difference),.cout(borrow));


endmodule