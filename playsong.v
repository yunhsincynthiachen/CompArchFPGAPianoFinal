module pull_all_truelove(clk,sw_1, speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8);
input sw_1, clk;
output speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8;

inputconditioner incon(clk,sw_1,conditioned);
playSong trueloveskiss_song(clk,conditioned,speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8);

endmodule

module inputconditioner(clk, noisysignal, conditioned);
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

module trueloveskiss(clk, line, speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8);
input clk;
input[7:0] line;
output speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8;

wire[16:0] counter1,counter2,counter3,counter4;
wire[15:0] counter5,counter6,counter7,counter8;
wire En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2;

lut LUT(line[0],line[1],line[2],line[3],line[4],line[5],line[6],line[7], En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2);

musicC cnote(clk, speaker1, counter1, En_C);
musicD dnote(clk, speaker2, counter2, En_D);
musicE enote(clk, speaker3, counter3, En_E);
musicF fnote(clk, speaker4, counter4, En_F);
musicG gnote(clk, speaker5, counter5, En_G);
musicA anote(clk, speaker6, counter6, En_A);
musicB bnote(clk, speaker7, counter7, En_B);
musicC2 c2note(clk, speaker8, counter8, En_C2);

endmodule 

module lut(sw_0, sw_1, sw_2, sw_3, sw_4, sw_5, sw_6, sw_7, En_C, En_D, En_E, En_F, En_G, En_A, En_B, En_C2);
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

module test_playsong;
reg clk;
reg [7:0] line;
wire c, d, e, f, g, a, b, c2;

parameter line1 = 8'b10101000; //CEG
parameter line2 = 8'b00000001; //C2
parameter line3 = 8'b00000010; //B
parameter line4 = 8'b00000001; //C2
parameter line5 = 8'b00001000; //G
parameter line6 = 8'b00100000; //E
parameter line7 = 8'b01000000; //D
parameter line8 = 8'b00100000; //E
parameter line9 = 8'b10101000; //CEG

trueloveskiss trueloves(clk,line,c,d,e,f,g,a,b,c2);

initial clk = 0;
always #20 clk=!clk;

initial begin
line = line1;
#9900000
line = line2;
#9900000
line = line3;
#9900000
line = line4;
#9900000
line = line5;
#9900000
line = line6;
#9900000
line = line7;
#9900000
line = line8;
#9900000
line = line9;
end
endmodule 