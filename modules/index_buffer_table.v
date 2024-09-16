module index_buffer_table #(
  parameter TABLE_WIDTH = 272, TABLE_SIZE = 8 , MEM_ADDR_SIZE = 8
)(
    input clk,
    input rstn,
    input valid,
    input [TABLE_SIZE-1:0] grp_idx,   // 64 inputs of 16-bit each

    output  [TABLE_SIZE-1:0] buffer_addr, // Output max value
    output  [TABLE_SIZE-1:0] counter // Output max value
);

reg [TABLE_WIDTH-1:0] idx_table [0:2**TABLE_SIZE-1]; // change memory size
reg [MEM_ADDR_SIZE-1:0] next_free_block;

integer i;

always @(posedge clk or negedge rstn) begin
  if (!rstn) begin
    for(i=0;i<2**TABLE_SIZE-1;i=i+1)begin
      idx_table[i] <= 0;
      next_free_block <= 0;
    end
  end else if(valid) begin
    if(counter==0)begin
      next_free_block <= next_free_block + 1;
      idx_table[grp_idx][7:0] <= idx_table[grp_idx][7:0] + 1;
      idx_table[grp_idx][15:8] <= next_free_block;
      idx_table[grp_idx][TABLE_WIDTH-1-next_free_block] <= 1'b1;
    end else if(counter==255)begin
      idx_table[grp_idx][7:0] <= 8'b0;
    end else begin
      idx_table[grp_idx][7:0] <= idx_table[grp_idx][7:0] + 1;
    end
  end
end

assign buffer_addr = (counter==0)? next_free_block:idx_table[grp_idx][15:8]; //256bit
assign counter = idx_table[grp_idx][7:0]; //8bit
endmodule