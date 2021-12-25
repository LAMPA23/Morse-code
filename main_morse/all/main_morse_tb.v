`timescale 10ns/1ns
module main_morse_tb ();

    parameter t = 10;
    
    reg i_clk, i_rst;


    wire morse;

    sender my_sender(
        .i_clk(i_clk),
        .i_rst(i_rst),
        .o_data_morse(morse)
    );

    receiver my_receiver(
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_data_morse(morse)
    );

    initial begin
        i_clk = 0;
        forever # ( t / 2 ) i_clk = ~i_clk;
    end
     
    initial begin
        i_rst = 1;
        # ( t ) i_rst = 0;
    end

    initial begin
        # ( t * 200 ) $stop;
    end

endmodule
