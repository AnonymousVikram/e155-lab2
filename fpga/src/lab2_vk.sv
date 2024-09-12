/*
* File Author: Vikram Krishna (vkrishna@hmc.edu)
* File Created: September 8, 2024
* Summary: Top Module for Lab 2
*/

module lab2_vk #(
    parameter CLOCKWAIT = 'd100000
) (
    input logic [3:0] s1,
    s2,
    input logic nreset,
    output logic lSegEn,
    rSegEn,
    output logic [6:0] seg,
    output logic [4:0] sum
);

  logic clk;
  logic [3:0] inputSwitches;
  assign inputSwitches = lSegEn ? s1 : s2;

  HSOSC #(
      .CLKHF_DIV(2'b00)
  )  // ensures 48MHz clock
      hf_osc (
      .CLKHFPU(1'b1),
      .CLKHFEN(1'b1),
      .CLKHF  (clk)
  );

  clockDivider #(CLOCKWAIT) clockDividerInst (
      .clk(clk),
      .nreset(nreset),
      .lSegEn(lSegEn)
  );

  sevenSegmentDecoder segDecoderInst (
      .inputHex(inputSwitches),
      .segments(seg)
  );

  assign rSegEn = ~lSegEn;
  assign sum = s1 + s2;
endmodule
