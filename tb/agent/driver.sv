class fifo_driver extends uvm_driver#(fifo_seq_item);

  `uvm_component_utils(fifo_driver)

  virtual fifo_if vif;

  function new(string name = "fifo_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  function build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("DRV", "CAN NOT GET VIRTUAL INTERFACE")
    end
  endfunction

  task run_phase(uvm_phase phase);
    fifo_seq_item req;

    forever begin
      seq_item_port.get_next_item(req);

      @(posedge vif.clk);
      wait (!vif.rst);

      // drive signals
      @(posedge vif.clk);
      vif.wr_en <= req.wr_en;
      vif.rd_en <= req.rd_en;
      vif.data_in <= req.data_in;

      `uvm_info("DRV", $sformatf("Driving: wr_en = %0d, rd_en = %0d, data_in = %0d", req.rd_en, req.wr_en, req.data_in), UVM_LOW)
  
      seq_item_port.item_done();

      // idle 
      @(posedge vif.clk);
      vif.wr_en <= 0;
      vif.rd_en <= 0;
      vif.data_in <= 0;
    end
  endtask

endclass
    
