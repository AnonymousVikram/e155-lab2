module lab2_vk (
    input logic [3:0] s1,
    s2,
    input logic resetHigh,
    output logic segLEn,
    segREn,
    output logic [6:0] seg
);

  logic clk;

  HSOSC #(
      .CLKHF_DIV(2'b00)
  )  // ensures 48MHz clock
      hf_osc (
      .CLKHFPU(1'b1),
      .CLKHFEN(1'b1),
      .CLKHF  (clk)
  );

  logic [31:0] counter;
  logic lrSeg;
  logic [3:0] inputSwitches;

  assign inputSwitches = lrSeg ? s1 : s2;


  sevenSegmentDecoder segDecoder (
      .inputHex(inputSwitches),
      .segments(seg)
  );

  assign segLEn = lrSeg;
  assign segREn = ~lrSeg;

  always_ff @(posedge clk) begin
    if (!resetHigh) begin
      counter <= 0;
      lrSeg   <= 1;
    end else if (counter > 'd100000) begin
      lrSeg   <= ~lrSeg;
      counter <= 0;
    end else counter <= counter + 1;
  end

endmodule
