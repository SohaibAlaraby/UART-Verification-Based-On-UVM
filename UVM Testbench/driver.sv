class driver extends uvm_driver#(UART_sequence_item);

    `uvm_component_utils(driver)
    virtual UART_interface intf;
    UART_sequence_item item;
    function new(string name = "driver",uvm_component parent);
        super.new(name , parent);
        `uvm_info(get_type_name() ," in constructor of driver ",UVM_HIGH)
    endfunction 

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name() ," in build_phase of driver ",UVM_LOW)
        if(!(uvm_config_db #(virtual UART_interface)::get(this,"*","intf",intf))) begin
        `uvm_error(get_type_name(),"Error, DUT interface is not found") 
        end    
    endfunction: build_phase

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name() ," in connect_phase of driver ",UVM_LOW)
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name() ," in run_phase of driver ",UVM_LOW)
        forever begin
            item = UART_sequence_item::type_id::create("item");
            seq_item_port.get_next_item(item);
            drive(item);
            seq_item_port.item_done();
        end
    endtask: run_phase
    task drive (UART_sequence_item item);
        if(item.Reset==1'b0) begin
        @(posedge intf.CLK);
        @(posedge intf.CLK);
        intf.rd_uart = 1'b1;
        @(posedge intf.CLK);
        @(posedge intf.CLK);
        end else begin
            intf.rd_uart = 1'b0;
        end
        intf.rd_uart = 1'b0;
        intf.Reset = item.Reset;
        intf.w_data = item.w_data;
        intf.wr_uart = 1'b1;
        @(posedge intf.CLK);
        intf.wr_uart = 1'b0;
        

    endtask
endclass
