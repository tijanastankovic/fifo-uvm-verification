class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard)

  uvm_analysis_port#(fifo_seq_item, scoreboard) ap_imp;

  bit [7:0] model_queue[$];

  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);

    ap_imp = new("ap_imp", this);
  endfunction

  function void write(fifo_seq_item tr);
    bit [7:0] expected;

    // write model
    if (tr.wr_en && !tr.full) begin
      model_queue.push_back(tr.data_in);

      `uvm_info("SB", $sformatf("WRITE: data=%0d queue_size=%0d", tr.data_in, model_queue.size()), UVM_LOW)
    end

    // overflow
    if (tr.wr_en && tr.full) begin
      `uvm_warning("SB", $sformatf("Overflow attempt detected! data=%0d", tr.data_in))
    end

    // read model
    if (tr.rd_en && !tr.empty) begin
      
      if (model_queue.size() == 0) begin
        `uvm_error("SB", "Read when model queue is empty!")
        return;
      end
      
      expected = model_queue.pop_front();
      
      if (expected != tr.data_out) begin
        `uvm_error("FIFO", $sformatf("Mismatch! expected = %d, actual = %d", expected, tr.data_out))
      end else begin
        `uvm_info("FIFO", $sformatf("Match! expected = %d, actual = %d", expected, tr.data_out), UVM_LOW)
      end
    end

    // underflow
    if (model_queue.size() == 0) begin
        `uvm_error("SB", "Read when model queue is empty!")
        return;
      end
  endfunction

endclass
