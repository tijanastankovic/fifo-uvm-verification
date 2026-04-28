module top;

  logic clk;

  fifo_if vif(clk);

  fifo dut (
    .clk(clk),
    .rst(vif.rst),
    .wr_en(vif.wr_en),
    .rd_en(vif.rd_en),
    .full(vif.full),
    .empty(vif.empty),
    .data_in(vif.data_in),
    .data_out(vif.data_out)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    vif.rst = 1;
    repeat (2) @(posedge clk)
      vif.rst = 0;
  end

  initial begin
    uvm_config_db#(virtual fifo_if)::set(null, "*", "vif", vif);
    run_test(); // +UVM_TESTNAME
  end

endmodule

  
