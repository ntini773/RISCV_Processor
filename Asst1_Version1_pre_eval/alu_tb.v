`include "alu.v"


// module testbench;
//     reg [63:0] a, b;
//     reg [3:0] alu_op;
//     wire [63:0] out;

//     // Instantiate the ALU module
//     alu uut (
//         .a(a),
//         .b(b),
//         .alu_op(alu_op),
//         .out(out)
//     );

//     initial begin
//         // Test Addition
//         a = 64'd15; 
//         b = 64'd10; 
//         alu_op = 4'b0000; // Add
//         #10;
//         $display("ADD:  a = %0d, b = %0d, out = %0d", $signed(a), $signed(b), $signed(out));

//         // Test Subtraction
//         a = 64'd20;
//         b = 64'd25;
//         alu_op = 4'b0001; // Subtract
//         #10;
//         $display("SUB:  a = %0d, b = %0d, out = %0d", $signed(a), $signed(b), $signed(out));

//         // Test Bitwise AND
//         a = 64'hF0F0F0F0F0F0F0F0;
//         b = 64'h0F0F0F0F0F0F0F0F;
//         alu_op = 4'b0010; // AND
//         #10;
//         $display("AND:  a = %b, b = %b, out = %b", a, b, out);

//         // Test Bitwise OR
//         alu_op = 4'b0011; // OR
//         #10;
//         $display("OR:   a = %b, b = %b, out = %b", a, b, out);

//         // Test Bitwise XOR
//         alu_op = 4'b0100; // XOR
//         #10;
//         $display("XOR:  a = %b, b = %b, out = %b", a, b, out);

//         // Test Shift Left Logical
//         a = 64'd5; 
//         b = 64'd2; 
//         alu_op = 4'b0101; // Shift Left
//         #10;
//         $display("SLL:  a = %0d, b = %0d, out = %0d", $signed(a), $signed(b), $signed(out));

//         // Test Shift Right Logical
//         a = 64'd64; 
//         b = 64'd2;
//         alu_op = 4'b0110; // Shift Right Logical
//         #10;
//         $display("SRL:  a = %0d, b = %0d, out = %0d", $signed(a), $signed(b), $signed(out));

//         // Test Shift Right Arithmetic
//         a = -64'd64; 
//         b = 64'd2;
//         alu_op = 4'b0111; // Shift Right Arithmetic
//         #10;
//         $display("SRA:  a = %0d, b = %0d, out = %0d", $signed(a), $signed(b), $signed(out));

//         // Test Set Less Than (Signed)
//         a = -64'd10;
//         b = 64'd5;
//         alu_op = 4'b1000; // SLT
//         #10;
//         $display("SLT:  a = %0d, b = %0d, out = %0d", $signed(a), $signed(b), $signed(out));

//         // Test Set Less Than Unsigned
//         a = 64'b10; // -1 in signed, max in unsigned
//         b = 64'b01; 
//         alu_op = 4'b1001; // SLTU
//         #10;
//         $display("SLTU: a = %0d, b = %0d, out = %0d", $signed(a), $signed(b), $signed(out));

//         $finish;
//     end
// endmodule

// `timescale 1ns/1ps

// module alu_tb;
//     reg [63:0] a, b;
//     reg [3:0] alu_op;
//     wire [63:0] out;
    
//     alu uut (
//         .a(a),
//         .b(b),
//         .alu_op(alu_op),
//         .out(out)
//     );

//     initial begin
//         $display("Starting ALU Testbench...");

//         // Test Addition (alu_op = 0000)
//         alu_op = 4'b0000;
//         a = 64'd5;    b = 64'd3;    #10; $display("ADD: %d + %d = %d", a, b, out);
//         a = -64'd10;  b = 64'd7;    #10; $display("ADD: %d + %d = %d", a, b, out);
//         a = 64'd1000; b = 64'd2000; #10; $display("ADD: %d + %d = %d", a, b, out);
//         a = -64'd50;  b = -64'd25;  #10; $display("ADD: %d + %d = %d", a, b, out);
//         a = 64'h7FFFFFFFFFFFFFFF; b = 64'd1; #10; $display("ADD: %d + %d = %d", a, b, out);

