`include "add.v"
module complement(input [63:0] a,output [63:0] comp);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:comp_gen
           xor(comp[i],a[i],1'b1);
        end
    endgenerate
endmodule

module bit_Subtractor(input [63:0]a,input [63:0]b
,output [63:0] difference,output wire borrow);
    // A+(~B)+1
    //logic = assign a to difference and add ~b
    wire [63:0] b1;
    complement comp_b1(.a(b),.comp(b1));

    wire cin;
    assign cin = 1'b1;
    wire temp;
    bit_Adder adder(.a(a),.b(b1),.cin(cin),.sum(difference),.cout(temp));
    assign borrow=~temp;
endmodule
