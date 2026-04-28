interface fifo_if(input logic clk);

  // input
  logic rst;
  logic wr_en;
  logic rd_en;
  logic [7:0] data_in;

  // output
  logic full;
  logic empty;
  logic [7:0] data_out;

  clocking cb (@posedge clk);
    default input #1step output #1step;

    input full;
    input empty;
    input data_out;

    output wr_en;
    output rd_en;
    output data_in;
  endclocking

  // assertions
  property no_write_when_full;
    @(posedge clk) full |-> !wr_en;
  endproperty

  property no_read_when_empty;
    @(posedge clk) empty |-> !rd_en;
  endproperty

  property full_and_empty_invalid;
    @(posedge clk) !(full && empty);
  endproperty

  property data_stable_withoud_read;
    @(posedge clk) !rd_en |-> $stable(data_out);
  endproperty

  assert property(no_write_when_full);
  assert property(no_read_when_empty);
  assert property(full_and_empty_invalid);
  assert property(data_stable_withoud_read);
    
endinterface
