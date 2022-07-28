`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2022 19:58:00
// Design Name: 
// Module Name: mini
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mini(
    input clk,l0,l1,l2,l3,
    output reg [3:0] y,
    output data
    );
    wire s0, s1, l0, l1, l2, l3, d;
    reg [3:0] i;
    
    c_counter_binary_0 counter (                            //counter using ip core
    .CLK(clk),  // input wire CLK
    .Q({s1,s0})      // output wire [1 : 0] Q
    );
    
    assign d = s1 ? ( s0 ? l3 : l2  ) : ( s0 ? l1 : l0);    //mux in data flow
    
    always @ (d,s0,s1)
    begin                                                   //decoder in behav.      
        if(d==1)
        begin
           if (s0==1'b0 & s1==1'b0) i=4'b0001;
           else if(s0==1'b1 & s1==1'b0) i=4'b0010;
           else if(s1==1'b1 & s0==1'b0) i=4'b0100;
           else if(s0==1 & s1==1) i=4'b1000;
           else i=4'bxxxx; 
        end
        else i=4'b0000;
    end
    
    always@(posedge clk)                                  //latch in behav
    begin
        y <= i;
    end
    
    assign data = d;
    
  

    
endmodule
