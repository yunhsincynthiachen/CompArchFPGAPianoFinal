
module inputConditioner_wPE(clk, noisysignal, conditioned, positiveedge, negativeedge);
output reg conditioned = 0;
output reg positiveedge = 0;
output reg negativeedge = 0;
input clk, noisysignal;


parameter counterwidth = 3;
parameter waittime = 3;

reg[counterwidth-1:0] counter =0;
reg synchronizer0 = 0;
reg synchronizer1 = 0;

always @(posedge clk ) begin
                positiveedge <= 0;
                negativeedge <= 0;
                if(conditioned == synchronizer1) // conditioned will is equal to the next waittime signal
                counter <= 0;
                else begin
        if( counter == waittime) begin //when conditioned has not been equal to the next three waittime signals 
                counter <= 0; //will set counter back to zero after this cycle
                conditioned <= synchronizer1; //does not shift until after this cycle
                                if (conditioned == 0) begin //during this cycle, checks if the first conditioned (when the next waittime signals have not been equal) is zero
                                                positiveedge <=1; //if 0, there is a rise in the signal
                                end
                                else begin
                                                negativeedge <=1; //if 1, there is a fall in the signal
                                end
        end
        else 
                counter <= counter+1; //when the waittime has not been three, counter keeps adding one, until waittime is three (which then initializes the check above)
                end
                synchronizer1 = synchronizer0;
                synchronizer0 = noisysignal;
end
endmodule

module piano_all(output [3:0]gpioBank1, output [3:0]gpioBank2, input [3:0] btn, input clk, input [7:0]sw);

piano_work_btn btnwork(clk, sw[7:0], btn[0], gpioBank1[0], gpioBank1[1], gpioBank1[2], gpioBank1[3], gpioBank2[0], gpioBank2[1], gpioBank2[2], gpioBank2[3]);
endmodule

