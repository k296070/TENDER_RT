// comperator_64.v

module comperator_64 #(
  parameter DATA_WIDTH = 16
) (
  input clk,
  input rstn,

  // update interface
  input [DATA_WIDTH-1:0] in1,
  input [DATA_WIDTH-1:0] in2,
  input [DATA_WIDTH-1:0] in3,
  input [DATA_WIDTH-1:0] in4,
  input [DATA_WIDTH-1:0] in5,
  input [DATA_WIDTH-1:0] in6,
  input [DATA_WIDTH-1:0] in7,
  input [DATA_WIDTH-1:0] in8,
  input [DATA_WIDTH-1:0] in9,
  input [DATA_WIDTH-1:0] in10,
  input [DATA_WIDTH-1:0] in11,
  input [DATA_WIDTH-1:0] in12,
  input [DATA_WIDTH-1:0] in13,
  input [DATA_WIDTH-1:0] in14,
  input [DATA_WIDTH-1:0] in15,
  input [DATA_WIDTH-1:0] in16,
  input [DATA_WIDTH-1:0] in17,
  input [DATA_WIDTH-1:0] in18,
  input [DATA_WIDTH-1:0] in19,
  input [DATA_WIDTH-1:0] in20,
  input [DATA_WIDTH-1:0] in21,
  input [DATA_WIDTH-1:0] in22,
  input [DATA_WIDTH-1:0] in23,
  input [DATA_WIDTH-1:0] in24,
  input [DATA_WIDTH-1:0] in25,
  input [DATA_WIDTH-1:0] in26,
  input [DATA_WIDTH-1:0] in27,
  input [DATA_WIDTH-1:0] in28,
  input [DATA_WIDTH-1:0] in29,
  input [DATA_WIDTH-1:0] in30,
  input [DATA_WIDTH-1:0] in31,
  input [DATA_WIDTH-1:0] in32,
  input [DATA_WIDTH-1:0] in33,
  input [DATA_WIDTH-1:0] in34,
  input [DATA_WIDTH-1:0] in35,
  input [DATA_WIDTH-1:0] in36,
  input [DATA_WIDTH-1:0] in37,
  input [DATA_WIDTH-1:0] in38,
  input [DATA_WIDTH-1:0] in39,
  input [DATA_WIDTH-1:0] in40,
  input [DATA_WIDTH-1:0] in41,
  input [DATA_WIDTH-1:0] in42,
  input [DATA_WIDTH-1:0] in43,
  input [DATA_WIDTH-1:0] in44,
  input [DATA_WIDTH-1:0] in45,
  input [DATA_WIDTH-1:0] in46,
  input [DATA_WIDTH-1:0] in47,
  input [DATA_WIDTH-1:0] in48,
  input [DATA_WIDTH-1:0] in49,
  input [DATA_WIDTH-1:0] in50,
  input [DATA_WIDTH-1:0] in51,
  input [DATA_WIDTH-1:0] in52,
  input [DATA_WIDTH-1:0] in53,
  input [DATA_WIDTH-1:0] in54,
  input [DATA_WIDTH-1:0] in55,
  input [DATA_WIDTH-1:0] in56,
  input [DATA_WIDTH-1:0] in57,
  input [DATA_WIDTH-1:0] in58,
  input [DATA_WIDTH-1:0] in59,
  input [DATA_WIDTH-1:0] in60,
  input [DATA_WIDTH-1:0] in61,
  input [DATA_WIDTH-1:0] in62,
  input [DATA_WIDTH-1:0] in63,
  input [DATA_WIDTH-1:0] in64,
  output reg [DATA_WIDTH-1:0] out
);

wire [DATA_WIDTH-1:0] out1, out2;

comperator_32 comp_1(
  .clk(clk),
  .rstn(rstn),
  .in1(in1),
  .in2(in2),
  .in3(in3),
  .in4(in4),
  .in5(in5),
  .in6(in6),
  .in7(in7),
  .in8(in8),
  .in9(in9),
  .in10(in10),
  .in11(in11),
  .in12(in12),
  .in13(in13),
  .in14(in14),
  .in15(in15),
  .in16(in16),
  .in17(in17),
  .in18(in18),
  .in19(in19),
  .in20(in20),
  .in21(in21),
  .in22(in22),
  .in23(in23),
  .in24(in24),
  .in25(in25),
  .in26(in26),
  .in27(in27),
  .in28(in28),
  .in29(in29),
  .in30(in30),
  .in31(in31),
  .in32(in32),

  .out(out1)
);
comperator_32 comp_2(
  .clk(clk),
  .rstn(rstn),
  .in1(in33),
  .in2(in34),
  .in3(in35),
  .in4(in36),
  .in5(in37),
  .in6(in38),
  .in7(in39),
  .in8(in40),
  .in9(in41),
  .in10(in42),
  .in11(in43),
  .in12(in44),
  .in13(in45),
  .in14(in46),
  .in15(in47),
  .in16(in48),
  .in17(in49),
  .in18(in50),
  .in19(in51),
  .in20(in52),
  .in21(in53),
  .in22(in54),
  .in23(in55),
  .in24(in56),
  .in25(in57),
  .in26(in58),
  .in27(in59),
  .in28(in60),
  .in29(in61),
  .in30(in62),
  .in31(in63),
  .in32(in64),

  .out(out2)
); 

always @(*) begin
  if (rstn == 1'b0) begin
    out <= 16'b0;
  end else begin
    if(out1>out2)begin
      out <= out1;
    end else begin
      out <= out2;
    end
  end
end

endmodule
