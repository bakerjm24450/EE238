// Testbench for 011 pattern detector

module fsm_011_tb();
  logic clk;
  logic reset;
  logic a;
  logic y;
  logic yExpected;
  
  integer vectornum, errors;
  logic [1:0] testvectors[10000:0];
  
  // instantiate uut
  fsm_011 uut(.clk, .reset, .a, .y);
  
  // generate clock
  always begin
    clk = 1; #5; clk = 0; #5;
  end
  
  // load test vectors at beginning of simulation
  initial begin
    $dumpfile("dump.vcd"); $dumpvars();
    $readmemb("testvectors.txt", testvectors);
    vectornum = 0; errors = 0;
    $display("a   y");
    $display("-----");
    reset = 1; #27; reset = 0;
  end
  
  // apply test vector on falling edge of clk
  // so they're stable before rising edge
  always @(negedge clk) begin
    {a, yExpected} = testvectors[vectornum];
  end
  
  // check results after rising edge
  always @(posedge clk)
    if (~reset) begin     // skip when we're resetting
      #2;                  // delay for propagation
      
      if (y !== yExpected) begin
        $display("%b   %b -- ERROR: expected %b", a, y, yExpected);
        errors += 1;
      end
      else begin
        $display("%b   %b", a, y);
      end
      
      vectornum += 1;
      
      if (testvectors[vectornum] === 2'bx) begin
        $display("%d tests completed with %d errors",
                 vectornum, errors);
        $finish;
      end
    end
endmodule