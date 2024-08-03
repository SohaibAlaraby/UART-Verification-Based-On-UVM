class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)
    virtual UART_interface intf;
    uvm_analysis_port #(UART_sequence_item) monitor_port;

    UART_sequence_item item1;

    function new(string name="monitor",uvm_component parent);
        super.new(name,parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name() ," in monitor build_phase ",UVM_HIGH)
        if(!(uvm_config_db #(virtual UART_interface)::get(this,"*","intf",intf))) begin
        `uvm_error(get_type_name(),"Error, DUT interface is not found") 
        end
        monitor_port = new("monitor_port",this);
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name() ," in monitor connect_phase ",UVM_HIGH)
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name() ," in monitor run_phase ",UVM_HIGH)
        forever begin
            
            item1=UART_sequence_item::type_id::create("item1");
            get_data();
            get_out_data();
            monitor_port.write(item1);
        end
    endtask
    task get_data();
        @(posedge intf.CLK);
        @(posedge intf.CLK);
        @(posedge intf.CLK);
        @(posedge intf.CLK);
        @(posedge intf.CLK);
        item1.Reset = intf.Reset;
        item1.w_data = intf.w_data;
        `uvm_info(get_type_name() ," in sampling the input ",UVM_LOW)
         
        
    endtask

    task get_out_data();
        if(intf.Reset==1'b1) begin
            @(posedge intf.rd_uart);
        end else begin
            @(negedge intf.rx_done);
            @(posedge intf.CLK);
            @(posedge intf.CLK);
        end
        item1.r_data=intf.r_data;

    endtask

endclass
