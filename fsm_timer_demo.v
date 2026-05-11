/*===========================================
               FSM Timer Demo
=============================================
Description:
 

Design Engineer:
 Rhile L. Galpo

Date:
 11 May 2026
--------------------------------------------*/
module fsm_timer_demo(out,state,ovr,clk,rst_n);
 //ports
  input            ovr;
  input            clk;
  input            rst_n;
  output reg       out;
  output reg [1:0] state;
  
 //stat assignment 
  localparam [1:0] S0 = 2'b00;
  localparam [1:0] S1 = 2'b01;
  localparam [1:0] S2 = 2'b10;
  localparam [1:0] S3 = 2'b11;
  reg [1:0] pre;
  reg [1:0] nxt;

  reg [1:0] t;

 //input block
   always @(pre,ovr,t) begin

   case(pre)

     // S0 : 0,1,2 -> next S1
     S0: begin
        if(ovr)
           nxt = S3;
        else if(t == 2)
           nxt = S1;
        else
           nxt = S0;
     end

     // S1 : 0,1,2,3 -> next S2
     S1: begin
        if(ovr)
           nxt = S3;
        else if(t == 3)
           nxt = S2;
        else
           nxt = S1;
     end

     // S2 : 0,1,2 -> next S0
     S2: begin
        if(ovr)
           nxt = S3;
        else if(t == 2)
           nxt = S0;
        else
           nxt = S2;
     end

     // override state
     S3: begin
        if(ovr)
           nxt = S3;
        else
           nxt = S0;
     end

     default: nxt = S0;

   endcase
 end

 //sequential block
   always @(posedge clk or negedge rst_n) begin

   if(!rst_n) begin
      pre <= S0;
      t   <= 0;
   end

   else begin

      pre <= nxt;

      // timer control
      case(pre)

         S0: begin
            if(t == 2)
               t <= 0;
            else
               t <= t + 1;
         end

         S1: begin
            if(t == 3)
               t <= 0;
            else
               t <= t + 1;
         end

         S2: begin
            if(t == 2)
               t <= 0;
            else
               t <= t + 1;
         end

         S3: begin
            t <= 0;
         end

         default: t <= 0;

      endcase
   end
 end

 //output block
  always @(pre) begin

    case(pre)

       S0: begin
          out   = 0;
          state = S0;
       end

       S1: begin
          out   = 0;
          state = S1;
       end

       S2: begin
          out   = 0;
          state = S2;
       end

       S3: begin
          out   = 1;
          state = S3;
       end

       default: begin
          out   = 0;
          state = S0;
       end

    endcase
 end

endmodule