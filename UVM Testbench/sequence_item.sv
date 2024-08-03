class UART_sequence_item extends uvm_sequence_item;
`uvm_object_utils(UART_sequence_item)
rand logic[7:0] w_data;
rand logic Reset;
logic rd_uart , wr_uart;
logic[7:0] r_data;
logic tx_done,rx_done;


function new(string name = "UART_sequence_item");
    super.new(name);
endfunction

endclass
