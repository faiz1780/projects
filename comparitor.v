/ comparator: enable = 1 if count < multiplier
module comparator(input [7:0] c, d, output en);
  assign en = (c < d) ? 1'b1 : 1'b0;
endmodule
