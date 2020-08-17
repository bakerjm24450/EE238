// 3-input majority gate
// Output is 1 if majority of inputs are 1
module majority(input logic a,
                input logic b,
                input logic c,
                output logic y);
  
  assign y = (a & b) | (a & c) | (b & c);

endmodule
