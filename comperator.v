// gshare.v

/* The Gshare predictor consists of the global branch history register (BHR)
 * and a pattern history table (PHT). Note that PC[1:0] is not used for
 * indexing.
 */

module comperator #(
  parameter DATA_WIDTH = 16
) (
  input clk,
  input rstn,

  // update interface
  input [DATA_WIDTH-1:0] in1,
  input [DATA_WIDTH-1:0] in2,

  output [DATA_WIDTH-1:0] reg out
);

  always @(posedge clk) begin
    
  end

endmodule