//         // Test Subtraction (alu_op = 0001)
//         alu_op = 4'b0001;
//         a = 64'd9;    b = 64'd4;    #10; $display("SUB: %d - %d = %d", a, b, out);
//         a = 64'd0;    b = 64'd1;    #10; $display("SUB: %d - %d = %d", a, b, out);
//         a = -64'd100; b = -64'd50;  #10; $display("SUB: %d - %d = %d", a, b, out);
//         a = 64'd1000; b = 64'd500;  #10; $display("SUB: %d - %d = %d", a, b, out);
//         a = 64'h7FFFFFFFFFFFFFFF; b = 64'h7FFFFFFFFFFFFFFF; #10; $display("SUB: %d - %d = %d", a, b, out);

//         // Test AND (alu_op = 0010)
//         alu_op = 4'b0010;
//         a = 64'b00001111; b = 64'b00111100; #10; $display("AND: %b & %b = %b", a, b, out);
//         a = 64'b10101010; b = 64'b01010101; #10; $display("AND: %b & %b = %b", a, b, out);
//         a = 64'hFFFFFFFFFFFFFFFF; b = 64'hF0F0F0F0F0F0F0F0; #10; $display("AND: %b & %b = %b", a, b, out);
//         a = 64'b00000000; b = 64'b11111111; #10; $display("AND: %b & %b = %b", a, b, out);

//         // Test OR (alu_op = 0011)
//         alu_op = 4'b0011;
//         a = 64'b00001111; b = 64'b00111100; #10; $display("OR: %b | %b = %b", a, b, out);
//         a = 64'b10101010; b = 64'b01010101; #10; $display("OR: %b | %b = %b", a, b, out);
//         a = 64'hFFFFFFFFFFFFFFFF; b = 64'hF0F0F0F0F0F0F0F0; #10; $display("OR: %b | %b = %b", a, b, out);

//         // Test XOR (alu_op = 0100)
//         alu_op = 4'b0100;
//         a = 64'b00001111; b = 64'b00111100; #10; $display("XOR: %b ^ %b = %b", a, b, out);
//         a = 64'b10101010; b = 64'b01010101; #10; $display("XOR: %b ^ %b = %b", a, b, out);
        
//         // Test Shift Left (alu_op = 0101)
//         alu_op = 4'b0101;
//         a = 64'b0000000000000000000000000000000000000000000000000000000000001111;
//         b = 64'd2; #10; $display("SLL: %b << %d = %b", a, b, out);

//         // Test Shift Right Logical (alu_op = 0110)
//         alu_op = 4'b0110;
//         a = 64'b1111000000000000000000000000000000000000000000000000000000000000;
//         b = 64'd2; #10; $display("SRL: %b >> %d = %b", a, b, out);

//         // Test Shift Right Arithmetic (alu_op = 0111)
//         alu_op = 4'b0111;
//         a = 64'b1000000000000000000000000000000000000000000000000000000000000000;
//         b = 64'd2; #10; $display("SRA: %b >> %d = %b", a, b, out);

//         // Test Set Less Than (alu_op = 1000)
//         alu_op = 4'b1000;
//         a = 64'd10; b = 64'd20; #10; $display("SLT: %d < %d = %d", a, b, out);
//         a = -64'd10; b = 64'd5; #10; $display("SLT: %d < %d = %d", a, b, out);

//         // Test Set Less Than Unsigned (alu_op = 1001)
//         alu_op = 4'b1001;
//         a = 64'd10; b = 64'd20; #10; $display("SLTU: %d < %d = %d", a, b, out);
//         a = 64'hFFFFFFFFFFFFFFFF; b = 64'd5; #10; $display("SLTU: %d < %d = %d", a, b, out);

//         $display("ALU Testbench Completed.");
//         $stop;
//     end
// endmodule


