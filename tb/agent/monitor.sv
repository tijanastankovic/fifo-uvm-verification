class monitor extends uvm_monitor;
  
  `uvm_component_utils(monitor)
  
  uvm_analysis_port#(fifo_seq_item) ap; 
  
  virtual fifo_if vif;
  fifo_seq_item tr;
  
   covergroup fifo_cg @(posedge vif.clk);
    wr_cp : coverpoint vif.wr_en;
    rd_cp : coverpoint vif.rd_en;
    full_cp : coverpoint vif.full;
    empty_cp : coverpoint vif.empty;

    wr_rd_cross : cross wr_cp, rd_cp;
    wr_full_cross : cross wr_cp, full_cp;
    rd_empty_cross : cross rd_cp, empty_cp;
  endgroup
  
  function new(string name = "monitor", uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
    fifo_cg = new();
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("no interface", "CAN NOT GET VIRTUAL INTERFACE")
    end
  endfunction
  
  task run_phase(uvm_phase phase);
    
    forever begin
      
      @(posedge vif.clk);
      tr = fifo_seq_item::type_id::create("tr");
      
      tr.wr_en   = vif.cb.wr_en;
      tr.rd_en   = vif.cb.rd_en;
      tr.data_in = vif.cb.data_in;
      
      tr.data_out = vif.cb.data_out;
      tr.full     = vif.cb.full;
      tr.empty    = vif.cb.empty;
      
      fifo_cg.sample();
      
      `uvm_info("MON", $sformatf("Sampled: wr=%0d rd=%0d data_in=%0d data_out=%0d", tr.wr_en, tr.rd_en, tr.data_in, tr.data_out), UVM_LOW)

      if (vif.wr_en || vif.rd_en) begin
        ap.write(tr);
      end
      
  endtask
  
endclass
