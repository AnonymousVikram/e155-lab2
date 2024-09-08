module lab2_vk (
    input logic [3:0] s,
    input logic reset,
    output logic seg1En,
    seg2En,
    output logic [6:0] seg
);

  logic clk;
  HSOSC #(
      .CLKHF_DIV(2'b00)
  ) hf_osc (
      .CLKHFPU(1'b1),
      .CLKHFEN(1'b1),
      .CLKHF  (clk)
  );

  logic [24:0] counter;


  sevenSegmentDecoder segDecoder (
      .inputHex(s),
      .segments(seg)
  );

  assign seg2En = ~seg1En;

  always_ff @(posedge clk) begin
    if (reset) begin
      seg1En <= 1;
    end
    if (counter > 'd10000000) begin
      seg1En  <= ~seg1En;
      counter <= 0;
    end else counter <= counter + 1;
  end

endmodule
