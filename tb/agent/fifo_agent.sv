class fifo_agent extends uvm_agent;
  
  `uvm_component_utils(fifo_agent)

  monitor mon;
  fifo_driver drv;
  fifo_sequencer seqr;
  
  function new(string name = "fifo_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("AGENT", "CAN NOT GET VIRTUAL INTERFACE")
    end
    
    mon = monitor::type_id::create("mon", this);
    drv = fifo_driver::type_id::create("drv", this);
    seqr = fifo_sequencer::type_id::create("seqr", this);

    seqr.vif = vif;
  endfunction
  
  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
  
endclass
