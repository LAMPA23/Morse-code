###########################
# Simple modelsim do file #
###########################

# Delete old compilation results
if { [file exists "work"] } {
    vdel -all
}

# Create new modelsim working library
vlib work

# Compile all the Verilog sources in current folder into working library
vlog  sender.v receiver.v main_morse_tb.v
 
# Open testbench module for simulation
vsim work.main_morse_tb

# Add all testbench signals to waveform diagram

add wave sim:/main_morse_tb/i_clk
add wave -radix binary sim:/main_morse_tb/my_sender/i_clk
add wave -radix binary sim:/main_morse_tb/my_receiver/i_clk


add wave sim:/main_morse_tb/i_rst
add wave -radix binary sim:/main_morse_tb/my_sender/i_rst
add wave -radix binary sim:/main_morse_tb/my_receiver/i_rst
add wave -radix binary sim:/main_morse_tb/my_receiver/o_the_end




add wave -radix binary sim:/main_morse_tb/my_sender/o_data_morse
add wave sim:/main_morse_tb/morse
add wave -radix binary sim:/main_morse_tb/my_receiver/i_data_morse

add wave -radix binary sim:/main_morse_tb/my_sender/transmit
add wave -radix unsigned sim:/main_morse_tb/my_sender/adr
add wave -radix decimal sim:/main_morse_tb/my_sender/counter
add wave -radix binary sim:/main_morse_tb/my_sender/data_morse
add wave -radix binary sim:/main_morse_tb/my_receiver/data_morse
add wave -radix unsigned sim:/main_morse_tb/my_receiver/adr

add wave -radix binary sim:/main_morse_tb/my_receiver/end_sign

add wave -radix ASCII sim:/main_morse_tb/my_receiver/mem
add wave -radix ASCII sim:/main_morse_tb/my_sender/mem



















onbreak resume

# Run simulation
run -all

wave zoom full
