class fifo_underflow_sequence extends uvm_sequence#(fifo_seq_item);

  `uvm_object_utils(fifo_underflow_sequence)

  function new(string name = "fifo_underflow_sequence");
    super.new(name);
  endfunction

  task body();
    fifo_seq_item req;

    repeat (20) begin
      req = fifo_seq_item::type_id::create("req");

      start_item(req);

      if (!req.randomize() with {
        wr_en == 0;
        rd_en == 1;
      }) begin
        `uvm_error("SEQ", "Randomization failed!")
      end

    end
  endtask

endclass
