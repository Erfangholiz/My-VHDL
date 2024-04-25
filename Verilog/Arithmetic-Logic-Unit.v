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

module logic_multiplexer(s0, s1, i0, i1, y);
input s0, s1, i0, i1;
output reg y;

always @(*) begin
    if(!s1 && !s0) begin
        y <= i0 & i1;
    end
    
    if(!s1 && s0) begin
        y <= i0 | i1;
    end
    
    if(s1 && !s0) begin
        y <= i0 ^ i1;
    end
    
    if(s1 && s0) begin
        y <= ~i0;
    end
end

endmodule


module full_adder(a, b, cin, cout, d);
input a, b, cin;
output reg cout, d;

always @(*) begin
    if((a && b && cin) || (a && !b && !cin) || (!a && b && !cin) || (!a && !b && cin)) begin
        d <= 1'b1;
    end
    
    else begin
        if((!a && b && cin) || (a && !b && cin) || (a && b && !cin) || (!a && !b && !cin)) begin
            d <= 1'b0;
        end
    end
    
    if((a && b && cin) || (!a && b && cin) || (a && !b && cin) || (a && b && !cin)) begin
        cout <= 1'b1;
    end
    
    else begin
        if((a && !b && !cin) || (!a && b && !cin) || (!a && !b && cin) || (!a && !b && !cin)) begin
            cout <= 1'b0;
        end
    end
end

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



module microoperations(SEL0, SEL1, A, B, F);
input SEL0, SEL1;
input [3:0] A, B;
output [3:0] F;

logic_multiplexer MUX4(SEL0, SEL1, A[3], B[3], F[3]);
logic_multiplexer MUX5(SEL0, SEL1, A[2], B[2], F[2]);
logic_multiplexer MUX6(SEL0, SEL1, A[1], B[1], F[1]);
logic_multiplexer MUX7(SEL0, SEL1, A[0], B[0], F[0]);

endmodule



module arithmetic_logic_unit(SEL0, SEL1, SEL2, SEL3, A, B, CIN, F, COUT);
input SEL0, SEL1, SEL2, SEL3, CIN;
input [3:0] A, B;
output COUT;
output [3:0] F;
wire [3:0] D, E;

arithmetic_circuit AC(SEL0, SEL1, A, B, CIN, D, COUT);

microoperations M(SEL0, SEL1, A, B, E);

multiplexer MUX8(SEL2, SEL3, D[3], E[3], A[2], 1'b0, F[3]);
multiplexer MUX9(SEL2, SEL3, D[2], E[2], A[1], A[3], F[2]);
multiplexer MUX10(SEL2, SEL3, D[1], E[1], A[0], A[2], F[1]);
multiplexer MUX11(SEL2, SEL3, D[0], E[0], 1'b0, A[1], F[0]);


endmodule




module test_arithmetic_logic_unit;
  reg SEL0, SEL1, SEL2, SEL3;
  reg [3:0] A, B;
  reg CIN;
  wire [3:0] F;
  wire COUT;

  arithmetic_logic_unit dut (
    .SEL0(SEL0),
    .SEL1(SEL1),
    .SEL2(SEL2),
    .SEL3(SEL3),
    .A(A),
    .B(B),
    .CIN(CIN),
    .F(F),
    .COUT(COUT)
  );

  initial begin
    SEL0 = 1'b0;
    SEL1 = 1'b0;
    SEL2 = 1'b0;
    SEL3 = 1'b0;
    A = 4'b0100;
    B = 4'b0010;
    CIN = 1'b0;
    #30;
    
    SEL0 = 1'b1;
    SEL1 = 1'b0;
    SEL2 = 1'b0;
    SEL3 = 1'b0;
    A = 4'b0100;
    B = 4'b0010;
    CIN = 1'b0;
    #50;
    
    SEL0 = 1'b0;
    SEL1 = 1'b1;
    SEL2 = 1'b0;
    SEL3 = 1'b0;
    A = 4'b0100;
    B = 4'b0010;
    CIN = 1'b0;
    #50;
    
    SEL0 = 1'b1;
    SEL1 = 1'b1;
    SEL2 = 1'b0;
    SEL3 = 1'b0;
    A = 4'b0100;
    B = 4'b0010;
    CIN = 1'b0;
    #50;
    
    SEL0 = 1'b0;
    SEL1 = 1'b0;
    SEL2 = 1'b1;
    SEL3 = 1'b0;
    A = 4'b0100;
    B = 4'b0010;
    CIN = 1'b0;
    #50;
    
    SEL0 = 1'b1;
    SEL1 = 1'b0;
    SEL2 = 1'b1;
    SEL3 = 1'b0;
    A = 4'b0100;
    B = 4'b0010;
    CIN = 1'b0;
    #50;
    
    SEL0 = 1'b0;
    SEL1 = 1'b1;
    SEL2 = 1'b1;
    SEL3 = 1'b0;
    A = 4'b0100;
    B = 4'b0010;
    CIN = 1'b0;
    #50;
    
    SEL0 = 1'b1;
    SEL1 = 1'b1;
    SEL2 = 1'b1;
    SEL3 = 1'b0;
    A = 4'b0100;
    B = 4'b0010;
    CIN = 1'b0;
    #50;
    
    SEL0 = 1'b0;
    SEL1 = 1'b0;
    SEL2 = 1'b0;
    SEL3 = 1'b1;
    A = 4'b0100;
    B = 4'b0010;
    CIN = 1'b0;
    #50;
    
    SEL0 = 1'b0;
    SEL1 = 1'b0;
    SEL2 = 1'b1;
    SEL3 = 1'b1;
    A = 4'b0100;
    B = 4'b0010;
    CIN = 1'b0;
    #50;
    
    

    $finish;
  end

endmodule




















