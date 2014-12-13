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


/*module testConditioner;
wire conditioned;
reg pin, clk;

inputconditioner dut(clk, pin, conditioned);

initial clk=0;
always #10 clk=!clk;    // 50MHz Clock

initial begin
// Your Test Code
// Be sure to test each of the three things the conditioner does:
// Synchronize, Clean, Preprocess (edge finding)

pin = 0; //noisy signal will be 0 for of 50ns
#50 

pin = 1;
#200 

pin = 0;
#10 

pin = 1;
#70 

pin = 0;
#90

pin = 1;
#20

pin = 0;
#100

pin = 1; //#60 on the negative edges 
#60

pin = 0;
#20

pin = 1;
#300

pin = 0; //if not multiples of 10, this is the worst case (maximum glitch length)
#91

pin = 1;
#80

pin= 0;
#61

pin = 1;
#60

pin = 0;
#70

pin = 1;
#90

pin = 0;

end
endmodule */
