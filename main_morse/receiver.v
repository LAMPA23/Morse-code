module receiver (
    i_clk,
    i_rst,
    i_data_morse,
    o_the_end
);

    input i_clk, i_rst, i_data_morse;
    output reg o_the_end;

    reg [7:0] mem[64:0];
    reg [31:0] data_morse;
    reg [7:0] adr = 0;
    reg end_sign;
   
    assign end_sign = ~|data_morse[1:0];

    always @(posedge i_clk) begin
        data_morse = {data_morse[30:0], i_data_morse}; 
        if(i_rst) begin
            adr = 0;
            o_the_end = 0;
            data_morse = 'b xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxx0;    
        end else if(end_sign) begin
            case (data_morse)
                'b xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_0x11_1000: mem[adr] = 'h 54;//T    
                'b xxxx_xxxx_xxxx_xxxx_xxxx_x010_1011_1000: mem[adr] = 'h 55;//U
                'b xxxx_xxxx_xxxx_xxxx_xxxx_xxx0_1010_1000: mem[adr] = 'h 53;//S
                'b xxxx_xxxx_xxxx_xxxx_xxxx_xxx0_1011_1000: mem[adr] = 'h 41;//A
                'b xxxx_xxxx_xxxx_xxxx_xxx0_1110_1011_1000: mem[adr] = 'h 4B;//K
                'b xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_0000: mem[adr] = 'h 20;//[space]
                'b xxxx_xxxx_xxxx_xxxx_xxxx_x011_1010_1000: mem[adr] = 'h 44;//D
                'b xxxx_xxxx_xxx0_1110_1110_1110_1110_1000: mem[adr] = 'h 39;//9     
                'b xxxx_xxxx_xxx0_1011_1011_1011_1011_1000: begin 
                     mem[adr] = 'h 31;//1
                    o_the_end = 1;
                end
            endcase
            adr = adr + 1;
            data_morse = 'hx;
        end  
    end
    
endmodule


//'b xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_x011_1000: mem[adr] = 'h 54;//T