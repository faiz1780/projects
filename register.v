//  register
module register(input clk, rst, load, input [7:0] in, output reg [7:0] out);
  always @(posedge clk or posedge rst) begin
    if (rst)
      out <= 0;
    else if (load)
      out <= in;
  end
endmodule
