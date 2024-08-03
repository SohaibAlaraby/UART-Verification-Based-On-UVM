class coverage_collector extends uvm_subscriber #(UART_sequence_item);
`uvm_component_utils(coverage_collector)
    UART_sequence_item item;
    uvm_analysis_imp #(UART_sequence_item,coverage_collector) coverage_collector_in_imp;
    covergroup UART_cg;
    option.per_instance=1;
        Reset:coverpoint item.Reset; 
        w_data:coverpoint item.w_data{
            bins All_ones={8'hFF};
            bins All_zeros={8'h0};
            bins random_stimulus = default;
        }

    endgroup
    function new(string name = "coverage_collector", uvm_component parent);
        super.new(name,parent);
        UART_cg=new();
    endfunction //new()

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name() ," in build_phase of coverage_collector ",UVM_LOW)
        coverage_collector_in_imp=new("coverage_collector_in_imp",this);
        
    endfunction: build_phase

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name() ," in connect_phase of coverage_collector ",UVM_LOW)
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name() ," in run_phase of coverage_collector ",UVM_LOW)
    endtask: run_phase
    function void write(UART_sequence_item t);
        item=UART_sequence_item::type_id::create("item");
        $cast(item,t);
        UART_cg.sample();
    endfunction


endclass //coverage_collector extends uvm_subscriber
