`ifndef EX
`define EX

// `ifndef ADD_V
// `define ADD_V
// `include "ADD.v"
// `endif

// `ifndef SUB_V
// `define SUB_V
// `include "SUB.v"
// `endif

// `ifndef AND_V
// `define AND_V
// `include "AND.v"
// `endif

// `ifndef OR_V
// `define OR_V
// `include "OR.v"
// `endif

// `ifndef NOT_V
// `define NOT_V
// `include "NOT.v"
// `endif

// `ifndef FULL_ADDER_V
// `define FULL_ADDER_V
// `include "full_adder.v"
// `endif

// `ifndef NEG_V
// `define NEG_V
// `include "NEG.v"
// `endif
`include "add_gen.v"
`include "alu_control.v"
`include "MUX2.v"
`include "ALU.v"


module EX(
    input [63:0] PC,
    input [63:0] immediate,
    input [2:0] funct3,
    input [6:0] funct7,
    input ALUSrc,
    input branch,
    input [1:0]ALUOp,
    input [63:0] read_data1,read_data2,
    input [1:0] ForwardA,
    input [1:0] ForwardB,
    input [63:0] MEM_ALU_Out,
    input [63:0] WB_ALU_Out,

    output [63:0] branch_address,
    output [63:0] ALU_out,
    output [63:0] input_data_for_mem,
    output PCSrc

    );
    wire [63:0] dummy,selected_A,selected_B;
    wire [3:0] alu_op_to_alu;
    wire zero_to_and_gate;
    
    

    assign selected_A=(ForwardA==2'b00)?read_data1:
                      (ForwardA==2'b01)?WB_ALU_Out:
                      (ForwardA==2'b10)?MEM_ALU_Out:64'bx;

     assign dummy=(ForwardB==2'b00)?read_data2:
                      (ForwardB==2'b01)?WB_ALU_Out:
                      (ForwardB==2'b10)?MEM_ALU_Out:64'bx;

    assign selected_B=(ALUSrc==0) ? dummy : immediate; // one of choices in B
    assign input_data_for_mem=dummy;

    alu_control u2(
        .funct7(funct7),
        .funct3(funct3),
        .alu_op(ALUOp),
        .alu_ctl(alu_op_to_alu)
    );
    ALU_64 u3(
        .A(selected_A),
        .B(selected_B),
        .ALU_control(alu_op_to_alu),
        .out(ALU_out),
        .zero(zero_to_and_gate)
    );
    add_gen u4(
        .pc(PC),
        .immediate(immediate),
        .branch_address(branch_address)
    );
    assign PCSrc = branch & zero_to_and_gate;
    assign zero=zero_to_and_gate;

    
endmodule
//delete after confirming


// module MUX2(
//     input wire in0,
//     input wire in1,
//     input wire ALUSrc,
//     output wire out
// );
//     assign out = (ALUSrc==0) ? in0 : in1;
// endmodule

// module ALU_64(
//     input [63:0] A,
//     input [63:0] B,
//     input [3:0] ALU_control,
//     output [63:0] out,
//     output zero
// );
//     wire [63:0] add_out, sub_out, and_out, or_out, z1;
//     wire Overflow, Cout;
//     wire zero;
//     reg [63:0] temp;
//     reg z2;

//     ADD_64 add1(A, B, 1'b0, add_out, Cout, Overflow);
//     SUB_64 sub1(A, B, sub_out, Overflow);
//     SUB_64 sub2(A, B, z1, Overflow);
//     AND_64 and1(A, B, and_out);
//     OR_64 or1(A, B, or_out);

//     // zero flag implementation
//    always @(*)
//    begin
//         case(z1)
//             64'd0: z2 = 1'b1;
//             default: z2 = 1'b0;
//         endcase
//    end
//    assign zero = z2;

//     // ALU output implementation
//    always @(*)
//    begin
//         case(ALU_control)
//             4'b0010: temp = add_out;
//             4'b0110: temp = sub_out;
//             4'b0000: temp = and_out;
//             4'b0001: temp = or_out;
//             default: temp = 64'b0;
//         endcase
//    end
//     assign out = temp;

// endmodule

// module alu_control(input[6:0]funct7,input[2:0]funct3,input [1:0]alu_op,output reg [3:0]alu_ctl);

//     always @(*) begin
//         case(alu_op)
//         2'b00:begin
//             alu_ctl=4'b0010;
//         end
//         2'b01:begin
//             alu_ctl=4'b0110;
//         end
//         2'b10:begin
//             case(funct7)
//             7'b0000000:begin
//                 case(funct3)
//                 3'b000:begin
//                     alu_ctl=4'b0010; 
//                 end
//                 3'b110:begin
//                     alu_ctl=4'b0001;

//                 end
//                 3'b111:begin
//                     alu_ctl=4'b0000;
//                 end
//                 default:begin
//                       alu_ctl = 4'bxxxx; // Default value for undefined 
//                 end
//                 endcase
//             end
//             7'b0100000: begin
//                 alu_ctl=4'b0110;
//             end
//             default: begin
//                   alu_ctl = 4'bxxxx; // Default value for undefined 
//             end

//             endcase
//         end
//         default: begin
//               alu_ctl = 4'bxxxx; // Default value for undefined funct3
//         end
//     endcase
//     end
// endmodule
`endif