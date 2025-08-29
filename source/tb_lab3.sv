// The following module is a testbench for the file lab3_top.sv to be used in pre-synthesis RTL

module lab3_tb();
    reg [9:0] SW; // used to represent values set on switches
    reg [3:0] KEY; // used to represent values set on buttons, these are active-low
    reg error; // used to represent an error occuring in the textbench

    wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; // Seven segment display values

    // instantiate device under test
    lab3_top dut(SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    // The clock will consistently run on a 5 second low-high interval
    initial begin
        // Set first button to low
        KEY[0] = 1;
        // wait 5 timescale units ( 5tu )
        #5;
        forever begin
            // Set first button to high
            KEY[0] = 0; 
            // wait 5tu
            #5;
            // Set first button to low
            KEY[0] = 1;
            // wait 5tu
            #5;
        end
    end

    // testing scheme
    initial begin 

//************************ TEST INITIAL RESET TO STATE ONE ******************

        // set reset high
        KEY[3] = 0;
        // set error low
        error = 1'b0;

        // wait for clock to go high for changes to apply, 5tu
        #5;

        // wait for state change, 5tu
        #5;

        // check that state is the first encoding after a reset, if not print error and set error reg high
        if(dut.state !== 6'b000001) begin
            $display("Error, expected state %b, is %b", 6'b000001, dut.state);
            error = 1'b1;
        end   

        // set reset low
        KEY[3] = 1;   

//**********************************************************************\\   
//******************* TEST CORRECT COMBO ENTRY (603613) ***************************\\
//**********************************************************************\\
        
    //****************ENTER 1st CORRECT DIGIT (6) ***************

        // Enter the switch value 6
        SW[3:0] = 4'b0110;

        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check the first state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b000010) begin
            $display("Error, expected state %b, is %b", 6'b000010, dut.state);
            error = 1'b1;
        end  

        // check incorrectCombo is still low, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b0) begin
            $display("Error, expected the inputted switch value %b to be correct", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 6, if not, print error and set error reg high
        if(HEX0 !== 7'b0000010 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0000010, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end
        
    //****************ENTER 2nd CORRECT DIGIT (0) ***************

        // Enter the switch value 0
        SW[3:0] = 4'b0000;

        // wait 10tu for the clock to pick up switch changes and process state change
        #10;

        // check second state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b000100) begin
            $display("Error, expected state %b, is %b", 6'b000100, dut.state);
            error = 1'b1;
        end 

        // check incorrectCombo is still low, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b0) begin
            $display("Error, expected this switch set %b to be correct", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 0, if not, print error and set error reg high
        if(HEX0 !== 7'b1000000 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b1000000, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 3RD CORRECT DIGIT (3) ***************
    
        // Enter the switch value 3
        SW[3:0] = 4'b0011;

        // wait 10tu for the clock to pick up switch changes and process state change
        #10;

        // check third state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b001000) begin
            $display("Error, expected state %b, is %b", 6'b001000, dut.state);
            error = 1'b1;
        end 
        
        // check incorrectCombo is still low, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b0) begin
            $display("Error, expected this switch set %b to be correct", SW[3:0]);
            error = 1'b1;
        end
        
        // check the seven segment dispay output is 3, if not, print error and set error reg high
        if(HEX0 !== 7'b0110000 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0110000, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 4TH CORRECT DIGIT (6) ***************    
        
        // Enter the switch value 6
        SW[3:0] = 4'b0110;
        
        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check fourth state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b010000) begin
            $display("Error, expected state %b, is %b", 6'b010000, dut.state);
            error = 1'b1;
        end 

        // check incorrectCombo is still low, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b0) begin
            $display("Error, expected this switch set %b to be correct", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 6, if not, print error and set error reg high
        if(HEX0 !== 7'b0000010 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0000010, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 5TH CORRECT DIGIT (1) ***************
    
        // Enter the switch value 1
        SW[3:0] = 4'b0001;
        
        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check fifth state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b100000) begin
            $display("Error, expected state %b, is %b", 6'b100000, dut.state);
            error = 1'b1;
        end
        
        // check incorrectCombo is still low, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b0) begin
            $display("Error, expected this switch set %b to be correct", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 1, if not, print error and set error reg high
        if(HEX0 !== 7'b1111001 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b1111001, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 6TH CORRECT DIGIT (3)***************
    
        // Enter the switch value 3
        SW[3:0] = 4'b0011;

        // Wait for 1tu for HEX to update
        #1;

        // check the seven segment dispay output is 3, if not, print error and set error reg high
        if(HEX0 !== 7'b0110000 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0110000, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

        // wait 9tu for the clock to pick switch up changes and process state change
        #9;

        // check incorrectCombo is still low, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b0) begin
            $display("Error, expected this switch set %b to be correct", SW[3:0]);
            error = 1'b1;
        end

        // check comboEnd is high,  if not, print error message and set error reg high
        if(dut.comboEnd !== 1'b1) begin
            $display("Error expected: end reached");
            error = 1'b1;
        end

        // check the seven segment display output is "OPEN", if not, print error message and set error reg high
        if(HEX0 !== 7'b0101011 || HEX1 !== 7'b0000110 || HEX2 !== 7'b0001100 || HEX3 !== 7'b1000000 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0101011, 7'b0000110, 7'b0001100, 7'b1000000, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 );
            error = 1'b1;
        end

//*******************RESET FOR NEXT COMBINATION***********************************\\   

        // set reset high
        KEY[3] = 0;

        // wait 10tu for the clock to pick up changes and process reset changes
        #10;

        // set reset low
        KEY[3] = 1;


        // checking the first state after a reset is first encoding, if not, print error message and set error reg high
        if(dut.state !== 6'b000001) begin
            $display("Error, expected state %b, is %b", 6'b000001, dut.state);
            error = 1'b1;
        end    

//**********************************************************************************\\   
//******************* TEST INCORRECT COMBO (609913) ***************************\\
//********************************************************************************\\
    //****************ENTER 1st CORRECT DIGIT (6) ***************

        // Enter the switch value 6
        SW[3:0] = 4'b0110;


        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check the first state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b000010) begin
            $display("Error, expected state %b, is %b", 6'b000010, dut.state);
            error = 1'b1;
        end  

        // check incorrectCombo is still low, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b0) begin
            $display("Error, expected this switch set %b to be correct", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 6, if not, print error and set error reg high
        if(HEX0 !== 7'b0000010 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0000010, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end
        
    //****************ENTER 2nd CORRECT DIGIT (0) ***************

        // Enter the switch value 0
        SW[3:0] = 4'b0000;

        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check the second state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b000100) begin
            $display("Error, expected state %b, is %b", 6'b000100, dut.state);
            error = 1'b1;
        end 

       // check incorrectCombo is still low, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b0) begin
            $display("Error, expected this switch set %b to be correct", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 0, if not, print error and set error reg high
        if(HEX0 !== 7'b1000000 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b1000000, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 3RD INCORRECT DIGIT (9) ***************
    
        // Enter the switch value 9
        SW[3:0] = 4'b1001;

        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check the third state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b001000) begin
            $display("Error, expected state %b, is %b", 6'b001000, dut.state);
            error = 1'b1;
        end 
        
        // check incorrectCombo is high, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b1) begin
            $display("Error, expected this switch set %b to be incorrect", SW[3:0]);
            error = 1'b1;
        end
        
        // check the seven segment dispay output is 9, if not, print error and set error reg high
        if(HEX0 !== 7'b0011000 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0011000, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 4TH INCORRECT DIGIT (9) ***************    
        
        // Enter the switch value 9
        SW[3:0] = 4'b1001;
        
        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check the fourth state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b010000) begin
            $display("Error, expected state %b, is %b", 6'b010000, dut.state);
            error = 1'b1;
        end 

        // check incorrectCombo is still high, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b1) begin
            $display("Error, expected this switch set %b to be incorrect", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 9, if not, print error and set error reg high
        if(HEX0 !== 7'b0011000 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0011000, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 5TH CORRECT DIGIT (1) ***************
    
        // Enter the switch value 1
        SW[3:0] = 4'b0001;
        
        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check the fifth state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b100000) begin
            $display("Error, expected state %b, is %b", 6'b100000, dut.state);
            error = 1'b1;
        end
        
        // check incorrectCombo is still high, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b1) begin
            $display("Error, expected this switch set %b to be incorrect", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 1, if not, print error and set error reg high
        if(HEX0 !== 7'b1111001 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b1111001, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 6TH CORRECT DIGIT (3)***************
    
        // Enter the switch value 3
        SW[3:0] = 4'b0011;

        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check incorrectCombo is still high, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b1) begin
            $display("Error, expected this switch set %b to be incorrect", SW[3:0]);
            error = 1'b1; 
        end

        // check comboEnd is high,  if not, print error message and set error reg high
        if(dut.comboEnd !== 1'b1) begin
            $display("Error expected end reached");
            error = 1'b1; 
        end

        //check the seven segment display output is "CLOSED", if not, print error message and set error reg high
        if(HEX0 !== 7'b1000000 || HEX1 !== 7'b0000110 || HEX2 !== 7'b0010010 || HEX3 !== 7'b1000000 || HEX4 !== 7'b1000111 || HEX5 !== 7'b1000110) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b1000000, 7'b0010010, 7'b0010010, 7'b1000000, 7'b1000111, 7'b1000110, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 );
            error = 1'b1; 
        end

    //*******************RESET FOR NEXT COMBINATION***************\\  
        //reset is high
        KEY[3] = 0;

        // wait 10tu for the clock to pick up changes and process reset changes
        #10;

        //reset is low
        KEY[3] = 1;


        // checking the first state after a reset is first encoding, if not, print error message and set error reg high
        if(dut.state !== 6'b000001) begin
            $display("Error, expected state %b, is %b", 6'b000001, dut.state);
            error = 1'b1;
        end   
    
    //**********************************************************************************\\   
    //********TEST FOR INCORRECT COMBO (6(12)3613) with error and non-valid SW**********\\
    //**********************************************************************************\\
        
    //****************ENTER 1st CORRECT DIGIT (6) ***************

        // Enter the switch value 6
        SW[3:0] = 4'b0110;


        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check the first state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b000010) begin
            $display("Error, expected state %b, is %b", 6'b000010, dut.state);
            error = 1'b1;
        end  

        // check incorrectCombo is still low, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b0) begin
            $display("Error, expected this switch set %b to be correct", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 6, if not, print error and set error reg high
        if(HEX0 !== 7'b0000010 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0000010, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end
        
    //****************ENTER 2nd INCORRECT DIGIT (12) ***************

        // Enter the switch value 12
        SW[3:0] = 4'b1100;

        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check the second state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b000100) begin
            $display("Error, expected state %b, is %b", 6'b000100, dut.state);
            error = 1'b1;
        end 

        // check incorrectCombo is now high, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b1) begin
            $display("Error, expected this switch set %b to be incorrect", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is "_ERROR", if not, print error and set error reg high
        if(HEX0 !== 7'b0001000 || HEX1 !== 7'b1000000 || HEX2 !== 7'b0001000 || HEX3 !== 7'b0001000 || HEX4 !== 7'b0000110 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0001000, 7'b1000000, 7'b0001000, 7'b0001000, 7'b0000110, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 3RD CORRECT DIGIT (3) ***************
    
        // Enter the switch value 3
        SW[3:0] = 4'b0011;

        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check the third state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b001000) begin
            $display("Error, expected state %b, is %b", 6'b001000, dut.state);
            error = 1'b1;
        end 
        
        // check incorrectCombo is still high, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b1) begin
            $display("Error, expected this switch set %b to be incorrect", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 3, if not, print error and set error reg high
        if(HEX0 !== 7'b0110000 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0110000, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 4TH CORRECT DIGIT (6) ***************    
        
        // Enter the switch value 6
        SW[3:0] = 4'b0110;
        
        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check the fourth state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b010000) begin
            $display("Error, expected state %b, is %b", 6'b010000, dut.state);
            error = 1'b1;
        end 

        // check incorrectCombo is still high, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b1) begin
            $display("Error, expected this switch set %b to be incorrect", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 6, if not, print error and set error reg high
        if(HEX0 !== 7'b0000010 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0000010, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 5TH CORRECT DIGIT (1) ***************
    
        // Enter the switch value 1
        SW[3:0] = 4'b0001;
        
        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check the fifth state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b100000) begin
            $display("Error, expected state %b, is %b", 6'b100000, dut.state);
            error = 1'b1;
        end
        
        // check incorrectCombo is still high, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b1) begin
            $display("Error, expected this switch set %b to be incorrect", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 1, if not, print error and set error reg high
        if(HEX0 !== 7'b1111001 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b1111001, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 6TH CORRECT DIGIT (3)***************
    
        // Enter the switch value 3
        SW[3:0] = 4'b0011;

        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check incorrectCombo is still high, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b1) begin
            $display("Error, expected this switch set %b to be incorrect", SW[3:0]);
            error = 1'b1;
        end

        // check comboEnd is high,  if not, print error message and set error reg high
        if(dut.comboEnd !== 1'b1) begin
            $display("Error expected end reached");
            error = 1'b1;
        end

        // check the seven segment display output is "CLOSED", if not, print error message and set error reg high
        if(HEX0 !== 7'b1000000 || HEX1 !== 7'b0000110 || HEX2 !== 7'b0010010 || HEX3 !== 7'b1000000 || HEX4 !== 7'b1000111 || HEX5 !== 7'b1000110) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b1000000, 7'b0000110, 7'b0010010, 7'b1000000, 7'b1000111, 7'b1000110, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 );
            error = 1'b1;
        end

//*******************RESET FOR NEXT COMBINATION***********************************\\   

        // set reset high
        KEY[3] = 0;

        // wait 10tu for the clock to pick up changes and process reset changes
        #10;

        // set reset low
        KEY[3] = 1;


        // checking the first state after a reset is first encoding, if not, print error message and set error reg high
        if(dut.state !== 6'b000001) begin
            $display("Error, expected state %b, is %b", 6'b000001, dut.state);
            error = 1'b1;
        end    

//**********************************************************************************\\   
//********TEST FOR INCORRECT THEN CORRECT COMBO WITH RESET IN COMBINATION (4(RESET)603613)**********\\
//**********************************************************************************\\
        
    //****************ENTER 1st INCORRECT DIGIT (4) ***************

        // Enter the switch value 4
        SW[3:0] = 4'b0100;


        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check the first state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b000010) begin
            $display("Error, expected state %b, is %b", 6'b000010, dut.state);
            error = 1'b1;
        end  

        // check incorrectCombo is now high, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b1) begin
            $display("Error, expected this switch set %b to be incorrect", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 4, if not, print error and set error reg high
        if(HEX0 !== 7'b0011001 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0011001, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end
        
    //****************ENTER RESET ***************

        //reset is high
        KEY[3] = 0;

        // wait 10tu for the clock to pick up changes and process reset changes
        #10;

        //reset is low
        KEY[3] = 1;


        // checking the first state after a reset is first encoding, if not, print error message and set error reg high
        if(dut.state !== 6'b000001) begin
            $display("Error, expected state %b, is %b", 6'b000001, dut.state);
            error = 1'b1;
        end  
        

    //****************ENTER 1st CORRECT DIGIT (6) ***************

        // Enter the switch value 6
        SW[3:0] = 4'b0110;

        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check the first state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b000010) begin
            $display("Error, expected state %b, is %b", 6'b000010, dut.state);
            error = 1'b1;
        end  

        // check incorrectCombo is still low, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b0) begin
            $display("Error, expected the inputted switch value %b to be correct", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 6, if not, print error and set error reg high
        if(HEX0 !== 7'b0000010 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0000010, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end
        
    //****************ENTER 2nd CORRECT DIGIT (0) ***************

        // Enter the switch value 0
        SW[3:0] = 4'b0000;

        // wait 10tu for the clock to pick up switch changes and process state change
        #10;

        // check second state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b000100) begin
            $display("Error, expected state %b, is %b", 6'b000100, dut.state);
            error = 1'b1;
        end 

        // check incorrectCombo is still low, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b0) begin
            $display("Error, expected this switch set %b to be correct", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 0, if not, print error and set error reg high
        if(HEX0 !== 7'b1000000 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b1000000, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 3RD CORRECT DIGIT (3) ***************
    
        // Enter the switch value 3
        SW[3:0] = 4'b0011;

        // wait 10tu for the clock to pick up switch changes and process state change
        #10;

        // check third state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b001000) begin
            $display("Error, expected state %b, is %b", 6'b001000, dut.state);
            error = 1'b1;
        end 
        
        // check incorrectCombo is still low, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b0) begin
            $display("Error, expected this switch set %b to be correct", SW[3:0]);
            error = 1'b1;
        end
        
        // check the seven segment dispay output is 3, if not, print error and set error reg high
        if(HEX0 !== 7'b0110000 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0110000, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 4TH CORRECT DIGIT (6) ***************    
        
        // Enter the switch value 6
        SW[3:0] = 4'b0110;
        
        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check fourth state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b010000) begin
            $display("Error, expected state %b, is %b", 6'b010000, dut.state);
            error = 1'b1;
        end 

        // check incorrectCombo is still low, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b0) begin
            $display("Error, expected this switch set %b to be correct", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 6, if not, print error and set error reg high
        if(HEX0 !== 7'b0000010 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0000010, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 5TH CORRECT DIGIT (1) ***************
    
        // Enter the switch value 1
        SW[3:0] = 4'b0001;
        
        // wait 10tu for the clock to pick switch up changes and process state change
        #10;

        // check fifth state change, if incorrect, print error message and set error reg high
        if(dut.state !== 6'b100000) begin
            $display("Error, expected state %b, is %b", 6'b100000, dut.state);
            error = 1'b1;
        end
        
        // check incorrectCombo is still low, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b0) begin
            $display("Error, expected this switch set %b to be correct", SW[3:0]);
            error = 1'b1;
        end

        // check the seven segment dispay output is 1, if not, print error and set error reg high
        if(HEX0 !== 7'b1111001 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 ||HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b1111001, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

    //****************ENTER 6TH CORRECT DIGIT (3)***************
    
        // Enter the switch value 3
        SW[3:0] = 4'b0011;

        // Wait for 1tu for HEX to update
        #1;

        // check the seven segment dispay output is 3, if not, print error and set error reg high
        if(HEX0 !== 7'b0110000 || HEX1 !== 7'b1111111 || HEX2 !== 7'b1111111 || HEX3 !== 7'b1111111 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0110000, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
            error = 1'b1;
        end

        // wait 9tu for the clock to pick switch up changes and process state change
        #9;

        // check incorrectCombo is still low, if not, print error message and set error reg high
        if(dut.incorrectCombo !== 1'b0) begin
            $display("Error, expected this switch set %b to be correct", SW[3:0]);
            error = 1'b1;
        end

        // check comboEnd is high,  if not, print error message and set error reg high
        if(dut.comboEnd !== 1'b1) begin
            $display("Error expected: end reached");
            error = 1'b1;
        end

        // check the seven segment display output is "OPEN", if not, print error message and set error reg high
        if(HEX0 !== 7'b0101011 || HEX1 !== 7'b0000110 || HEX2 !== 7'b0001100 || HEX3 !== 7'b1000000 || HEX4 !== 7'b1111111 || HEX5 !== 7'b1111111) begin
            $display("Error, expected HEXES 0-5 to be %b %b %b %b %b %b, but were %b %b %b %b %b %b", 7'b0101011, 7'b0000110, 7'b0001100, 7'b1000000, 7'b1111111, 7'b1111111, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 );
            error = 1'b1;
        end

        $stop;
    end
endmodule



