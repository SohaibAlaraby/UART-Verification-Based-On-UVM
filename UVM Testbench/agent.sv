class agent extends uvm_agent;
`uvm_component_utils(agent)
sequencer UART_sequencer;
driver UART_driver;
monitor UART_monitor;

function new(string name="agent",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    UART_sequencer=sequencer::type_id::create("UART_sequencer",this);
    UART_driver=driver::type_id::create("UART_driver",this);
    UART_monitor=monitor::type_id::create("UART_monitor",this);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    UART_driver.seq_item_port.connect(UART_sequencer.seq_item_export);
    
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);

endtask

endclass
