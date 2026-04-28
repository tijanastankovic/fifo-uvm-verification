class fifo_overflow_test extends uvm_test;
  
  `uvm_component_utils(fifo_overflow_test)
  
  env envh;
  fifo_overflow_sequence seq;
  
  function new(string name = "fifo_overflow_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    envh = env::type_id::create("envh", this);
    seq = fifo_overflow_sequence::type_id::create("seq", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    seq.start(envh.agent.seqr);
    `uvm_info(get_type_name(), "SEQUENCE STARTED", UVM_LOW)
    
    phase.drop_objection(this);
  endtask

endclass
