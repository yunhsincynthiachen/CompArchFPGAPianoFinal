module lut_to_LFSR(clk, sw, LFSR_1,LFSR_2,LFSR_3,LFSR_4,LFSR_5,LFSR_6,LFSR_7,LFSR_8);
input clk;
input[7:0] sw;
output[7:0] LFSR_1,LFSR_2,LFSR_3,LFSR_4,LFSR_5,LFSR_6,LFSR_7,LFSR_8;

wire conditioned1, conditioned2, conditioned3, conditioned4, conditioned5, conditioned6, conditioned7, conditioned8;
wire LFSR1_EN, LFSR2_EN, LFSR3_EN, LFSR4_EN,LFSR5_EN,LFSR6_EN,LFSR7_EN,LFSR8_EN;

inputconditioner lfsr1_ic(clk, sw[0], conditioned1);
inputconditioner lfsr2_ic(clk, sw[1], conditioned2);
inputconditioner lfsr3_ic(clk, sw[2], conditioned3);
inputconditioner lfsr4_ic(clk, sw[3], conditioned4);
inputconditioner lfsr5_ic(clk, sw[4], conditioned5);
inputconditioner lfsr6_ic(clk, sw[5], conditioned6);
inputconditioner lfsr7_ic(clk, sw[6], conditioned7);
inputconditioner lfsr8_ic(clk, sw[7], conditioned8);

LFSR_lut LUT(conditioned1,conditioned2,conditioned3,conditioned4,conditioned5,conditioned6,conditioned7,conditioned8,LFSR1_EN,LFSR2_EN,LFSR3_EN,LFSR4_EN,LFSR5_EN,LFSR6_EN,LFSR7_EN,LFSR8_EN);

LFSR1 lfsr_1(clk,LFSR_1,LFSR1_EN);
LFSR2 lfsr_2(clk,LFSR_2,LFSR2_EN);
LFSR3 lfsr_3(clk,LFSR_3,LFSR3_EN);
LFSR4 lfsr_4(clk,LFSR_4,LFSR4_EN);
LFSR5 lfsr_5(clk,LFSR_5,LFSR5_EN);
LFSR6 lfsr_6(clk,LFSR_6,LFSR6_EN);
LFSR7 lfsr_7(clk,LFSR_7,LFSR7_EN);
LFSR8 lfsr_8(clk,LFSR_8,LFSR8_EN);

endmodule 

module test_lut_LFSR;
reg clk;
reg[7:0] sw;
wire[7:0] LFSR_1,LFSR_2,LFSR_3,LFSR_4,LFSR_5,LFSR_6,LFSR_7,LFSR_8;

lut_to_LFSR allLFSR(clk, sw, LFSR_1,LFSR_2,LFSR_3,LFSR_4,LFSR_5,LFSR_6,LFSR_7,LFSR_8);

initial clk = 0;
always #10 clk=!clk;

initial begin
sw = 8'b10100000;
#400
$display("%b %b %b %b %b", clk, sw, LFSR_1,LFSR_2,LFSR_3,LFSR_4,LFSR_5,LFSR_6,LFSR_7,LFSR_8);
sw = 8'b0;
#400
sw = 8'b00001011;
#400
$display("%b %b %b %b %b", clk, sw, LFSR_1,LFSR_2,LFSR_3,LFSR_4,LFSR_5,LFSR_6,LFSR_7,LFSR_8);
end
endmodule 