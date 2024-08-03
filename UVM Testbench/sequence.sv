class base_sequence extends uvm_sequence#(UART_sequence_item);
`uvm_object_utils(base_sequence)

    
function new (string name= "base_sequence");
    super.new(name);
endfunction: new



endclass

class reset_sequence extends base_sequence ;

`uvm_object_utils(reset_sequence)

UART_sequence_item reset_item;

function new(string name = "reset_sequence");
    super.new(name);
    `uvm_info(get_type_name() ," in constructor of rst_sequence ",UVM_HIGH)
endfunction

task body();
    reset_item = UART_sequence_item::type_id::create("reset_item");
    `uvm_info(get_type_name() ," in body of reset sequence ",UVM_HIGH)
    start_item(reset_item);
    if(!(reset_item.randomize() with {Reset == 1;}))begin
        `uvm_error(get_type_name(),"fail to randomize");
    end
    finish_item(reset_item);


endtask:body

endclass

class run_sequence extends base_sequence ;

`uvm_object_utils(run_sequence)

UART_sequence_item run_item;

function new(string name = "run_sequence");
    super.new(name);
    `uvm_info(get_type_name() ," in constructor of run_sequence ",UVM_HIGH)
endfunction

task body();
    run_item = UART_sequence_item::type_id::create("run_item");
    `uvm_info(get_type_name() ," in body of run sequence ",UVM_HIGH)
    start_item(run_item);
    if(!(run_item.randomize() with {Reset == 0;}))begin
        `uvm_error(get_type_name(),"fail to randomize");
    end
    finish_item(run_item);


endtask:body

endclass
class All_One_sequence extends base_sequence ;

`uvm_object_utils(All_One_sequence)

UART_sequence_item run_item;

function new(string name = "All_One_sequence");
    super.new(name);
    `uvm_info(get_type_name() ," in constructor of run_sequence ",UVM_HIGH)
endfunction

task body();
    run_item = UART_sequence_item::type_id::create("run_item");
    `uvm_info(get_type_name() ," in body of run sequence ",UVM_HIGH)
    start_item(run_item);
    run_item.w_data=8'hFF;
    run_item.Reset=0;
    finish_item(run_item);


endtask:body

endclass