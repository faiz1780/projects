// top module
module top(
  input clk, rst, start,
  input [7:0] in1, in2,
  output [7:0] product,
  output done
);
  wire [7:0] sum, count, acc_out;
  wire lt, load_acc, load_acc_zero, load_count, en_count;

  adder A1 (.a(acc_out), .b(in1), .sum(sum));
  comparator C1 (.c(count), .d(in2), .en(lt));
  counter CTR (.clk(clk), .rst(rst), .en(en_count), .out(count));
  
  wire [7:0] acc_in = load_acc_zero ? 8'd0 : sum;
  
  register ACC (.clk(clk), .rst(rst), .load(load_acc | load_acc_zero), .in(acc_in), .out(acc_out));

  cp CU (
    .clk(clk), .rst(rst), .start(start), .lt(lt),
    .load_acc(load_acc), .load_acc_zero(load_acc_zero),
    .load_count(load_count), .en_count(en_count),
    .done(done)
  );

  assign product = acc_out;
endmodule
