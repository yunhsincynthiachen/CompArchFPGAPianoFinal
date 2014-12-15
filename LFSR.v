module LFSR1(clk,LFSR,LFSR1_EN);
input clk,LFSR1_EN;
output reg [7:0] LFSR = 8'b11111111;  // put here the initial value

wire feedback = LFSR[7];
always @(posedge clk) begin
if(LFSR1_EN) begin
  LFSR[0] <= feedback;
  LFSR[1] <= LFSR[0];
  LFSR[2] <= LFSR[1] ^ feedback;
  LFSR[3] <= LFSR[2] ^ feedback;
  LFSR[4] <= LFSR[3] ^ feedback;
  LFSR[5] <= LFSR[4];
  LFSR[6] <= LFSR[5];
  LFSR[7] <= LFSR[6];
end
end
endmodule 

module LFSR2(clk,LFSR,LFSR2_EN);
input clk,LFSR2_EN;
output reg [7:0] LFSR = 8'b11011111;  // put here the initial value

wire feedback = LFSR[7];

always @(posedge clk) begin
if(LFSR2_EN) begin
  LFSR[0] <= feedback;
  LFSR[1] <= LFSR[0];
  LFSR[2] <= LFSR[1] ^ feedback;
  LFSR[3] <= LFSR[2];
  LFSR[4] <= LFSR[3] ^ feedback;
  LFSR[5] <= LFSR[4];
  LFSR[6] <= LFSR[5] ^ feedback;
  LFSR[7] <= LFSR[6];
end
end
endmodule 

module LFSR3(clk,LFSR,LFSR3_EN);
input clk,LFSR3_EN;
output reg [7:0] LFSR = 8'b01010101;  // put here the initial value

wire feedback = LFSR[7];

always @(posedge clk) begin
if(LFSR3_EN) begin
  LFSR[0] <= feedback;
  LFSR[1] <= LFSR[0];
  LFSR[2] <= LFSR[1] ^ feedback;
  LFSR[3] <= LFSR[2];
  LFSR[4] <= LFSR[3];
  LFSR[5] <= LFSR[4];
  LFSR[6] <= LFSR[5];
  LFSR[7] <= LFSR[6] ^ feedback;
end
end
endmodule
module LFSR4(clk,LFSR,LFSR4_EN);
input clk,LFSR4_EN;
output reg [7:0] LFSR = 8'b11101111;  // put here the initial value

wire feedback = LFSR[7];
always @(posedge clk) begin
if(LFSR4_EN) begin
  LFSR[0] <= feedback;
  LFSR[1] <= LFSR[0] ^ feedback;
  LFSR[2] <= LFSR[1];
  LFSR[3] <= LFSR[2] ^ feedback;
  LFSR[4] <= LFSR[3];
  LFSR[5] <= LFSR[4];
  LFSR[6] <= LFSR[5];
  LFSR[7] <= LFSR[6];
end
end
endmodule 
module LFSR5(clk,LFSR,LFSR5_EN);
input clk,LFSR5_EN;
output reg [7:0] LFSR = 8'b11111000;  // put here the initial value

wire feedback = LFSR[7];
always @(posedge clk) begin
if(LFSR5_EN) begin
  LFSR[0] <= feedback;
  LFSR[1] <= LFSR[0];
  LFSR[2] <= LFSR[1] ^ feedback;
  LFSR[3] <= LFSR[2];
  LFSR[4] <= LFSR[3] ^ feedback;
  LFSR[5] <= LFSR[4];
  LFSR[6] <= LFSR[5];
  LFSR[7] <= LFSR[6];
end
end
endmodule 
module LFSR6(clk,LFSR,LFSR6_EN);
input clk,LFSR6_EN;
output reg [7:0] LFSR = 8'b01100110;  // put here the initial value

wire feedback = LFSR[7];
always @(posedge clk) begin
if(LFSR6_EN) begin
  LFSR[0] <= feedback;
  LFSR[1] <= LFSR[0];
  LFSR[2] <= LFSR[1] ^ feedback;
  LFSR[3] <= LFSR[2];
  LFSR[4] <= LFSR[3];
  LFSR[5] <= LFSR[4];
  LFSR[6] <= LFSR[5] ^ feedback;
  LFSR[7] <= LFSR[6];
end
end
endmodule 
module LFSR7(clk,LFSR,LFSR7_EN);
input clk,LFSR7_EN;
output reg [7:0] LFSR = 8'b11111111;  // put here the initial value

wire feedback = LFSR[7];
always @(posedge clk) begin
if(LFSR7_EN) begin
  LFSR[0] <= feedback;
  LFSR[1] <= LFSR[0];
  LFSR[2] <= LFSR[1] ^ feedback;
  LFSR[3] <= LFSR[2] ^ feedback;
  LFSR[4] <= LFSR[3] ^ feedback;
  LFSR[5] <= LFSR[4];
  LFSR[6] <= LFSR[5];
  LFSR[7] <= LFSR[6];
end
end
endmodule 
module LFSR8(clk,LFSR,LFSR8_EN);
input clk,LFSR8_EN;
output reg [7:0] LFSR = 8'b10101010;  // put here the initial value

wire feedback = LFSR[7];
always @(posedge clk) begin
if(LFSR8_EN) begin
  LFSR[0] <= feedback;
  LFSR[1] <= LFSR[0] ^ feedback;
  LFSR[2] <= LFSR[1] ^ feedback;
  LFSR[3] <= LFSR[2];
  LFSR[4] <= LFSR[3];
  LFSR[5] <= LFSR[4];
  LFSR[6] <= LFSR[5];
  LFSR[7] <= LFSR[6] ^ feedback;
end
end
endmodule 
module test_LFSR;
reg clk, LFSR3_EN;
wire [7:0] LFSR;

LFSR3 testlfsr(clk,LFSR,LFSR3_EN);

initial clk = 0;
always #20 clk=!clk;

initial begin
LFSR3_EN = 1;
$display("%b, %b", clk,LFSR,LFSR3_EN);
end 
endmodule 