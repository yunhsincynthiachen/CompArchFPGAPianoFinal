//Top module for the FPGA Piano that 
module top(output [3:0]gpioBank1, output [3:0]gpioBank2, input clk, input [7:0]sw);

	lut_to_notes final(clk, sw[7:0], gpioBank1[0], gpioBank1[1], gpioBank1[2], gpioBank1[3], gpioBank2[0], gpioBank2[1], gpioBank2[2], gpioBank2[3]);

endmodule

//Module that combines all of the parts of the FPGA piano, so that each switch outputs sounds, depending on the LUT
module lut_to_notes(clk, sw, speaker11,speaker22,speaker33,speaker44,speaker55,speaker66,speaker77,speaker88);
input clk;
input[7:0] sw;
output speaker11,speaker22,speaker33,speaker44,speaker55,speaker66,speaker77,speaker88;

wire[16:0] counter1,counter2,counter3,counter4;
wire[15:0] counter5,counter6,counter7,counter8;
wire En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2;

inputconditioner_1 cnote_ic1(clk, sw[0], conditioned1);
inputconditioner_1 dnote_ic1(clk, sw[1], conditioned2);
inputconditioner_1 enote_ic1(clk, sw[2], conditioned3);
inputconditioner_1 fnote_ic1(clk, sw[3], conditioned4);
inputconditioner_1 gnote_ic1(clk, sw[4], conditioned5);
inputconditioner_1 anote_ic1(clk, sw[5], conditioned6);
inputconditioner_1 bnote_ic1(clk, sw[6], conditioned7);
inputconditioner_1 c2note_ic1(clk, sw[7], conditioned8);

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

//lut_to_notes:
module inputconditioner_1(clk, noisysignal, conditioned);
output reg conditioned = 0;
reg positiveedge = 0;
reg negativeedge = 0;
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

module test_all_notes;
reg clk;
reg[7:0] sw;
wire speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8;

lut_to_notes allnotes(clk, sw, speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8);

initial clk = 0;
always #20 clk=!clk;

initial begin
sw = 8'b10010001;
#4000000
$display("%b %b %b", clk, sw, speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8);
sw = 8'b00010010;
#4000000
$display("%b %b %b", clk, sw, speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8);
end
endmodule 