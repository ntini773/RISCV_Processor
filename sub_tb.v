'include "sub.v"
module test_64bit_Subtractor;
    
    // Inputs
    reg [63:0] a;
    reg [63:0] b;
    
    // Outputs
    wire [63:0] difference;
    wire borrow;
    
    // Instantiate the Unit Under Test (UUT)
    bit_Subtractor uut (
        .a(a), 
        .b(b), 
        .difference(difference), 
        .borrow(borrow)
    );
    
    initial begin
        // Initialize Inputs
        a = 64'h0000000000000000; 
        b = 64'h0000000000000000; 
        #10;
        
        // Test Case 1: Small number subtraction
        a = 64'h000000000000000A;
        b = 64'h0000000000000005;
        #10;
        
        // Test Case 2: Subtracting a larger number (should result in borrow)
        a = 64'h0000000000000005;
        b = 64'h000000000000000A;
        #10;
        
        // Test Case 3: Subtracting with all 1s (overflow case)
        a = 64'hFFFFFFFFFFFFFFFF;
        b = 64'h0000000000000001;
        #10;
        
        // Test Case 4: Subtracting same numbers (should result in zero)
        a = 64'h1234567890ABCDEF;
        b = 64'h1234567890ABCDEF;
        #10;
        
        // Test Case 5: Random large numbers
        a = 64'hFEDCBA9876543210;
        b = 64'h1234567890ABCDEF;
        #10;
        
        // Finish simulation
        $stop;
    end
    
    initial begin
        $monitor("Time=%0t | a=%0d | b=%0d | difference=%0d | borrow=%b", 
         $time, a, b, difference, borrow);
    end
    
endmodule
