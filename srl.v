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


module shift_right_logical(input [63:0]a,input [4:0]b,output [63:0]out);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:shift
            wire slt;
            wire [63:0]shift_amount;
            assign shift_amount = {59'b0,b};
            wire [63:0] shift_value = 64 - i;

            set_less_than slt1(.a(shift_amount),.b(shift_value),.less(slt)); //b<64-i

            mux2 srlmux(.sel(slt), .in0(1'b0), .in1(a[i+b]), .out(out[i]));
        end
    endgenerate
endmodule
