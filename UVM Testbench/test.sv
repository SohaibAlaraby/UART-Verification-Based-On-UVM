class test extends uvm_test;
`uvm_component_utils(test)
run_sequence UART_run_sequence;
reset_sequence UART_reset_sequence;
All_One_sequence All_ones;
env UART_env;
function new(string name = "test",uvm_component parent);
    super.new(name,parent);
    `uvm_info(get_type_name() ," in constructor of test ",UVM_HIGH)
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    UART_env=env::type_id::create("UART_env",this);
    `uvm_info(get_type_name() ," in build_phase of test ",UVM_HIGH)
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name() ," in connect_phase of test ",UVM_HIGH)
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
    super.build_phase(phase);
    this.print();
    factory.print();
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);
   
    phase.raise_objection(this);
    UART_reset_sequence=reset_sequence::type_id::create("UART_reset_sequence");
    UART_reset_sequence.start(UART_env.UART_agent.UART_sequencer);
    `uvm_info(get_type_name() ," end reset sequence ",UVM_LOW)
    #92000000
    All_ones=All_One_sequence::type_id::create("All_ones");
    All_ones.start(UART_env.UART_agent.UART_sequencer);
    repeat(80)begin
        //#1090000000
        #92000000
        UART_run_sequence=run_sequence::type_id::create("UART_run_sequence");
        UART_run_sequence.start(UART_env.UART_agent.UART_sequencer);
        `uvm_info(get_type_name() ," end sequence ",UVM_LOW)
    end
    
    phase.drop_objection(this);
endtask

endclass