module alu_tb;
    reg [63:0] a, b;
    reg [3:0] alu_op;
    wire [63:0] out;
    wire cout;
    wire borrow;
    wire overflowadd;
    wire overflowsub;
    
    alu uut (
        .a(a),
        .b(b),
        .alu_op(alu_op),
        .out(out),
        .cout(cout),
        .borrow(borrow),
        .overflowadd(overflowadd),
        .overflowsub(overflowsub)

    );

    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);
        $display("Starting ALU Testbench...");

        // Test Addition (alu_op = 0000)
        alu_op = 4'b0000;
        a = 64'd5;    b = 64'd3;    #10; $display("ADD: %d + %d = %d", $signed(a), $signed(b), $signed(out));
        a = -64'd10;  b = 64'd7;    #10; $display("ADD: %d + %d = %d", $signed(a), $signed(b), $signed(out));
        a = 64'd1000; b = 64'd2000; #10; $display("ADD: %d + %d = %d", $signed(a), $signed(b), $signed(out));
        a = -64'd50;  b = -64'd25;  #10; $display("ADD: %d + %d = %d", $signed(a), $signed(b), $signed(out));

        // Test Subtraction (alu_op = 0001)
        alu_op = 4'b0001;
        a = 64'd9;    b = 64'd4;    #10; $display("SUB: %d - %d = %d", $signed(a), $signed(b), $signed(out));
        a = 64'd0;    b = 64'd1;    #10; $display("SUB: %d - %d = %d", $signed(a), $signed(b), $signed(out));
        a = -64'd100; b = -64'd50;  #10; $display("SUB: %d - %d = %d", $signed(a), $signed(b), $signed(out));
        a = 64'd1000; b = 64'd500;  #10; $display("SUB: %d - %d = %d", $signed(a), $signed(b), $signed(out));
        a = 64'h7FFFFFFFFFFFFFFF; b = 64'h7FFFFFFFFFFFFFFF; #10; $display("SUB: %d - %d = %d", $signed(a), $signed(b), $signed(out));

        // Test AND (alu_op = 0010)
        alu_op = 4'b0010;
        a = 64'hF0F0F0F0F0F0F0F0; b = 64'h0F0F0F0F0F0F0F0F; #10;
        $display("AND: %b & %b = %b", a, b, out);

        // Test OR (alu_op = 0011)
        alu_op = 4'b0011;
        a = 64'hF0F0F0F0F0F0F0F0; b = 64'h0F0F0F0F0F0F0F0F; #10;
        $display("OR:  %b | %b = %b", a, b, out);

        // Test XOR (alu_op = 0100)
        alu_op = 4'b0100;
        a = 64'hF0F0F0F0F0F0F0F0; b = 64'h0F0F0F0F0F0F0F0F; #10;
        $display("XOR: %b ^ %b = %b", a, b, out);

        // Test Shift Left (alu_op = 0101)
        alu_op = 4'b0101;
        a = 64'd15; b = 64'd2; #10;
        $display("SLL: %d << %d = %d", $signed(a), $signed(b), $signed(out));

        // Test Shift Right Logical (alu_op = 0110)
        alu_op = 4'b0110;
        a = 64'hFFFFFFFFFFFFFFFF; b = 64'd2; #10;
        $display("SRL: %b >> %d = %b", a, b, out);

        // Test Shift Right Arithmetic (alu_op = 0111)
        alu_op = 4'b0111;
        a = -64'd64; b = 64'd2; #10;
        $display("SRA: %d >> %d = %d", $signed(a), $signed(b), $signed(out));

        // Test Set Less Than (SLT, alu_op = 1000)
        alu_op = 4'b1000;
        a = 64'd10; b = 64'd20; #10;
        $display("SLT: %d < %d = %d", $signed(a), $signed(b), $signed(out));
        a = -64'd10; b = 64'd5; #10;
        $display("SLT: %d < %d = %d", $signed(a), $signed(b), $signed(out));

        // Test Set Less Than Unsigned (SLTU, alu_op = 1001)
        alu_op = 4'b1001;
        a = 64'd10; b = 64'd20; #10;
        $display("SLTU: %d < %d = %d", a, b, out);
        a = 64'hFFFFFFFFFFFFFFFF; b = 64'd5; #10;
        $display("SLTU: %d < %d = %d", a, b, out);

        $display("ALU Testbench Completed.");
        $finish;
    end
endmodule
