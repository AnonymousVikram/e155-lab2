/*
* File Author: Vikram Krishna (vkrishna@hmc.edu)
* File Created: August 31, 2024
* Summary: SystemVerilog to output a hex value on a seven segment display
*/


module sevenSegmentDecoder (
    input  logic [3:0] inputHex,
    output logic [6:0] segments
);

  always_comb begin
    case (inputHex)
      4'h0: segments = 7'b1000000;
      4'h1: segments = 7'b1111001;
      4'h2: segments = 7'b0100100;
      4'h3: segments = 7'b0110000;
      4'h4: segments = 7'b0011001;
      4'h5: segments = 7'b0010010;
      4'h6: segments = 7'b0000010;
      4'h7: segments = 7'b1111000;
      4'h8: segments = 7'b0000000;
      4'h9: segments = 7'b0011000;
      4'hA: segments = 7'b0001000;
      4'hB: segments = 7'b0000011;
      4'hC: segments = 7'b1000110;
      4'hD: segments = 7'b0100001;
      4'hE: segments = 7'b0000110;
      4'hF: segments = 7'b0001110;
      default: segments = 7'b1111111;
    endcase
  end
endmodule
