module multiplexer(s0, s1, i0, i1, y);
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


module microoperations(SEL0, SEL1, A, B, F);
input SEL0, SEL1;
input [3:0] A, B;
output [3:0] F;

multiplexer MUX0(SEL0, SEL1, A[3], B[3], F[3]);
multiplexer MUX1(SEL0, SEL1, A[2], B[2], F[2]);
multiplexer MUX2(SEL0, SEL1, A[1], B[1], F[1]);
multiplexer MUX3(SEL0, SEL1, A[0], B[0], F[0]);

endmodule


module test_microoperations;

    reg SEL0, SEL1;
    reg [3:0] A, B;
    wire [3:0] F;

    microoperations whatever(.SEL0(SEL0), .SEL1(SEL1), .A(A), .B(B), .F(F));
    
    initial begin
    SEL0 = 1'b0;
    SEL1 = 1'b1;
    A = 4'b0101;
    B = 4'b1011;
    #10;
    
    $finish;
    end
endmodule















