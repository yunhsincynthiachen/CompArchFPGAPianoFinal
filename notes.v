module music(clk, speaker);
input clk;
output speaker;

reg [15:0] counter = 15'b0;

always @(posedge clk)
    if(counter==56817) begin
	counter <= 0;
    end
    else begin
	counter <= counter+1;
    end
assign speaker = counter[15];
endmodule

module testmusic;
reg clk;
wire speaker;

music playnoteA(clk, speaker);

initial clk = 0;
always #10 clk=!clk;

initial begin
#10
#10
$display("%b, %b", clk, speaker);
end 
endmodule
