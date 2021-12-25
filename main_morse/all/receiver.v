module receiver (
    i_clk,
    i_rst,
    i_data_morse,
);

    input i_clk, i_rst, i_data_morse;


    parameter size = 8;
    parameter end_message_sign = 135;    


    reg [7:0] mem[64:0];
    reg [31:0] data_morse, counter;
    reg [7:0] adr = 0;
    reg end_sign, end_word, end_message;
   

    assign end_sign = ~|data_morse[2:0];
    assign end_word = ~|data_morse[4:0];
    assign end_message = ( data_morse == end_message_sign );
    

    always @(posedge i_clk) begin 
        data_morse = {data_morse[30:0], i_data_morse}; 
    end


    always @(posedge i_clk) begin
        if(i_rst) begin
            adr = 9;
            data_morse = 'hx;    
        end
        if(end_sign) begin
            case (data_morse)
                32'bxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_0000: begin
                    mem[adr] = 'h 20;//[space]
                end
                32'bxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_1011_1000: begin
                    mem[24] = 'h 61;//a
                end
                32'bxxxx_xxxx_xxxx_xxxx_xxxx_1010_1011_1000: begin
                    mem[adr] = 'h 62;//[space]
                end
                32'b011101011101000: begin
                   mem[adr] = 657;//C
                end
            endcase
            adr = adr + 1;
            data_morse = 'hx;
        end  
    end

    
endmodule