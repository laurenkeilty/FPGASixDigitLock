// The following module, designed for use on the DE1-SOC Board, has a built in six-digit passcode "603613" that
// when entered, causes the board to display "OPEN", otherwise the board displays "CLOSED". It takes binary input values
// from the first four switches of the board, displaying the equivalent decimal value on the built in seven segment displays.
// To start and reset, press the first and fourth buttons on the board simultaneously. Then enter each binary number by first
// setting the switches to the desired value, and then by pressing the first button on the board. After all six digits have been
// entered this way, the board will display "OPEN" or "CLOSED", based on whether the six digits entered match the passcode "603613"

// This module and related testbenches were built by Lauren Keilty and Mudasser Jalal for UBC course CPEN 211 in Fall 2023.
// They have since been edited for clarity and republished by Lauren Keilty in Summer 2025
// Individual and group contributions are visible in "Contributions.txt" file

module lab3_top(SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
  // switches 1-10
  input [9:0] SW;
  // buttons 1-4
  input [3:0] KEY;
  // seven segment displays 1-6
  output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

  wire clk = ~KEY[0];  // clk is active low, and is controlled by the pressing of the first button on the board
  wire rst_n = ~KEY[3]; // reset is synchronous (must be active with the clk to activate) and active-low, controlled by the fourth button on he board

  reg incorrectCombo; // this stores whether or not an incorrect value has been entered (high) or not (low)
  reg comboEnd; // this stores whether six digits have been processed yet (high) or not (low)

  reg [5:0] state; //this holds the one-hot-encoded states for the state machine
  
  
// state machine with one-hot encoding
  always @(posedge clk) begin

    // checks that when reset is high (button pressed), the state is reset, the comboEnd is reset, and incorrectCombo is reset
    if(rst_n == 1'b1) 
      begin
        state <= 6'b000_001;
        comboEnd <= 1'b0;
        incorrectCombo <= 1'b0;
      end 

    // otherwise, execute the following state machine to intake numerical inputs from the board switches (SW[3:0])
    else begin
      case(state)
        6'b000_001:
          begin
            // if the switch input is not 6, set incorrect combo high
            if(SW[3:0] != 4'b0110)
              incorrectCombo <= 1'b1;
            // shift the state left by 1 to next one-hot encoding
            state <= state << 1;
          end

        6'b000_010:
          begin
            // if the switch input is not 0, set incorrect combo high
            if(SW[3:0] != 4'b0000)
              incorrectCombo <= 1'b1;
            // shift the state left by 1 to next one-hot encoding
            state <= state << 1;
          end
        6'b000_100:
          begin
            // if the switch input is not 3, set incorrect combo high
            if(SW[3:0] != 4'b0011)
              incorrectCombo <= 1'b1;
            // shift the state left by 1 to next one-hot encoding
            state <= state << 1;
          end
        6'b001_000:
          begin
            // if the switch input is not 6, set incorrect combo high
            if(SW[3:0] != 4'b0110)
              incorrectCombo <= 1'b1;
            // shift the state left by 1 to next one-hot encoding
            state <= state << 1;
          end  
        6'b010_000:
          begin
            // if the switch input is not 1, set incorrect combo high
            if(SW[3:0] != 4'b0001)
              incorrectCombo <= 1'b1;
            // shift the state left by 1 to next one-hot encoding
            state <= state << 1;
          end  
        6'b100_000:
          begin
            // if the switch input is not 3, set incorrect combo high
            if(SW[3:0] != 4'b0011)
              incorrectCombo <= 1'b1;
            // set combo end high to indicate all values have been recieved
            comboEnd <= 1'b1;
          end  

        // default encoding
        default: 
          state <= 6'bxxxxxx;
      endcase
    end
  end 


// seven segment display controls
 always @* begin
    
    // outputs if the comboEnd is activated
    // displays "OPEN" on seven segment dispay once combo end is activated and if incorrectCombo has not been activated
    if(incorrectCombo == 1'b0 && comboEnd == 1'b1) begin
      HEX0 = 7'b0101011; //letter n
      HEX1 = 7'b0000110; //letter E
      HEX2 = 7'b0001100; //letter P
      HEX3 = 7'b1000000; //letter O
      HEX4 = 7'b1111111; // null
      HEX5 = 7'b1111111; // null
    end
    //displays "CLOSED" once combo end is reached and if incorrectCombo has been activated
    else if(incorrectCombo == 1'b1 && comboEnd == 1'b1) begin
      HEX0 = 7'b1000000; //letter D 
      HEX1 = 7'b0000110; //letter E
      HEX2 = 7'b0010010; //letter s
      HEX3 = 7'b1000000; //letter O 
      HEX4 = 7'b1000111; //letter L
      HEX5 = 7'b1000110; //letter C
    end


    // seven segment display outputs if comboEnd is not activated (the decimal decoding of the binary inputs on the first four switches of the board)
    // linked to the status of the board switches at all times outside of when comboEnd is high
    else begin
      case(SW[3:0])
        4'b0000: begin 
          HEX0 = 7'b1000000; // digit 0
          HEX1 = 7'b1111111; // null
          HEX2 = 7'b1111111; // null
          HEX3 = 7'b1111111; // null
          HEX4 = 7'b1111111; // null
          HEX5 = 7'b1111111; // null
        end
        4'b0001: begin 
          HEX0 = 7'b1111001; // digit 1
          HEX1 = 7'b1111111; // null
          HEX2 = 7'b1111111; // null
          HEX3 = 7'b1111111; // null
          HEX4 = 7'b1111111; // null
          HEX5 = 7'b1111111; // null
        end
        4'b0010: begin 
          HEX0 = 7'b0100100; // digit 2
          HEX1 = 7'b1111111; // null
          HEX2 = 7'b1111111; // null
          HEX3 = 7'b1111111; // null
          HEX4 = 7'b1111111; // null
          HEX5 = 7'b1111111; // null
        end
        4'b0011: begin 
          HEX0 = 7'b0110000; // digit 3
          HEX1 = 7'b1111111; // null
          HEX2 = 7'b1111111; // null
          HEX3 = 7'b1111111; // null
          HEX4 = 7'b1111111; // null
          HEX5 = 7'b1111111; // null
        end
        4'b0100: begin 
          HEX0 = 7'b0011001; // digit 4
          HEX1 = 7'b1111111; // null
          HEX2 = 7'b1111111; // null
          HEX3 = 7'b1111111; // null
          HEX4 = 7'b1111111; // null
          HEX5 = 7'b1111111; // null
        end
        4'b0101: begin 
          HEX0 = 7'b0010010; // digit 5
          HEX1 = 7'b1111111; // null
          HEX2 = 7'b1111111; // null
          HEX3 = 7'b1111111; // null
          HEX4 = 7'b1111111; // null
          HEX5 = 7'b1111111; // null
        end
        4'b0110: begin 
          HEX0 = 7'b0000010; // digit 6
          HEX1 = 7'b1111111; // null
          HEX2 = 7'b1111111; // null
          HEX3 = 7'b1111111; // null
          HEX4 = 7'b1111111; // null
          HEX5 = 7'b1111111; // null
        end
        4'b0111: begin 
          HEX0 = 7'b1111000; // digit 7
          HEX1 = 7'b1111111; // null
          HEX2 = 7'b1111111; // null
          HEX3 = 7'b1111111; // null
          HEX4 = 7'b1111111; // null
          HEX5 = 7'b1111111; // null
        end
        4'b1000: begin 
          HEX0 = 7'b0000000; // digit 8
          HEX1 = 7'b1111111; // null
          HEX2 = 7'b1111111; // null
          HEX3 = 7'b1111111; // null
          HEX4 = 7'b1111111; // null
          HEX5 = 7'b1111111; // null
          end
        4'b1001: begin
          HEX0 = 7'b0011000; // digit 9
          HEX1 = 7'b1111111; // null
          HEX2 = 7'b1111111; // null
          HEX3 = 7'b1111111; // null
          HEX4 = 7'b1111111; // null
          HEX5 = 7'b1111111; // null
          end
        4'b1010: begin 
          HEX0 = 7'b0001000; // letter R
          HEX1 = 7'b1000000; // letter O
          HEX2 = 7'b0001000; // letter R
          HEX3 = 7'b0001000; // letter R
          HEX4 = 7'b0000110; // letter E
          HEX5 = 7'b1111111; // null
          end
        4'b1011: begin 
          HEX0 = 7'b0001000; // letter R
          HEX1 = 7'b1000000; // letter O
          HEX2 = 7'b0001000; // letter R
          HEX3 = 7'b0001000; // letter R
          HEX4 = 7'b0000110; // letter E
          HEX5 = 7'b1111111; // null
          end
        4'b1100: begin 
          HEX0 = 7'b0001000; // letter R
          HEX1 = 7'b1000000; // letter O
          HEX2 = 7'b0001000; // letter R
          HEX3 = 7'b0001000; // letter R
          HEX4 = 7'b0000110; // letter E
          HEX5 = 7'b1111111; // null
          end
        4'b1101: begin 
          HEX0 = 7'b0001000; // letter R
          HEX1 = 7'b1000000; // letter O
          HEX2 = 7'b0001000; // letter R
          HEX3 = 7'b0001000; // letter R
          HEX4 = 7'b0000110; // letter E
          HEX5 = 7'b1111111; // null
          end
        4'b1110: begin 
          HEX0 = 7'b0001000; // letter R
          HEX1 = 7'b1000000; // letter O
          HEX2 = 7'b0001000; // letter R
          HEX3 = 7'b0001000; // letter R
          HEX4 = 7'b0000110; // letter E
          HEX5 = 7'b1111111; // null
          end
        4'b1111: begin
          HEX0 = 7'b0001000; // letter R
          HEX1 = 7'b1000000; // letter O
          HEX2 = 7'b0001000; // letter R
          HEX3 = 7'b0001000; // letter R
          HEX4 = 7'b0000110; // letter E
          HEX5 = 7'b1111111; // null
          end

        // default
        default: begin
          HEX0 = 7'bXXXXXXX;      
          HEX1 = 7'bXXXXXXX;
          HEX2 = 7'bXXXXXXX;
          HEX3 = 7'bXXXXXXX;
          HEX4 = 7'bXXXXXXX;
          HEX5 = 7'bXXXXXXX;
          end
      endcase
    end
  end
endmodule
