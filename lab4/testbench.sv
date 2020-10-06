// Testbench to test one of the turn signals.
module turnSignal_tb();
  
  logic clk;
  logic reset;
  logic signal;
  logic sa, sb, sc;
  logic saExpected, sbExpected, scExpected;
  
  integer vectornum, errors;
  logic [3:0] testvectors[999:0];
  
  // instantiate uut  
  turnSignal uut(.clk, .reset, .signal, .sa, .sb, .sc);
  
  // generate the clock
  always begin
    clk = 1; #5;
    clk = 0; #5;
  end
  
  // load test vectors at beginning of simulation
  initial begin
    $dumpfile("dump.vcd"); $dumpvars(1);
    
    $readmemb("testvectors.txt", testvectors);
    
    vectornum = 0;
    errors = 0;
    
    // reset the system
    reset = 1; #27; reset = 0;
  end
  
  // apply test vector on falling edg of clk
  always @(negedge clk) begin
    {signal, scExpected, sbExpected, saExpected} = testvectors[vectornum];
  end
  
  // check results after rising edge
  always @(posedge clk) begin
    if (~reset) begin
      #2;		// delay to let output settle
      
      if ( {sc, sb, sa} !== {scExpected, sbExpected, saExpected} ) begin
        errors += 1;
        
        $display("Error: Output %b -- expected %b\n",
                 {sc, sb, sa}, {scExpected, sbExpected, saExpected});
      end
      
      vectornum += 1;
      
      // end of tests?
      if (testvectors[vectornum] === 4'bx) begin
        $display("%d tests completed with %d errors",
                 vectornum, errors);
        $finish;
      end
    end
  end
endmodule
  
