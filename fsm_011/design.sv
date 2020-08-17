// Pattern detector for 011
module fsm_011(input logic clk,
                         input logic reset,
                         input logic a,
                         output logic [1:0] state,
                         output logic y);

   //typedef enum logic [1:0] {Sinit, S0, S01, S011} statetype;
   //statetype state, nextState;

   localparam Sinit = 2'b00,
            S0 = 2'b01,
            S01 = 2'b10,
            S011 = 2'b11;
   logic [1:0] nextState;

   // state register
   always_ff @(posedge clk)
      if (reset) state <= Sinit;
      else        state <= nextState;

   // next-state logic
   always_comb 
      case (state)
         Sinit:  nextState = a ? Sinit   : S0;
         S0:     nextState = a ? S01    : S0;
         S01:   nextState = a ? S011  : S0;
         S011: nextState = a ? Sinit   : S0;
         default: nextState = Sinit;    // shouldn't happen
      endcase

   // output logic
   assign y = (state == S011);
endmodule


// For synthesis, we'll use this top module so we can debounce the
// pushbutton input to use as the clock for our FSM.
module top(input logic clk100MHz,      // system clock
            input logic reset,   // reset signal from a switch
            input logic pushbutton, // pushbutton used as FSM clk
            input logic a,       // FSM input from a switch
            output logic [1:0] state,
            output logic resetOut,
            output logic y       // FSM output to an LED
            );
   
   logic buffered_clk;           // use global buffer on FPGA
   BUFG buff_clk(.I(clk100MHz), .O(buffered_clk));

   // debounce the pushbutton
   logic fsm_clk;
   debounce db1(.clk(buffered_clk), .reset, .in(pushbutton), .out(fsm_clk));

   // instantiate our FSM
   fsm_011 u0(.clk(fsm_clk), .reset, .a, .state, .y);

   assign resetOut = reset;
endmodule


// Debounce an external input (like a pushbutton). 
// This code is based on an example from https://www.fpga4student.com/2017/04/simple-debouncing-verilog-code-for.html
module debounce(input logic clk,       // system clock
               input logic reset,      // system reset
               input logic in,         // external input (bouncing)
               output logic out);      // debounced output

   logic slow_clk_en;         // clock enable signal
   logic q0, q1, q2;          // ff outputs

   // generate clock enable signal. This will be a single pulse at a slower freq than clk
   clock_enable u1(.clk, .reset, .clk_en(slow_clk_en));

   // external input goes through a FF to act as a synchronizer
   flopenr d0(.clk, .reset, .en(slow_clk_en), .d(in), .q(q0));

   // 2 more FF's to debounce
   flopenr d1(.clk, .reset, .en(slow_clk_en), .d(q0), .q(q1));
   flopenr d2(.clk, .reset, .en(slow_clk_en), .d(q1), .q(q2));

   // debounced output
   assign out = q1 & (~q2);
endmodule

// Generate slow clock enable signal. This is basically like a clock divider, but instead
// of generating a slower clock signal (which can lead to stability problems having multiple
// clocks in a circuit), we generate a single pulse at the slower frequency.
// For a 100MHz input clock and a 16-bit counter, the slower freq will be about 1.5 kHz
module clock_enable( input logic clk,        // input clock
                     input logic reset,      // system reset 
                     output logic clk_en);   // slower clock pulse
   logic [15:0] counter;

   always_ff @(posedge clk) begin
      if (reset) counter <= 16'b0;
      else counter <= counter + 1;
   end

   assign clk_en = &counter;     // single pulse when counter = all 1's
endmodule

// Flip flop with reset and clock enable
module flopenr(input logic clk,
               input logic reset,
               input logic en,
               input logic d,
               output logic q);
   always_ff @(posedge clk)
      if (reset) q <= 1'b0;
      else if (en) q <= d;
endmodule
