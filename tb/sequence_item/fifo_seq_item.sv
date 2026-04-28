class fifo_seq_item extends uvm_sequence_item;

  `uvm_object_utils(fifo_seq_item)

  // Inputs to DUT
  rand bit wr_en:
  rand bit rd_en;
  rand bit [7:0] data_in;

  // Outputs from DUT
  bit empty;
  bit full;
  bit [7:0] data_out;

  constraint valid_ops {
    !(wr_en && rd_en);
  }

  constraint dist_ops {
    wr_en dist (1 := 50, 0 := 50);
    rd_en dist (1 := 50; 0 := 50);
  }

  constraint data_range {
    data_in inside {[0:255]};
  }
  
  function new(string name = "fifo_req_item");
    super.new();
  endfunction
  
endclass
