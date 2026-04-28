class env extends uvm_env;
  
  `uvm_component_utils(env)
  
  fifo_agent agent;
  scoreboard sb;
  
  function new(string name = "env", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    agent = fifo_agent::type_id::create("agent", this);
    sb = scoreboard::type_id::create("sb", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    agent.mon.ap.connect(sb.ap_imp);
  endfunction
  
endclass
