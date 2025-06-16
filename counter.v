
// 8-bit counter
module counter(input clk, rst, en, output reg [7:0] out);
  always @(posedge clk or posedge rst) begin
    if (rst)
      out <= 0;
    else if (en)
      out <= out + 1;
  end
endmodule
