'include "slt.v"
module shift_left_logical(input [63:0]a,input [4:0]b,output [63:0]out);
    genvar i;
    generate
        for(i=0;i<64;i=i+1) begin:shift_gen
            wire slt;
            wire [63:0] shift_amount;  
            assign shift_amount = {59'b0, b}; // Zero-extend b to 64 bits
            strictly_less slt_inst(.a(i), .b(shift_amount), .less(slt)); //i<b
            mux2 sll_mux(.sel(slt), .in0(a[i-b]), .in1(1'b0), .out(out[i]));
        end
    endgenerate
endmodule