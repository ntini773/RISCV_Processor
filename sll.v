`ifndef SHIFT_LEFT_LOGICAL
`define SHIFT_LEFT_LOGICAL
`include "slt.v"

module mux2 (
    input sel,    // Selector input
    input in0,    // First input
    input in1,    // Second input
    output out    // Output
);
    wire not_sel;    // Inverted selector signal
    wire and0, and1; // Intermediate AND gate outputs

    // Invert the selector signal
    not(not_sel, sel);

    // AND gates for both input paths
    and(and0, in0, not_sel);  // AND between in0 and inverted sel
    and(and1, in1, sel);      // AND between in1 and sel

    // OR gate to select the output
    or(out, and0, and1);      // Output is the OR of both AND gates

endmodule

module shift_left_logical(input [63:0]a,input [4:0]b,output [63:0]out);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:shift_gen
            wire slt;
            wire [63:0] shift_amount;  
            assign shift_amount = {59'b0, b}; // Zero-extend b to 64 bits
            wire [63:0] i_extended;
            assign i_extended = {57'b0,i[6:0]};
            set_less_than slt_inst(.a(i_extended), .b(shift_amount), .less(slt)); //i<b
            mux2 sll_mux(.sel(slt), .in0(a[i-b]), .in1(1'b0), .out(out[i]));
        
        end
    endgenerate
endmodule
`endif 