module piano_work_btn(clk, sw, btn_0,note1,note2,note3,note4,note5,note6,note7,note8);
`define XOR xor #50
input clk, btn_0;
input[7:0] sw;
output note1,note2,note3,note4,note5,note6,note7,note8;
reg speaker1, speaker2, speaker3, speaker4, speaker5, speaker6, speaker7, speaker8;
reg Lspeaker1, Lspeaker2, Lspeaker3, Lspeaker4, Lspeaker5, Lspeaker6, Lspeaker7, Lspeaker8;
reg positiveedge; 
reg counter = 0; 
reg counter2 = 0;

inputConditioner_wPE inputconditioner2(clk, btn_0, conditioned, positiveedge, negativeedge);

always @(posedge positiveedge) begin 
counter <= counter + 1; 
counter2 <= counter;
end

lut_to_notes pianoplay(clk, counter, sw, speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8);
lut_to_LFSR lfsr101(clk, counter2, sw, Lspeaker1,Lspeaker2,Lspeaker3,Lspeaker4,Lspeaker5,Lspeaker6,Lspeaker7,Lspeaker8);

`XOR orgate1(note1,speaker1,Lspeaker1);
`XOR orgate2(note2, speaker2,Lspeaker2);
`XOR orgate3(note3, speaker3,Lspeaker3);
`XOR orgate4(note4, speaker4,Lspeaker4);
`XOR orgate5(note5, speaker5,Lspeaker5);
`XOR orgate6(note6, speaker6,Lspeaker6);
`XOR orgate7(note7, speaker7,Lspeaker7);
`XOR orgate8(note8, speaker8,Lspeaker8);
endmodule 


//lut_to_notes:
module inputconditioner_1(clk, enable, noisysignal, conditioned);
output reg conditioned = 0;
reg positiveedge = 0;
reg negativeedge = 0;
input clk, noisysignal,enable;


parameter counterwidth = 3;
parameter waittime = 3;

reg[counterwidth-1:0] counter =0;
reg synchronizer0 = 0;
reg synchronizer1 = 0;

always @(posedge clk ) begin
if (enable) begin
	positiveedge <= 0;
	negativeedge <= 0;
    	if(conditioned == synchronizer1) // conditioned will is equal to the next waittime signal
        	counter <= 0;
    	else begin
        if( counter == waittime) begin //when conditioned has not been equal to the next three waittime signals 
            	counter <= 0; //will set counter back to zero after this cycle
            	conditioned <= synchronizer1; //does not shift until after this cycle
		if (conditioned == 0) begin //during this cycle, checks if the first conditioned (when the next waittime signals have not been equal) is zero
			positiveedge <=1; //if 0, there is a rise in the signal
		end
		else begin
			negativeedge <=1; //if 1, there is a fall in the signal
		end
        end
        else 
            	counter <= counter+1; //when the waittime has not been three, counter keeps adding one, until waittime is three (which then initializes the check above)
    	end
    	synchronizer1 = synchronizer0;
    	synchronizer0 = noisysignal;
end
end
endmodule

module lut_to_notes(clk, counter, sw, speaker11,speaker22,speaker33,speaker44,speaker55,speaker66,speaker77,speaker88);
input clk, counter;
input[7:0] sw;
output speaker11,speaker22,speaker33,speaker44,speaker55,speaker66,speaker77,speaker88;

wire[16:0] counter1,counter2,counter3,counter4;
wire[15:0] counter5,counter6,counter7,counter8;
wire En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2;

inputconditioner_1 cnote_ic1(clk, counter, sw[0], conditioned1);
inputconditioner_1 dnote_ic1(clk, counter, sw[1], conditioned2);
inputconditioner_1 enote_ic1(clk, counter, sw[2], conditioned3);
inputconditioner_1 fnote_ic1(clk, counter, sw[3], conditioned4);
inputconditioner_1 gnote_ic1(clk, counter, sw[4], conditioned5);
inputconditioner_1 anote_ic1(clk, counter, sw[5], conditioned6);
inputconditioner_1 bnote_ic1(clk, counter, sw[6], conditioned7);
inputconditioner_1 c2note_ic1(clk, counter, sw[7], conditioned8);

lut_1 LUT_1(conditioned1,conditioned2,conditioned3,conditioned4,conditioned5,conditioned6,conditioned7,conditioned8, En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2);

musicC_1 cnote1(clk, speaker11, counter1, En_C);
musicD_1 dnote1(clk, speaker22, counter2, En_D);
musicE_1 enote1(clk, speaker33, counter3, En_E);
musicF_1 fnote1(clk, speaker44, counter4, En_F);
musicG_1 gnote1(clk, speaker55, counter5, En_G);
musicA_1 anote1(clk, speaker66, counter6, En_A);
musicB_1 bnote1(clk, speaker77, counter7, En_B);
musicC2_1 c2note1(clk, speaker88, counter8, En_C2);

endmodule 


//piano_lut_cc:

module lut_1(sw_0, sw_1, sw_2, sw_3, sw_4, sw_5, sw_6, sw_7, En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2);
input sw_0, sw_1, sw_2, sw_3, sw_4, sw_5, sw_6, sw_7;

output reg En_C = 'b0;
output reg En_D = 'b0;
output reg En_E = 'b0;
output reg En_F = 'b0;
output reg En_G = 'b0;
output reg En_A = 'b0;
output reg En_B = 'b0;
output reg En_C2 = 'b0;

always@(sw_0,sw_1,sw_2,sw_3,sw_4,sw_5,sw_6,sw_7) begin
	En_C2 = sw_7;
	En_B = sw_6;
	En_A = sw_5;
	En_G = sw_4;
	En_F = sw_3;
	En_E = sw_2;
	En_D = sw_1;
	En_C = sw_0;
end
endmodule 


//notes:

module musicC_1(clk, speaker, counter, EN_C);
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

module musicD_1(clk, speaker, counter, EN_D);
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

module musicE_1(clk, speaker, counter, EN_E);
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

module musicF_1(clk, speaker, counter, EN_F);
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
module musicG_1(clk, speaker, counter, EN_F);
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

module musicA_1(clk, speaker, counter, EN_A);
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
module musicB_1(clk, speaker, counter, EN_B);
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

module musicC2_1(clk, speaker, counter, EN_C2);
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
module inputconditioner(clk, enable, noisysignal, conditioned);
output reg conditioned = 0;
reg positiveedge = 0;
reg negativeedge = 0;
input clk, noisysignal, enable;


parameter counterwidth = 3;
parameter waittime = 3;

reg[counterwidth-1:0] counter =0;
reg synchronizer0 = 0;
reg synchronizer1 = 0;

always @(posedge clk ) begin
if (enable) begin
	positiveedge <= 0;
	negativeedge <= 0;
    	if(conditioned == synchronizer1) // conditioned will is equal to the next waittime signal
        	counter <= 0;
    	else begin
        if( counter == waittime) begin //when conditioned has not been equal to the next three waittime signals 
            	counter <= 0; //will set counter back to zero after this cycle
            	conditioned <= synchronizer1; //does not shift until after this cycle
		if (conditioned == 0) begin //during this cycle, checks if the first conditioned (when the next waittime signals have not been equal) is zero
			positiveedge <=1; //if 0, there is a rise in the signal
		end
		else begin
			negativeedge <=1; //if 1, there is a fall in the signal
		end
        end
        else 
            	counter <= counter+1; //when the waittime has not been three, counter keeps adding one, until waittime is three (which then initializes the check above)
    	end
    	synchronizer1 = synchronizer0;
    	synchronizer0 = noisysignal;
end
end
endmodule
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
// CompArch Final Project
// Piano LFSR LUT
// Detects switches being pressed on FPGA and enables the notes

module LFSR_lut(sw_0,sw_1,sw_2,sw_3,sw_4,sw_5,sw_6,sw_7,LFSR1_EN,LFSR2_EN,LFSR3_EN,LFSR4_EN,LFSR5_EN,LFSR6_EN,LFSR7_EN,LFSR8_EN);
input sw_0, sw_1, sw_2, sw_3, sw_4, sw_5, sw_6, sw_7;

output reg LFSR1_EN = 'b0;
output reg LFSR2_EN = 'b0;
output reg LFSR3_EN = 'b0;
output reg LFSR4_EN = 'b0;
output reg LFSR5_EN = 'b0;
output reg LFSR6_EN = 'b0;
output reg LFSR7_EN = 'b0;
output reg LFSR8_EN = 'b0;

always@(sw_0, sw_1, sw_2, sw_3, sw_3, sw_4, sw_5, sw_6, sw_7) begin
	LFSR8_EN = sw_7;
	LFSR7_EN = sw_6;
	LFSR6_EN = sw_5;
	LFSR5_EN = sw_4;
	LFSR4_EN = sw_3;
	LFSR3_EN = sw_2;
	LFSR2_EN = sw_1;
	LFSR1_EN = sw_0;
end
endmodule 
module lut_to_LFSR(clk, counter, sw, LFSR_1,LFSR_2,LFSR_3,LFSR_4,LFSR_5,LFSR_6,LFSR_7,LFSR_8);
input clk, counter;
input[7:0] sw;
output[7:0] LFSR_1,LFSR_2,LFSR_3,LFSR_4,LFSR_5,LFSR_6,LFSR_7,LFSR_8;

wire conditioned1, conditioned2, conditioned3, conditioned4, conditioned5, conditioned6, conditioned7, conditioned8;
wire[16:0] counter1,counter2,counter3,counter4;
wire[15:0] counter5,counter6,counter7,counter8;
wire speaker1, speaker2, speaker3, speaker4, speaker5, speaker6, speaker7, speaker8;
wire EN_C,EN_D,EN_E,EN_F,EN_G,EN_A,EN_B,EN_C2;

inputconditioner lfsr1_ic(clk, counter, sw[0], conditioned1);
inputconditioner lfsr2_ic(clk, counter, sw[1], conditioned2);
inputconditioner lfsr3_ic(clk, counter, sw[2], conditioned3);
inputconditioner lfsr4_ic(clk, counter, sw[3], conditioned4);
inputconditioner lfsr5_ic(clk, counter, sw[4], conditioned5);
inputconditioner lfsr6_ic(clk, counter, sw[5], conditioned6);
inputconditioner lfsr7_ic(clk, counter, sw[6], conditioned7);
inputconditioner lfsr8_ic(clk, counter, sw[7], conditioned8);

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