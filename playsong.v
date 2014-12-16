module pull_all_truelove(clk,speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8,button_en);
input button_en, clk;
output speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8;

inputconditioner incon(clk,button_en,conditioned);
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

module playSong(clk, button_en,speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8);
output speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8;
wire [7:0] song [8:0];
input clk, button_en;

line1 = 8'b10101000; //CEG
line2 = 8'b00000001; //C2
line3 = 8'b00000010; //B
line4 = 8'b00000001; //C2
line5 = 8'b00001000; //G
line6 = 8'b00100000; //E
line7 = 8'b01000000; //D
line8 = 8'b00100000; //E
line9 = 8'b10101000; //CEG

assign song[0] = line1;
assign song[1] = line2;
assign song[2] = line3;
assign song[3] = line4;
assign song[4] = line5;
assign song[5] = line6;
assign song[6] = line7;
assign song[7] = line8;
assign song[8] = line9;

always @(button_en) begin

generate
genvar i;

for (i=0; i<9; i=i+1) begin: song
trueloveskiss kiss(clk,song[i],speaker1,speaker2,speaker3,speaker4,speaker5,speaker6,speaker7,speaker8);
end
endgenerate

end

endmodule 