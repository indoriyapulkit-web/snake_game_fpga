module tick_gen(
    input clk,rst,
    output reg tick
    );
    reg [23:0] counter;
    always@(posedge clk or posedge rst)begin
        if(rst) begin
            tick<=0;
            counter<=0;
        end
        else begin
            if(counter>=24'd12499999)begin
                tick<=~tick;
                counter<=0;
            end
            else 
                counter<=counter+1;  
        end
    end
    
endmodule
