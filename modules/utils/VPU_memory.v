// hardware_counter.v

module VPU_memory #(
  parameter DATA_WIDTH = 1057, MEM_ADDR_SIZE = 5
)(
    input clk,
    input rstn,

    output reg [15:0] Chnaddr,
    output reg [15:0] Tmax,
    output reg [1023:0] Tensors,
    output reg valid
);

  // memory
    reg [DATA_WIDTH-1:0] vpu_memory[0:2**MEM_ADDR_SIZE-1];
    initial $readmemb("modules/utils/data/vpu.mem", vpu_memory);
    reg [7:0] counter;
    
  
  // read instruction
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            counter <= 0;
        end else begin
            Tmax <= vpu_memory[counter][15:0];
            Tensors <= vpu_memory[counter][1055:32];
            Chnaddr <= vpu_memory[counter][31:16];
            counter <= counter + 1;
            valid <= vpu_memory[counter][1056];
        end
    end

endmodule
