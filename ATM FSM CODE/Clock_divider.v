module Clock_divider( 
input clk, 
output wire clk_out
    );
reg [27:0] counter=28'd0;
reg clock_out;
parameter DIVISOR = 28'd2;

always @(posedge clk)
begin
 counter <= counter + 28'd1;
 if(counter>=(DIVISOR-1))
  counter <= 28'd0;
 clock_out <= (counter<DIVISOR/2)?1'b1:1'b0;
end
assign clk_out=clk;
endmodule