module seven_segment(i0, i1, i2, i3, A, B, C, D, E, F, G);
input i0, i1, i2, i3;
reg [3:0] NUM;
reg [6:0] RES;
output reg A, B, C, D, E, F, G;

always @(*) begin
	NUM[0] = i3;
	NUM[1] = i2;
	NUM[2] = i1;
	NUM[3] = i0;
	
	if(NUM == 4'b0000) begin
		RES <= 7'b1111110;
	end

	if(NUM == 4'b0001) begin
		RES <= 7'b0110000;
	end

	if(NUM == 4'b0010) begin
		RES <= 7'b1101101;
	end

	if(NUM == 4'b0011) begin
		RES <= 7'b1111001;
	end

	if(NUM == 4'b0100) begin
		RES <= 7'b0110011;
	end

	if(NUM == 4'b0101) begin
		RES <= 7'b1011011;
	end

	if(NUM == 4'b0110) begin
		RES <= 7'b1011111;
	end

	if(NUM == 4'b0111) begin
		RES <= 7'b1110000;
	end

	if(NUM == 4'b1000) begin
		RES <= 7'b1111111;
	end

	if(NUM == 4'b1001) begin
		RES <= 7'b1111011;
	end

	A = RES[6];
	B = RES[5];
	C = RES[4];
	D = RES[3];
	E = RES[2];
	F = RES[1];
	G = RES[0];

end

endmodule





module test_seven_segment;

  reg i0, i1, i2, i3;
  wire A, B, C, D, E, F, G;

  seven_segment dut (
    .i0(i0),
    .i1(i1),
    .i2(i2),
    .i3(i3),
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .F(F),
    .G(G)
  );

  initial begin
	i0 = 1'b0;
	i1 = 1'b0;
	i2 = 1'b0;
	i3 = 1'b0;
    #30;

	i0 = 1'b0;
	i1 = 1'b0;
	i2 = 1'b0;
	i3 = 1'b1;
    #30;

	i0 = 1'b0;
	i1 = 1'b0;
	i2 = 1'b1;
	i3 = 1'b0;
    #30;

	i0 = 1'b0;
	i1 = 1'b0;
	i2 = 1'b1;
	i3 = 1'b1;
    #30;

	i0 = 1'b0;
	i1 = 1'b1;
	i2 = 1'b0;
	i3 = 1'b0;
    #30;

	i0 = 1'b0;
	i1 = 1'b1;
	i2 = 1'b0;
	i3 = 1'b1;
    #30;

	i0 = 1'b0;
	i1 = 1'b1;
	i2 = 1'b1;
	i3 = 1'b0;
    #30;

	i0 = 1'b0;
	i1 = 1'b1;
	i2 = 1'b1;
	i3 = 1'b1;
    #30;

	i0 = 1'b1;
	i1 = 1'b0;
	i2 = 1'b0;
	i3 = 1'b0;
    #30;

	i0 = 1'b1;
	i1 = 1'b0;
	i2 = 1'b0;
	i3 = 1'b1;
    #30;
    
    $finish;
  end

endmodule










