`timescale 1 ps / 1 ps
module testbench ();
  logic [3:0] s1, s2;
  logic resetHigh;
  logic segLEn, segREn;
  logic [6:0] seg;
  lab2_vk #(5) dut (
      .s1(s1),
      .s2(s2),
      .resetHigh(resetHigh),        
      .segLEn(segLEn),
      .segREn(segREn),
      .seg(seg)
  );

  logic clk;
  assign clk = dut.clk;

  logic lrSeg;
  assign lrSeg = dut.lrSeg;
  logic oldLrSeg;

  int testCounter;
  int errors;

  logic segLEnExpected;
  logic segREnExpected;
  logic [6:0] segExpected;

  logic [16:0] testVectors[1000:0];


  initial begin
    $display("reading test vectors");
    $readmemb("testbench.tv", testVectors);
    testCounter = 0;
    errors = 0;
    resetHigh = 0;
    #27;
    oldLrSeg  = lrSeg;
    resetHigh = 1;
    #2;
  end

  always @(posedge clk) begin
    #1;
    if (oldLrSeg !== lrSeg) begin
      {s1, s2, segLEnExpected, segREnExpected, segExpected} = testVectors[testCounter];
    end
  end

  always @(negedge clk) begin
    #1;
    if (oldLrSeg !== lrSeg) begin
      if ({segLEn, segREn, seg} !== {segLEnExpected, segREnExpected, segExpected}) begin
        $display("Error (test %d): inputs = %b, %b ", errors, s1, s2);
        $display("outputs = %b segment. L: %b R: %b Expected: (%b segment. L: %b R: %b)", seg,
                 segLEn, segREn, segExpected, segLEnExpected, segREnExpected);
        errors = errors + 1;
      end
      oldLrSeg = lrSeg;
      testCounter = testCounter + 1;
      if (testVectors[testCounter] === 17'bx) begin
        $display("%d tests completed with %d errors", testCounter, errors);
        $finish;
      end
    end
  end
endmodule
