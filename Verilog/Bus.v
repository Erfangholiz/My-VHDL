module multiplexer(s0, s1, i0, i1, i2, i3, y);
input s0, s1, i0, i1, i2, i3;
output reg y;

always @(*) begin
    if(!s1 && !s0) begin
        y <= i0;
    end
    
    if(!s1 && s0) begin
        y <= i1;
    end
    
    if(s1 && !s0) begin
        y <= i2;
    end
    
    if(s1 && s0) begin
        y <= i3;
    end
end

endmodule

module bus(y, x, B, C, D, Y);
input x, y;
input [3:0] B, C, D;
output [3:0] Y;

multiplexer MUX0(y, x, 1'b0, B[3], C[3], D[3], Y[3]);
multiplexer MUX1(y, x, 1'b0, B[2], C[2], D[2], Y[2]);
multiplexer MUX2(y, x, 1'b0, B[1], C[1], D[1], Y[1]);
multiplexer MUX3(y, x, 1'b0, B[0], C[0], D[0], Y[0]);

endmodule



module test_bus;
  reg y, x;
  reg [3:0] B, C, D;
  wire [3:0] Y;

  bus dut (
    .y(y),
    .x(x),
    .B(B),
    .C(C),
    .D(D),
    .Y(Y)
  );

  initial begin
	y = 1'b0;
    x = 1'b0;
    B = 4'b1101;
    C = 4'b0101;
    D = 4'b0010;
    #50;

    y = 1'b1;
    x = 1'b0;
    B = 4'b1101;
    C = 4'b0101;
    D = 4'b0010;
    #50;
    
    y = 1'b0;
    x = 1'b1;
    B = 4'b1101;
    C = 4'b0101;
    D = 4'b0010;
    #50;
    
    y = 1'b1;
    x = 1'b1;
    B = 4'b1101;
    C = 4'b0101;
    D = 4'b0010;
    #50;
    
    $finish;
  end

endmodule







