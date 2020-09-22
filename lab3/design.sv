// Top level design connects the Room FSM, the Sword FSM, 
// and the seven-segment display for debugging
module top(input logic clk,
            input logic reset,
            input logic north,
            input logic south,
            input logic east,
            input logic west,
            output logic win,
            output logic dead,
            output logic v,
            output logic [6:0] segs
            );
  
  // internal signals
  logic sw;                 // has sword
  logic [2:0] state;        // current room state, for debugging

  // create the room FSM
  roomFSM rooms(.clk, .reset, .north, .south, .east, .west, .v, 
                .win, .dead, .sw, .state);

  // create the sword FSM
  swordFSM sword(.clk, .reset, .sw, .v);

  // for debugging, display the state on the seven-segment display
  sevenSegDriver stateDisplay(.digit({1'b0, state}), 
                      .ca(segs[6]), .cb(segs[5]), .cc(segs[4]),
                      .cd(segs[3]), .ce(segs[2]), .cf(segs[1]),
                      .cg(segs[0]));
  
endmodule


// Code the design of your Room FSM here
module roomFSM( input logic clk,
             input logic reset,
             input logic north,
             input logic south,
             input logic east,
             input logic west,
             input logic v,
             output logic win,
             output logic dead,
             output logic sw,
             output logic [2:0] state);

  // FIXME: Complete the implementation 

endmodule

module swordFSM(input logic clk,
            input logic reset,
            input logic sw,
            output logic v);
  

  // FIXME: Complete the implementation
  
endmodule


// Seven-segment driver. Outputs hex values
module sevenSegDriver(input logic [3:0] digit,
			output logic ca,
			output logic cb,
			output logic cc,
			output logic cd,
			output logic ce,
			output logic cf,
			output logic cg);


  // FIXME: Include your module from Lab 2
  
endmodule
