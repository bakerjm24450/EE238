// Testbench for adventure game 

module adventureGame_tb();
  
  // input and output ports of uut
  logic clk;
  logic reset;
  logic north;
  logic south;
  logic east;
  logic west;
  logic v;
  logic win;
  logic dead;
  logic [6:0] segs;

  // expected outputs
  logic vExpected;
  logic winExpected;
  logic deadExpected;
  
  // counters
  integer vectornum, errors;
  logic [7:0] testvectors[10000:0];
  
  // instantiate uut
  top uut(.clk, .reset, .north, .south, .east, .west,
         .win, .dead, .v, .segs);
  
  // generate clock
  always begin
    clk = 1; #5; clk = 0; #5;
  end
  
  // load test vectors at beginning of simulation
  initial begin
    $dumpfile("dump.vcd"); $dumpvars(1);
    $readmemb("testvectors.txt", testvectors);
    vectornum = 0; errors = 0;
    
    reset = 1;
  end
  
 // apply test vector on falling edge of clk
  // so they're stable before rising edge
  always @(negedge clk) begin
    {reset, north, south, east, west, 
    	vExpected, winExpected, deadExpected} = testvectors[vectornum];
  end
  
  // check results after rising edge
  always @(posedge clk) begin
    if (~reset) begin
      #2;                  // delay for propagation
      
      if ({v, win, dead} !== {vExpected, winExpected, deadExpected}) begin
        $display("%b   %b -- ERROR: expected %b", 
                 {north, south, east, west}, {v, win, dead},
                 {vExpected, winExpected, deadExpected});
        errors += 1;
      end
    end
      
    vectornum += 1;
      
    if (testvectors[vectornum] === 8'bx) begin
      $display("%d tests completed with %d errors",
               vectornum, errors);
      $finish;
    end
  end
   
endmodule
