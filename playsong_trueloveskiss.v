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