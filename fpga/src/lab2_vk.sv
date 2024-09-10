module lab2_vk #(
    parameter CLOCKWAIT = 'd100000
) (
    input logic [3:0] s1,
    s2,
    input logic nReset,
    output logic segLEn,
    segREn,
    output logic [6:0] seg,
    output logic [4:0] sum
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

  assign sum = s1 + s2;

  always_ff @(posedge clk) begin
    if (!nReset) begin
      counter <= 0;
      lrSeg   <= 1;
    end else if (counter > CLOCKWAIT) begin
      lrSeg   <= ~lrSeg;
      counter <= 0;
    end else counter <= counter + 1;
  end

endmodule
