// Seven-segment driver. Outputs hex values
module sevenSegDriver(input logic [3:0] digit,
			output logic ca,
			output logic cb,
			output logic cc,
			output logic cd,
			output logic ce,
			output logic cf,
			output logic cg);
  

   // convert digit to 7-segs
   logic [6:0] segs;
   assign {ca, cb, cc, cd, ce, cf, cg} = ~segs;

   always_comb begin
      case (digit)
         4'h0:   segs = 7'b1111110;
   	 4'h1:   segs = 7'b0110000;
 	 4'h2:   segs = 7'b1101101;
	 4'h3:   segs = 7'b1111001;
	 4'h4:   segs = 7'b0110011;
	 4'h5:   segs = 7'b1011011;
	 4'h6:   segs = 7'b1011111;
	 4'h7:   segs = 7'b1110000;
 	 4'h8:   segs = 7'b1111111;
	 4'h9:   segs = 7'b1111011;
	 4'ha:   segs = 7'b1110111;
 	 4'hb:   segs = 7'b0011111;
  	 4'hc:   segs = 7'b1001110;
	 4'hd:   segs = 7'b0111101;
	 4'he:   segs = 7'b1001111;
	 4'hf:   segs = 7'b1000111;
         default: segs = 7'b0000000;
      endcase
   end
endmodule
