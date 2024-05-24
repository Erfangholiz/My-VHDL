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


module full_adder(a, b, cin, cout, d);
    input a, b, cin;
    wire [1:0] x;
    output d;
    output cout;

    assign x = a + b + cin;
    assign cout = x[1];
    assign d = x[0];

endmodule



module arithmetic_circuit(SEL0, SEL1, A, B, CIN, D, COUT);
input SEL0, SEL1;
input [3:0] A, B;
input CIN;
output [3:0] D;
output COUT;

multiplexer MUX0(SEL0, SEL1, B[3], ~B[3], 1'b0, 1'b1, Y3);
multiplexer MUX1(SEL0, SEL1, B[2], ~B[2], 1'b0, 1'b1, Y2);
multiplexer MUX2(SEL0, SEL1, B[1], ~B[1], 1'b0, 1'b1, Y1);
multiplexer MUX3(SEL0, SEL1, B[0], ~B[0], 1'b0, 1'b1, Y0);


full_adder FA0(A[3], Y3, CIN, cout0, D[3]);
full_adder FA1(A[2], Y2, cout0, cout1, D[2]);
full_adder FA2(A[1], Y1, cout1, cout2, D[1]);
full_adder FA3(A[0], Y0, cout2, COUT, D[0]);

endmodule




module test_arithmetic_circuit;

  reg SEL0, SEL1;
  reg [3:0] A, B;
  reg CIN;
  wire [3:0] D;
  wire COUT;

  arithmetic_circuit dut (
    .SEL0(SEL0),
    .SEL1(SEL1),
    .A(A),
    .B(B),
    .CIN(CIN),
    .D(D),
    .COUT(COUT)
  );

  initial begin
    SEL0 = 1'b0;
    SEL1 = 1'b0;
    A = 4'b0100;
    B = 4'b0010;
    CIN = 1'b0;
    #30;
    
    SEL0 = 1'b0;
    SEL1 = 1'b1;
    A = 4'b0100;
    B = 4'b0010;
    CIN = 1'b0;
    #30;
    
    SEL0 = 1'b0;
    SEL1 = 1'b0;
    A = 4'b0100;
    B = 4'b0010;
    CIN = 1'b1;
    #30;
    
    SEL0 = 1'b1;
    SEL1 = 1'b0;
    A = 4'b0100;
    B = 4'b0010;
    CIN = 1'b0;
    #30;
    
    SEL0 = 1'b1;
    SEL1 = 1'b1;
    A = 4'b0100;
    B = 4'b0010;
    CIN = 1'b0;
    #30;

    $finish;
  end

endmodule





