`include "add.v"
module test_bit_Adder;
    
    // Inputs
    reg [63:0] a;
    reg [63:0] b;
    reg cin;
    
    // Outputs
    wire [63:0] sum;
    wire cout;
    
    // Instantiate the Unit Under Test (UUT)
    bit_Adder uut (
        .a(a), 
        .b(b), 
        .cin(cin), 
        .sum(sum), 
        .cout(cout)
    );
    
    initial begin
        // Initialize Inputs
        a = 64'h0000000000000000; 
        b = 64'h0000000000000000; 
        cin = 1'b0;
        #10;
        
        // Test Case 1: Adding two small numbers
        a = 64'h0000000000000005;
        b = 64'h000000000000000A;
        cin = 1'b0;
        #10;
        
        // Test Case 2: Adding with carry-in
        a = 64'h00000000000000FF;
        b = 64'h0000000000000001;
        cin = 1'b1;
        #10;
        
        // Test Case 3: Large numbers addition
        a = 64'hFFFFFFFFFFFFFFFF;
        b = 64'h0000000000000001;
        cin = 1'b0;
        #10;
        
        // Test Case 4: Overflow condition
        a = 64'hFFFFFFFFFFFFFFFF;
        b = 64'hFFFFFFFFFFFFFFFF;
        cin = 1'b1;
        #10;
        
        // Test Case 5: Random values
        a = 64'h1234567890ABCDEF;
        b = 64'hFEDCBA0987654321;
        cin = 1'b0;
        #10;
        
        // Finish simulation
        $stop;
    end
    
    initial begin
        $monitor("Time=%0t | a=%d,b=%d,cin=%d,sum=%d,cout=%b", 
                 $time,a,b,cin,sum,cout);
    end
    
endmodule

