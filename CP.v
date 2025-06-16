// control path FSM
module cp (
  input clk, rst, start, lt,
  output reg load_acc, load_acc_zero, load_count, en_count, done
);
  reg [2:0] PS, NS;

  localparam S0 = 3'b000, // idle
             S1 = 3'b001, // load 0s
             S2 = 3'b010, // check condition
             S3 = 3'b011, // do addition + inc count
             S4 = 3'b100; // done

  always @(posedge clk or posedge rst) begin
    if (rst)
      PS <= S0;
    else
      PS <= NS;
  end

  always @(*) begin
    // default outputs
    load_acc = 0;
    load_acc_zero = 0;
    load_count = 0;
    en_count = 0;
    done = 0;
    NS = PS;

    case (PS)
      S0: begin
        if (start)
          NS = S1;
      end
      S1: begin
        load_acc_zero = 1;
        load_count = 1;
        NS = S2;
      end
      S2: begin
        if (lt)
          NS = S3;
        else
          NS = S4;
      end
      S3: begin
        load_acc = 1;
        en_count = 1;
        NS = S2;
      end
      S4: begin
        done = 1;
        if (!start)
          NS = S0;
      end
    endcase
  end
endmodule
