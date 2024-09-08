module testbench ();
  logic [3:0] s1, s2;
  logic resetHigh;
  logic segLEn, segREn;
  logic [6:0] seg;
  lab2_vk dut (
      s1,
      s2,
      resetHigh,
      segLEn,
      segREn,
      seg
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

  logic [16:0] testVectors [1000:0]; // format will be switches [3:0], segExpected [6:0], ledsExpected[1:0]


  initial begin
    $display("reading test vectors");
    $readmemb("testbench.tv", testVectors);
    // $display(testVectors);
    testCounter = 0;
    errors = 0;
    resetHigh = 0;
    #27;
    oldLrSeg  = ~lrSeg;
    resetHigh = 1;
    #2;
  end

  always @(posedge clk) begin
    if (oldLrSeg !== lrSeg) begin
      {s1, s2, segLEnExpected, segREnExpected, segExpected} = testVectors[testCounter];
    end
    {switches[3:0], segExpected[6:0], ledsExpected[1:0]} = testVectors[testCounter];
  end

  always @(negedge clk) begin
    if (segOutput !== segExpected || leds[1:0] !== ledsExpected) begin
      $display("Error (test %d): inputs = %b ", errors, switches);
      $display("outputs = %b segment, %b leds, Expected: (%b segment, %b ledsExpected)", segOutput,
               leds, segExpected, ledsExpected);
      errors = errors + 1;
    end
    testCounter = testCounter + 1;
    if (testVectors[testCounter] === 13'bx) begin
      $display("%d tests completed with %d errors", testCounter, errors);
      $finish;
    end
  end
endmodule
