`ifndef MUX2
`define MUX2
module mux2 (input sel,  input in0, input in1,output out  );
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
`endif 
