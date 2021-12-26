module sender (
    i_clk,
    i_rst,
    o_data_morse,
);

    input i_clk, i_rst;
    output reg o_data_morse;

    reg [7:0] mem[15:0];
    reg [31:0] data_morse;
    reg [63:0] adr;
    reg transmit;

    integer counter;

    initial $readmemh("mem.txt", mem);


    always @(posedge i_clk) begin
        if (i_rst) begin
            adr = 0;
            data_morse = 0;
            counter = -1;
        end else begin
            if(!transmit) begin
                case (mem[adr]) 
                    'h 54: begin//T
                        data_morse = 'b 111000;  
                        counter = 5;     
                    end
                    'h 55: begin//U
                        data_morse = 'b 1010111000;  
                        counter = 9;     
                    end
                    'h 53: begin//S
                        data_morse = 'b 10101000;  
                        counter = 7;     
                    end
                    'h 41: begin//A
                        data_morse = 'b 10111000;  
                        counter = 7;     
                    end  
                    'h 4B: begin//K
                        data_morse = 'b 111010111000;  
                        counter = 11;     
                    end
                    'h 20: begin//[space]
                        data_morse = 'b 000;  
                        counter = 2;     
                    end
                    'h 44: begin//D
                        data_morse = 'b 1110101000;  
                        counter = 11;     
                    end
                    'h 39: begin//9
                        data_morse = 'b 1110_1110_1110_1110_1000;  
                        counter = 19;     
                    end
                    'h 31: begin//1
                        data_morse = 'b 1011_1011_1011_1011_1000;  
                        counter = 19;     
                    end
                endcase
                adr = adr + 1;
                transmit = 1;
            end        
        end
        
    end

    always @(posedge i_clk) begin
        if(counter != -1) begin
            o_data_morse = data_morse[counter];
            counter = counter - 1;
        end else begin
            transmit = 0;
        end     
    end

endmodule