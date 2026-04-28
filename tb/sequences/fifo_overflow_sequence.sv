class fifo_overflow_sequence extends uvm_sequence#(fifo_seq_item);

  `uvm_object_utils(fifo_overflow_sequence)

  function new(string name = "fifo_overflow_sequence");
    super.new(name);
  endfunction

  task body();
    fifo_req_item req;

    repeat (20) begin
      req = fifo_seq_item::type_id::create("req");

      start_item(req);
      if(!req.randomize() with {
        wr_en == 1;
        rd_en == 0;
      }) begin 
        `uvm_error("SEQ", "Randomization failed")
      end
      finish_item(req);
    end

    repeat (10) begin
      req = fifo_seq_item::type_id::create("req");

      start_item(req);
      if (!req.randomize() with {
        wr_en == 1;
        rd_en == 0;
      }) begin
        `uvm_error("SEQ", "Randomization failed")
      end
      finish_item(req);
    end
  endtask

endclass
