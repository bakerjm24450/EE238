// Testbench for seven-segment driver that outputs hex values.
module sevenSegDriver_tb();
  
  // input digit
  logic [3:0] digit;
  
  // seven-segment display
  logic ca;
  logic cb;
  logic cc;
  logic cd;
  logic ce;
  logic cf;
  logic cg;
  
  // unit under test
  sevenSegDriver uut(.digit, .ca, .cb, .cc, .cd, .ce, .cf, .cg);
  
  // loop counter
  integer i;
  
  initial begin
    // set up EPWave
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    for (i = 0; i <= 16; i += 1) begin
      // apply input to digit
      digit = i;
      
      // delay a little
      #10;
    end
  end
endmodule
  