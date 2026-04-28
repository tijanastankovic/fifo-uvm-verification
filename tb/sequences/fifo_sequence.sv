class fifo_sequence extends uvm_sequence#(fifo_seq_item);

  `uvm_object_utils(fifo_sequence)

  function new(string name = "fifo_sequence");
    super.new();
  endfunction

  task body();

    fifo_seq_item req;

    repeat(50) begin
      req = fifo_seq_item::type_id::create("req");

      start_item(req);
      
      //Randomize
      if (!req.randomize() with {
        wr_en dist {1 := 70, 0 := 30};
        rd_en dist {1 := 30, 0 := 70};
      }) begin
        `uvm_error("SEQ", "Randomization failed")
      end
      
      finish_item(req):
    end
  endtask

endclass
    
