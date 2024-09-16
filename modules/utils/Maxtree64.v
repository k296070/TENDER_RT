module Maxtree64 (
    input clk,
    input rstn,
    input [1023:0] Tensor,   // 64 inputs of 16-bit each
    input valid_in,
    input [15:0] Tmax_in,
    input [15:0] Chidx_in,

    output reg [15:0] Chidx_out,
    output reg [15:0] Tmax_out,
    output reg [15:0] max_val, // Output max value
    output reg valid_out // Output max value
);

    reg [15:0] stage1 [31:0];  // 1st stage: 32 comparisons
    reg [15:0] stage2 [15:0];  // 2nd stage: 16 comparisons
    reg [15:0] stage3 [7:0];   // 3rd stage: 8 comparisons
    reg [15:0] stage4 [3:0];   // 4th stage: 4 comparisons
    reg [15:0] stage5 [1:0];   // 5th stage: 2 comparisons
    reg [15:0] stage6;         // 6th stage: 1 comparison

    reg stage1_val,stage2_val,stage3_val,stage4_val,stage5_val;
    reg [15:0] stage1_Tmax,stage2_Tmax,stage3_Tmax,stage4_Tmax,stage5_Tmax;
    reg [15:0] stage1_Chidx,stage2_Chidx,stage3_Chidx,stage4_Chidx,stage5_Chidx;
    wire [15:0] in [63:0];

    generate
    for(i=0;i<64;i=i+1)begin: i_gen
        assign in[i] = Tensor[i*16+:16];
    end
    endgenerate

    // First stage: Compare adjacent pairs
    integer i;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            for (i = 0; i < 32; i = i + 1) begin
                stage1[i] <= 16'b0;
            end
        end else begin
            for (i = 0; i < 32; i = i + 1) begin
                stage1[i] <= (in[2*i] > in[2*i+1]) ? in[2*i] : in[2*i+1];
            end
            stage1_val <= valid_in;
            stage1_Tmax <= Tmax_in;
            stage1_Chidx <= Chidx_in;
        end
    end

    // Second stage: Compare results of the first stage
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            for (i = 0; i < 16; i = i + 1) begin
                stage2[i] <= 16'b0;
            end
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                stage2[i] <= (stage1[2*i] > stage1[2*i+1]) ? stage1[2*i] : stage1[2*i+1];
                stage2_val <= stage1_val;
                stage2_Tmax <= stage1_Tmax;
                stage2_Chidx <= stage1_Chidx;
            end
        end
    end

    // Third stage: Compare results of the second stage
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            for (i = 0; i < 8; i = i + 1) begin
                stage3[i] <= 16'b0;
            end
        end else begin
            for (i = 0; i < 8; i = i + 1) begin
                stage3[i] <= (stage2[2*i] > stage2[2*i+1]) ? stage2[2*i] : stage2[2*i+1];
                stage3_val <= stage2_val;
                stage3_Tmax <= stage2_Tmax;
                stage3_Chidx <= stage2_Chidx;
            end
        end
    end

    // Fourth stage: Compare results of the third stage
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            for (i = 0; i < 4; i = i + 1) begin
                stage4[i] <= 16'b0;
            end
        end else begin
            for (i = 0; i < 4; i = i + 1) begin
                stage4[i] <= (stage3[2*i] > stage3[2*i+1]) ? stage3[2*i] : stage3[2*i+1];
                stage4_val <= stage3_val;
                stage4_Tmax <= stage3_Tmax;
                stage4_Chidx <= stage3_Chidx;
            end
        end
    end

    // Fifth stage: Compare results of the fourth stage
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            for (i = 0; i < 2; i = i + 1) begin
                stage5[i] <= 16'b0;
            end
        end else begin
            for (i = 0; i < 2; i = i + 1) begin
                stage5[i] <= (stage4[2*i] > stage4[2*i+1]) ? stage4[2*i] : stage4[2*i+1];
                stage5_val <= stage4_val;
                stage5_Tmax <= stage4_Tmax;
                stage5_Chidx <= stage4_Chidx;
            end
        end
    end

    // Sixth stage: Final comparison to find the maximum value
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            stage6 <= 16'b0;
        end else begin
            max_val <= (stage5[0] > stage5[1]) ? stage5[0] : stage5[1];
            valid_out <= stage5_val;
            Tmax_out <= stage5_Tmax;
            Chidx_out <= stage5_Chidx;

        end
    end

    // Output the maximum value
endmodule