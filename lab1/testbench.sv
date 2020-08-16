// Testbench for 3-input minority gate
module minority_tb();
  
  logic a;
  logic b;
  logic c;
  logic y;

  // instantiate the unit-under-test
  minority uut(.a, .b, .c, .y);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    // apply inputs
    a = 0; b = 0; c = 0; #10;
    assert(y == 1) else $display("Error: 000");

    a = 0; b = 0; c = 1; #10;
    assert(y == 1) else $display("Error: 001");

    a = 0; b = 1; c = 0; #10;
    assert(y == 1) else $display("Error 010");

    a = 0; b = 1; c = 1; #10;
    assert(y == 0) else $display("Error 011");

    a = 1; b = 0; c = 0; #10;
    assert(y == 1) else $display("Error 100");
   
    a = 1; b = 0; c = 1; #10;
    assert(y == 0) else $display("Error 101");

    a = 1; b = 1; c = 0; #10;
    assert(y == 0) else $display("Error 110");

    a = 1; b = 1; c = 1; #10;
    assert(y == 0) else $display("Error 111");
    
  end
endmodule
