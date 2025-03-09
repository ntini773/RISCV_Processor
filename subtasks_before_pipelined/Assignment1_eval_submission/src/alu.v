`ifndef ALU  
`define ALU

module mux2_combined (input wire sel,  input wire in0, input wire in1,output out);
    wire not_sel;    
    wire and0, and1; 
    not(not_sel, sel);

    and(and0, in0, not_sel);  
    and(and1, in1, sel);     

    or(out, and0, and1);      

endmodule

module bit_Adder_combined(input [63:0]a,input [63:0]b,input cin,output [63:0]sum,output cout,output wire overflow);
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
    assign overflow = c[63] ^ c[64];


endmodule

module complement_combined(input [63:0] a,output [63:0] comp);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:comp_gen
           xor(comp[i],a[i],1'b1);
        end
    endgenerate
endmodule

module bit_Subtractor_combined(input [63:0]a,input [63:0]b
,output [63:0] difference,output wire borrow,output wire overflow);
    // A+(~B)+1
    //logic = assign a to difference and add ~b
    wire [63:0] b1;
    complement_combined comp_b1(.a(b),.comp(b1));

    wire cin;
    assign cin = 1'b1;
    wire temp;
    bit_Adder_combined adder(.a(a),.b(b1),.cin(cin),.sum(difference),.cout(temp));
    assign overflow = (a[63] ^ b[63]) & (a[63] ^ difference[63]);
    assign borrow=~temp;
endmodule

module bit_And_combined(input [63:0] a ,input [63:0] b,output [63:0]out);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:and_gen
            and(out[i],a[i],b[i]);
        end
    endgenerate
endmodule


module bit_Xor_combined(input [63:0]a,input [63:0]b,output [63:0]out);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:xor_gen
            xor(out[i],a[i],b[i]);
        end
    endgenerate
endmodule

module bit_Or_combined(input [63:0]a,input [63:0]b,output [63:0]out);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:or_gen
            or(out[i],a[i],b[i]);
        end
    endgenerate
endmodule

module shift_left_logical_combined(input [63:0]a,input [4:0]b,output [63:0]out);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:shift_gen
            wire slt;
            wire [63:0] shift_amount;  
            assign shift_amount = {59'b0, b}; // Zero-extend b to 64 bits
            wire [63:0] i_extended;
            assign i_extended = {57'b0,i[6:0]};
            set_less_than_combined slt_inst(.a(i_extended), .b(shift_amount), .less(slt)); //i<b
            mux2_combined sll_mux(.sel(slt), .in0(a[i-b]), .in1(1'b0), .out(out[i]));
        
        end
    endgenerate
endmodule

module shift_right_logical_combined(input [63:0]a,input [4:0]b,output [63:0]out);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:shift
            wire slt;
            wire [63:0]shift_amount;
            assign shift_amount = {59'b0,b};
            wire [63:0] shift_value = 64 - i;

            set_less_than_combined slt1(.a(shift_amount),.b(shift_value),.less(slt)); //b<64-i

            mux2_combined srlmux(.sel(slt), .in0(1'b0), .in1(a[i+b]), .out(out[i]));
        end
    endgenerate
endmodule

module shift_right_arithmetic_combined(input [63:0]a,input [4:0]b,output [63:0]out);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:sra
            wire slt;
            wire [63:0]shift_amount;
            assign shift_amount = {59'b0,b};
            wire [63:0] shift_value = 64 - i;

            set_less_than_combined slt2(.a(shift_amount),.b(shift_value),.less(slt)); //b<64-i

            mux2_combined sramux(.sel(slt), .in0(a[63]), .in1(a[i+b]), .out(out[i]));

        end
        endgenerate
endmodule

module set_less_than_combined(input [63:0]a,input [63:0]b,output wire less);
    wire [63:0] diff;
    wire borrow;
    bit_Subtractor_combined sub1(.a(a),.b(b),.difference(diff),.borrow(borrow));
    assign less = diff[63];

endmodule

module set_less_than_unsigned_combined(input [63:0]a,input [63:0]b,output less);
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
    wire [64:0] enabler;
    wire [64:0] flag;
    wire [63:0] xorab;
    wire[63:0] a_not;
    assign chain[63] = lt[63];
    assign enabler[64] = 1'b0;
    for (i = 63; i >=0; i = i - 1) begin
        wire select,not_enabler;
        xor u1 (xorab[i], a[i],b[i]);
        not u2 (a_not[i], a[i]);
        and u3 (chain[i], a_not[i], b[i]);
        or u4 (enabler[i], enabler[i+1], xorab[i]);
        not u5 (not_enabler, enabler[i+1]);
        and u6 (select, not_enabler, xorab[i]);
        
        mux2_combined mux1 (.sel(select), .in0(flag[i+1]), .in1(chain[i]), .out(flag[i]));
    end
    assign less = flag[0];
endmodule



module alu(
    input [63:0] a,
    input [63:0] b,
    input [3:0] alu_op,
    output reg [63:0] out,
    output reg cout,
    output reg borrow,
    output reg overflowadd,
    output reg overflowsub
);

wire [63:0] shiftleft, shiftright, bitAnd, bitXor, bitOr, shiftRightArithmetic;
wire lessThan, lessThanUnsigned;
wire [63:0] add, sub;
wire cout1,borrow1,overflowadd1,overflowsub1;

bit_Adder_combined o1(.a(a), .b(b), .cin(1'b0), .sum(add), .cout(cout1), .overflow(overflowadd1));
bit_Subtractor_combined o2(.a(a), .b(b), .difference(sub), .borrow(borrow1), .overflow(overflowsub1));
bit_And_combined o3(.a(a), .b(b), .out(bitAnd));
bit_Or_combined o4(.a(a), .b(b), .out(bitOr));
bit_Xor_combined o5(.a(a), .b(b), .out(bitXor));
shift_left_logical_combined o6(.a(a), .b(b[4:0]), .out(shiftleft));
shift_right_logical_combined o7(.a(a), .b(b[4:0]), .out(shiftright));
shift_right_arithmetic_combined o8(.a(a), .b(b[4:0]), .out(shiftRightArithmetic));
set_less_than_combined o9(.a(a), .b(b), .less(lessThan));
set_less_than_unsigned_combined o10(.a(a), .b(b), .less(lessThanUnsigned));


always @(*) begin 
    cout = cout1;
    borrow = borrow1;
    overflowadd = overflowadd1;
    overflowsub = overflowsub1;
    
    case (alu_op)
        4'b0000 : out = add;
        4'b0001 : out = sub;
        4'b0010 : out = bitAnd;
        4'b0011 : out = bitOr;
        4'b0100 : out = bitXor;
        4'b0101 : out = shiftleft;
        4'b0110 : out = shiftright;
        4'b0111 : out = shiftRightArithmetic;
        4'b1000 : out = {63'b0, lessThan};         
        4'b1001 : out = {63'b0, lessThanUnsigned}; 
        default : out = 64'b0;
    endcase
end

endmodule


`endif 