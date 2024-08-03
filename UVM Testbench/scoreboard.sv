
class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard);
    uvm_analysis_imp #(UART_sequence_item,scoreboard) scoreboard_imp;
    int match = 0;
    int mismatch = 0;
    UART_sequence_item FIFO_a[$];
    function new(string name = "scoreboard" ,uvm_component parent);
        super.new(name,parent);
    endfunction //new()

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name() ," in build_phase of scoreboard ",UVM_LOW)
        scoreboard_imp = new("scoreboard_imp", this);
    endfunction: build_phase

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name() ," in connect_phase of scoreboard ",UVM_LOW)
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name() ," in run_phase of scoreboard ",UVM_LOW)
        forever begin
            UART_sequence_item item;
            wait(FIFO_a.size());
            item = FIFO_a.pop_front();
            compare(item);
            `uvm_info(get_type_name() ,$sformatf("mismatch = %d, match = %d  ",mismatch,match),UVM_LOW)
        end

    endtask: run_phase
    function void write(UART_sequence_item item);
        FIFO_a.push_back(item);

    endfunction

    task compare(UART_sequence_item item);
        if(item.Reset == 1'b1)begin
            `uvm_info(get_type_name() ," reset is on ",UVM_LOW)
        end else begin
            if(item.w_data == item.r_data) begin
                match = match +1;
                `uvm_info(get_type_name() ," Data is transmitted correctly!! ",UVM_LOW)
            end else begin
                mismatch = mismatch+1;
                `uvm_error(get_type_name(),$sformatf("error reset=%b w_data=%b ,r_data=%b  ",item.Reset, item.w_data,item.r_data))
            end

        end
    endtask
endclass
