
class sequencer extends uvm_sequencer #(UART_sequence_item);

    `uvm_component_utils(sequencer)

    function new(string name = "sequencer",uvm_component parent);
        super.new(name , parent);
        `uvm_info(get_type_name() ," in constructor of sequencer ",UVM_HIGH)
    endfunction 

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name() ," in build_phase of sequencer ",UVM_LOW)
    endfunction: build_phase

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name() ," in connect_phase of sequencer ",UVM_LOW)
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name() ," in run_phase of sequencer ",UVM_LOW)
    endtask: run_phase
endclass:sequencer