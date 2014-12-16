module inputconditioner(clk, noisysignal, conditioned, positiveedge, negativeedge);
output reg [0:7] conditioned = 8'b0;
output reg positiveedge = 0;
output reg negativeedge = 0;
input clk;
input [0:7] noisysignal;


parameter counterwidth = 8;
parameter waittime = 8;
integer index = 0;

reg[counterwidth-1:0] counter =0;
reg synchronizer0 = 0;
reg synchronizer1 = 0;
//for(index = 0; index < 16; index = index + 1)
//    begin
//        #5 tb_in_top = tb_in_top + 4'h1;
//    end
always @(posedge clk ) begin
for(index = 0; index<8; index = index +1)
begin
	positiveedge <= 0;
	negativeedge <= 0;
    	if(conditioned[index] == synchronizer1) // conditioned will is equal to the next waittime signal
        	counter <= 0;
    	else begin
        if( counter == waittime) begin //when conditioned has not been equal to the next three waittime signals 
            	counter <= 0; //will set counter back to zero after this cycle
            	conditioned[index] <= synchronizer1; //does not shift until after this cycle
		if (conditioned[index] == 0) begin //during this cycle, checks if the first conditioned (when the next waittime signals have not been equal) is zero
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
    	synchronizer0 = noisysignal[index];
end
end
endmodule


module testConditioner;
wire [7:0]conditioned;
wire rising;
wire falling;
reg clk;
reg [7:0] pin;
reg ri;
always @(posedge clk) ri=rising;
inputconditioner dut(clk, pin, conditioned, rising, falling);

initial clk=0;
always #10 clk=!clk;    // 50MHz Clock

initial begin
// Your Test Code
// Be sure to test each of the three things the conditioner does:
// Synchronize, Clean, Preprocess (edge finding)

pin[0] = 0; //noisy signal will be 0 for of 50ns
pin[1] = 0;
pin[2] = 0;
pin[3] = 0;
pin[4] = 0;
pin[5] = 0;
pin[6] = 0;
pin[7] = 1;
#50 

pin[0] = 1;
pin[1] = 1;
pin[2] = 1;
pin[3] = 1;
pin[4] = 1;
pin[5] = 1;
pin[6] = 1;
pin[7] = 0;
#200 

pin[0] = 0;
pin[1] = 0;
pin[2] = 0;
pin[3] = 0;
pin[4] = 0;
pin[5] = 0;
pin[6] = 0;
pin[7] = 1;
#10 

pin[0] = 1;
pin[1] = 1;
pin[2] = 1;
pin[3] = 1;
pin[4] = 1;
pin[5] = 1;
pin[6] = 1;
pin[7] = 0;
#70 

pin[0] = 0;
pin[1] = 0;
pin[2] = 0;
pin[3] = 0;
pin[4] = 0;
pin[5] = 0;
pin[6] = 0;
pin[7] = 1;
#90

pin[0] = 1;
pin[1] = 1;
pin[2] = 1;
pin[3] = 1;
pin[4] = 1;
pin[5] = 1;
pin[6] = 1;
pin[7] = 0;
#20

pin[0] = 0;
pin[1] = 0;
pin[2] = 0;
pin[3] = 0;
pin[4] = 0;
pin[5] = 0;
pin[6] = 0;
pin[7] = 1;
#100

pin[0] = 1; //#60 on the negative edges 
pin[1] = 1;
pin[2] = 1;
pin[3] = 1;
pin[4] = 1;
pin[5] = 1;
pin[6] = 1;
pin[7] = 0;
#60


pin[0] = 0;
pin[1] = 0;
pin[2] = 0;
pin[3] = 0;
pin[4] = 0;
pin[5] = 0;
pin[6] = 0;
pin[7] = 1;
#20

pin[0] = 1;
pin[1] = 1;
pin[2] = 1;
pin[3] = 1;
pin[4] = 1;
pin[5] = 1;
pin[6] = 1;
pin[7] = 0;
#300

pin[0] = 0; //if not multiples of 10, this is the worst case (maximum glitch length)
pin[1] = 0;
pin[2] = 0;
pin[3] = 0;
pin[4] = 0;
pin[5] = 0;
pin[6] = 0;
pin[7] = 1;
#91

pin[0] = 1;
pin[1] = 1;
pin[2] = 1;
pin[3] = 1;
pin[4] = 1;
pin[5] = 1;
pin[6] = 1;
pin[7] = 0;
#80

//pin[0]= 0;
pin = 8'b00000001;
#61

//pin[0] = 1;
pin = 8'b11111110;
#60

//pin[0] = 0;
pin = 8'b00000001;
#70

//pin[0] = 1;
pin = 8'b11111110;
#90

//pin[0] = 0;
pin = 8'b00000001;

end
endmodule