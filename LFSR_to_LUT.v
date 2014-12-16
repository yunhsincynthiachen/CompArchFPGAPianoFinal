module musicC(clk, speaker, counter, EN_C);
//261.6 HZ
input clk;
input EN_C;
output speaker;

output reg [16:0] counter = 17'b0;

always @(posedge clk)
	if(EN_C) begin
		if(counter==95566) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[16];
endmodule
module musicD(clk, speaker, counter, EN_D);
//293.7 HZ
input clk;
input EN_D;
output speaker;

output reg [16:0] counter = 17'b0;

always @(posedge clk)
	if(EN_D) begin
		if(counter==85121) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[16];
endmodule

module musicE(clk, speaker, counter, EN_E);
//329.6 HZ
input clk;
input EN_E;
output speaker;

output reg [16:0] counter = 17'b0;

always @(posedge clk)
	if(EN_E) begin
		if(counter==75850) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[16];
endmodule

module musicF(clk, speaker, counter, EN_F);
//349.2 HZ
input clk;
input EN_F;
output speaker;

output reg [16:0] counter = 17'b0;

always @(posedge clk)
	if(EN_F) begin
		if(counter==71592) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[16];
endmodule
module musicG(clk, speaker, counter, EN_F);
//392 HZ
input clk;
input EN_F;
output speaker;

output reg [15:0] counter = 16'b0;

always @(posedge clk)
	if(EN_F) begin
    		if(counter==63776) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[15];
endmodule

module musicA(clk, speaker, counter, EN_A);
//440 HZ
input clk;
input EN_A;
output speaker;

output reg [15:0] counter = 16'b0;

always @(posedge clk)
	if(EN_A) begin
		if(counter==56818) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[15];
endmodule
module musicB(clk, speaker, counter, EN_B);
//493.9 HZ
input clk;
input EN_B;
output speaker;

output reg [15:0] counter = 16'b0;

always @(posedge clk)
	if(EN_B) begin
		if(counter==50618) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[15];
endmodule

module musicC2(clk, speaker, counter, EN_C2);
//523.3 HZ
input clk;
input EN_C2;
output speaker;

output reg [15:0] counter = 16'b0;

always @(posedge clk)
	if(EN_C2) begin
		if(counter==47774) begin
			counter <= 0;
    		end
    		else begin
			counter <= counter+1;
    		end
	end
assign speaker = counter[15];
endmodule
module lut_to_LFSR(clk, sw, LFSR_1,LFSR_2,LFSR_3,LFSR_4,LFSR_5,LFSR_6,LFSR_7,LFSR_8);
input clk;
input[7:0] sw;
output[7:0] LFSR_1,LFSR_2,LFSR_3,LFSR_4,LFSR_5,LFSR_6,LFSR_7,LFSR_8;

wire conditioned1, conditioned2, conditioned3, conditioned4, conditioned5, conditioned6, conditioned7, conditioned8;
wire[16:0] counter1,counter2,counter3,counter4;
wire[15:0] counter5,counter6,counter7,counter8;
wire speaker1, speaker2, speaker3, speaker4, speaker5, speaker6, speaker7, speaker8;
wire EN_C,EN_D,EN_E,EN_F,EN_G,EN_A,EN_B,EN_C2;

inputconditioner lfsr1_ic(clk, sw[0], conditioned1);
inputconditioner lfsr2_ic(clk, sw[1], conditioned2);
inputconditioner lfsr3_ic(clk, sw[2], conditioned3);
inputconditioner lfsr4_ic(clk, sw[3], conditioned4);
inputconditioner lfsr5_ic(clk, sw[4], conditioned5);
inputconditioner lfsr6_ic(clk, sw[5], conditioned6);
inputconditioner lfsr7_ic(clk, sw[6], conditioned7);
inputconditioner lfsr8_ic(clk, sw[7], conditioned8);

LFSR_lut LUT(conditioned1,conditioned2,conditioned3,conditioned4,conditioned5,conditioned6,conditioned7,conditioned8,EN_C,EN_D,EN_E,EN_F,EN_G,EN_A,EN_B,EN_C2);

musicC CredoCLK (clk, speaker1, counter1, EN_C);
musicD DredoCLK (clk, speaker2, counter2, EN_D);
musicE EredoCLK (clk, speaker3, counter3, EN_E);
musicF FredoCLK (clk, speaker4, counter4, EN_F);
musicG GredoCLK (clk, speaker5, counter5, EN_G);
musicA AredoCLK (clk, speaker6, counter6, EN_A);
musicB BredoCLK (clk, speaker7, counter7, EN_B);
musicC2 C2redoCLK (clk, speaker8, counter8, EN_C2);

LFSR1 lfsr_1(speaker1,LFSR_1,EN_C);
LFSR2 lfsr_2(speaker2,LFSR_2,EN_D);
LFSR3 lfsr_3(speaker3,LFSR_3,EN_E);
LFSR4 lfsr_4(speaker4,LFSR_4,EN_F);
LFSR5 lfsr_5(speaker5,LFSR_5,EN_G);
LFSR6 lfsr_6(speaker6,LFSR_6,EN_A);
LFSR7 lfsr_7(speaker7,LFSR_7,EN_B);
LFSR8 lfsr_8(speaker8,LFSR_8,EN_C2);

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