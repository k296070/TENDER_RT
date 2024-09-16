module index_buffer #(
  parameter DATA_WIDTH = 16, BUFFER_SIZE = 8
)(
    input clk,
    input rstn,
    input valid,

    input [15:0] Chidx,
    input  [BUFFER_SIZE-1:0] buffer_addr, // Output max value
    input  [7:0] counter // Output max value
);
reg [DATA_WIDTH-1:0] idx_buffer [0:2**BUFFER_SIZE-1][0:2**BUFFER_SIZE-1]; // change memory size

integer i;
integer j;

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
      for(i=0;i<2**BUFFER_SIZE;i=i+1)begin
        for(j=0;j<2**BUFFER_SIZE;j=j+1)begin
          idx_buffer[i][j] <= 0;
        end
      end
    end else if (valid)begin
      idx_buffer[buffer_addr][counter] <= Chidx;
    end
end
endmodule