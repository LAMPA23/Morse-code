module sender (
    i_clk,
    i_rst,
    o_data_morse,
);

    parameter size = 8;

    input i_clk, i_rst;

    output reg o_data_morse;

    reg [7:0] mem[15:0];
    reg [7:0] data_morse;
    reg [63:0] adr;
    reg transmit;

    integer counter;

    initial $readmemh("mem.txt", mem);
   

    //assign o_test = mem[adr];


    always @(posedge i_clk) begin
        if (i_rst) begin
            adr = 0;
            data_morse = 0;
            counter = -1;
        end else begin
            if(!transmit) begin
                case (mem[adr]) 
                    'h 61: begin//a
                        data_morse = 'b 1_0111_000;  
                        //counter = 7;     
                    end
                    'h 62: begin//b
                        data_morse = 'b 1_0101_0111_000;
                        counter = 11;
                    end
                    'h 63: begin
                        data_morse = 4;
                    end
                    default : begin
                        data_morse = 0;//[space]
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