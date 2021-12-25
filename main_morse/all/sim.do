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

add wave sim:/main_morse_tb/*

add wave sim:/main_morse_tb/my_receiver/*
add wave -radix ASCII sim:/main_morse_tb/my_receiver/mem


add wave sim:/main_morse_tb/my_sender/*
add wave -radix ASCII sim:/main_morse_tb/my_sender/mem



onbreak resume

# Run simulation
run -all

wave zoom full
