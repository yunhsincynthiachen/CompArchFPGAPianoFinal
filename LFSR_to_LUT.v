module lut_to_LFSR(clk, sw, LFSR_1,LFSR_2,LFSR_3,LFSR1_EN, LFSR2_EN, LFSR3_EN,conditioned1,conditioned2,conditioned3);
input clk;
input[2:0] sw;
output[7:0] LFSR_1, LFSR_2, LFSR_3;

output conditioned1, conditioned2, conditioned3;
output LFSR1_EN, LFSR2_EN, LFSR3_EN;

inputconditioner lfsr1_ic(clk, sw[0], conditioned1);
inputconditioner lfsr2_ic(clk, sw[1], conditioned2);
inputconditioner lfsr3_ic(clk, sw[2], conditioned3);
//inputconditioner fnote_ic(clk, sw[3], conditioned4);
//inputconditioner gnote_ic(clk, sw[4], conditioned5);
//inputconditioner anote_ic(clk, sw[5], conditioned6);
//inputconditioner bnote_ic(clk, sw[6], conditioned7);
//inputconditioner c2note_ic(clk, sw[7], conditioned8);

LFSR_lut LUT(conditioned1,conditioned2,conditioned3, LFSR1_EN, LFSR2_EN, LFSR3_EN);

LFSR1 lfsr_1(clk,LFSR_1,LFSR1_EN);
LFSR2 lfsr_2(clk,LFSR_2,LFSR2_EN);
LFSR3 lfsr_3(clk,LFSR_3,LFSR3_EN);

endmodule 

module test_lut_LFSR;
reg clk;
reg[2:0] sw;
wire[7:0] LFSR_1, LFSR_2, LFSR_3;
wire LFSR1_EN, LFSR2_EN, LFSR3_EN,conditioned1,conditioned2,conditioned3;

lut_to_LFSR allLFSR(clk, sw, LFSR_1,LFSR_2,LFSR_3,LFSR1_EN, LFSR2_EN, LFSR3_EN,conditioned1,conditioned2,conditioned3);

initial clk = 0;
always #20 clk=!clk;

initial begin
sw = 3'b101;
#400
$display("%b %b %b %b %b", clk, sw, LFSR_1,LFSR_2,LFSR_3,LFSR1_EN, LFSR2_EN, LFSR3_EN,conditioned1,conditioned2,conditioned3);
sw = 3'b000;
#400
sw = 3'b010;
#400
$display("%b %b %b %b %b", clk, sw, LFSR_1,LFSR_2,LFSR_3,LFSR1_EN, LFSR2_EN, LFSR3_EN,conditioned1,conditioned2,conditioned3);
end
endmodule 