onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lab3_tb/dut/SW
add wave -noupdate /lab3_tb/dut/KEY
add wave -noupdate /lab3_tb/dut/HEX0
add wave -noupdate /lab3_tb/dut/HEX1
add wave -noupdate /lab3_tb/dut/HEX2
add wave -noupdate /lab3_tb/dut/HEX3
add wave -noupdate /lab3_tb/dut/HEX4
add wave -noupdate /lab3_tb/dut/HEX5
add wave -noupdate /lab3_tb/dut/clk
add wave -noupdate /lab3_tb/dut/rst_n
add wave -noupdate /lab3_tb/dut/incorrectCombo
add wave -noupdate /lab3_tb/dut/comboEnd
add wave -noupdate /lab3_tb/dut/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {315 ps}
