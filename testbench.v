`timescale 1ns/1ps
module tb_multiplier;
  reg clk, rst, start;
  reg [7:0] in1, in2;
  wire [7:0] product;
  wire done;

  top UUT (
    .clk(clk), .rst(rst), .start(start),
    .in1(in1), .in2(in2),
    .product(product), .done(done)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("multiplier.vcd");
    $dumpvars(0, tb_multiplier);

    clk = 0;
    rst = 1;
    start = 0;
    in1 = 0;
    in2 = 0;
    #10;
    rst = 0;

    // Multiply 3 * 4
    in1 = 8'd3;
    in2 = 8'd4;
    start = 1;
    #10 start = 0;

    wait(done);
    $display("3 x 4 = %d", product);

    #20;

    // Multiply 5 * 5
    rst = 1; #10; rst = 0;
    in1 = 8'd5;
    in2 = 8'd5;
    start = 1;
    #10 start = 0;

    wait(done);
    $display("5 x 5 = %d", product);
    
    //Multiplly 7*7
 rst=1;#10; rst=0;
in1=8'd7;
in2=8'd7;
start=1;
#10 start=0;
wait(done);
$display("7x7=%d",product);

    #20;
    $finish;
  end
endmodule