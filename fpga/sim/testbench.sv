`timescale 1 ns / 1 ns
module testbench ();
  logic [3:0] s1, s2;
  logic nReset;
  logic segLEn, segREn;
  logic [6:0] seg;
  logic [4:0] sum;
  lab2_vk #('d2) dut (
      .s1(s1),
      .s2(s2),
      .nReset(nReset),
      .segLEn(segLEn),
      .segREn(segREn),
      .seg(seg),
      .sum(sum)
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
  logic [4:0] sumExpected;
  logic [21:0] testVectors[1000:0];


  initial begin
    $display("reading test vectors");
    $readmemb("testbench.tv", testVectors);
    testCounter = 0;
    errors = 0;
    nReset = 0;
    #27;
    oldLrSeg = lrSeg;
    nReset   = 1;
    #2;
  end

  always @(posedge clk) begin
    #1;
    if (oldLrSeg !== lrSeg) begin
      {s1, s2, segLEnExpected, segREnExpected, segExpected, sumExpected} = testVectors[testCounter];
    end
  end

  always @(negedge clk) begin
    #1;
    if (oldLrSeg !== lrSeg) begin
      if ({segLEn, segREn, seg, sum} !== {segLEnExpected, segREnExpected, segExpected, sumExpected}) begin
        $display("Error (test %d): inputs = %b, %b ", errors, s1, s2);
        $display(
            "outputs = %b segment; L: %b R: %b; %b sum. Expected: (%b segment; L: %b R: %b; %b sum)",
            seg, segLEn, segREn, sum, segExpected, segLEnExpected, segREnExpected, sumExpected);
        errors = errors + 1;
      end
      oldLrSeg = lrSeg;
      testCounter = testCounter + 1;
      if (testVectors[testCounter] === 22'bx) begin
        $display("%d tests completed with %d errors", testCounter, errors);
        $finish;
      end
    end
  end
endmodule
