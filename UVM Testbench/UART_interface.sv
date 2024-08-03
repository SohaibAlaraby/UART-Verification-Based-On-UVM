interface UART_interface(input   logic       CLK);


logic Reset;//input
logic rd_uart,wr_uart;//input
//logic rx;
logic[7:0] w_data;//input
logic[9:0] divsr;//input
logic rx_empty,tx_full;//output
logic tx;//inter
logic[7:0] r_data;//output
logic incorrect_send;//output
logic tx_done,rx_done;//output
endinterface : UART_interface
