module grp_idx_generator (
    input clk,
    input rstn,
    input [15:0] Tmax,   // input of 16-bit
    input [15:0] in,   // inputs of 16-bit
    input [15:0] Chidx_in,
    input valid_in,

    output reg valid_out,
    output reg [15:0] Chidx_out,
    output reg [7:0] grp_idx // Output max value
);
    wire comp_mantissa;
    assign comp_mantissa = (Tmax[9:0]<in[9:0]) ? 1'b1 : 1'b0;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            grp_idx <= 8'b0;
        end else begin
            grp_idx <= Tmax[15:10]-in[15:10]-comp_mantissa;
            valid_out <= valid_in;
            Chidx_out <= Chidx_in;
        end
    end

endmodule