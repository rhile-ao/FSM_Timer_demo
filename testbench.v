module testbench;

 // tb signals
 reg ovr;
 reg clk;
 reg rst_n;
 wire out;
 wire [1:0] state;

 // instantiate FSM_Timer_Demo
 fsm_timer_demo dut (
   .out(out),
   .state(state),
   .ovr(ovr),
   .clk(clk),
   .rst_n(rst_n)
 );

 // clock generation
 initial begin
    clk = 0;
    forever #1 clk = ~clk;
 end

 // apply stimuli
 initial begin

    // initialize signals
    rst_n = 0;
    ovr   = 0;

    // hold reset
    repeat(3) @(negedge clk);

    // release reset
    rst_n = 1;

    // allow normal state transitions
    repeat(12) @(negedge clk);

    // activate override
    ovr = 1;
    repeat(4) @(negedge clk);

    // deactivate override
    ovr = 0;
    repeat(8) @(negedge clk);

 end

endmodule