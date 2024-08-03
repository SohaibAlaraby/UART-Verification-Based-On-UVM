class env extends uvm_env;
`uvm_component_utils(env)
agent UART_agent;
scoreboard UART_scoreboard;
coverage_collector UART_coverage_collector;

function new(string name = "env",uvm_component parent);
    super.new(name,parent);

endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    UART_agent=agent::type_id::create("UART_agent",this);
    UART_scoreboard=scoreboard::type_id::create("UART_scoreboard",this);
    UART_coverage_collector=coverage_collector::type_id::create("UART_coverage_collector",this);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    UART_agent.UART_monitor.monitor_port.connect(UART_scoreboard.scoreboard_imp);
    UART_agent.UART_monitor.monitor_port.connect(UART_coverage_collector.coverage_collector_in_imp);
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);

endtask


endclass
