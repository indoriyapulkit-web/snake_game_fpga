module snake_logic(
    input rst,tick,food_valid,
    input up,down,left,right,
    input [5:0] food_x,
    input [4:0] food_y,
    output reg  ate,game_over,
    output reg  [10:0]point,
    output reg [1199:0] snake_1d
    );
    integer i,j,k,l;
    reg [5:0]snake_head_x;
    reg [4:0]snake_head_y;
    
    reg [5:0]snake_tail_x;
    reg [4:0]snake_tail_y;

    reg [1:0] direction;
    wire direct_change;
    reg [10:0] snake_stack[0:1199];
    reg else_case;
    assign direct_change=up|down|left|right;
    always@(posedge tick or posedge rst) begin
        if(rst ) begin
            point<=0;
            ate<=0;
            snake_head_x<=19;
            snake_head_y<=14;
            snake_tail_x<=19;
            snake_tail_y<=14;
            snake_1d <= (1200'b1<<579);
            game_over<=0;
            direction<=2'b10;
                else_case<=0;
        end
        else begin
        ate<=0;
        if(!game_over) begin

            if(up||(!direct_change&&direction==2'b00)) begin
                if(food_valid&&((food_x==snake_head_x)&&(food_y==snake_head_y+1))) begin 
                    ate<=1;
                    point<=point+1;
                    snake_head_y<=snake_head_y+1;
                    snake_1d[(snake_head_y+1)*40+snake_head_x]<=1;
                    game_over<=0;
                    else_case<=0;
                end
                else if(snake_head_y==29||snake_1d[(snake_head_y+1)*40+snake_head_x]) begin
                    game_over<=1;
                    ate<=0;
                    else_case<=0;
                end
                else begin
                    snake_head_y<=snake_head_y+1;
                    snake_1d[snake_tail_y*40+snake_tail_x]<=0;
                    snake_1d[(snake_head_y+1)*40+snake_head_x] <= 1;
                    else_case<=1;
                    ate<=0;
                    game_over<=0;
                    if (point == 0) begin
                        snake_tail_x <= snake_head_x;
                        snake_tail_y <= snake_head_y + 1;
                    end
                    else begin
                    snake_tail_x<=snake_stack[1]%40;
                    snake_tail_y<=snake_stack[1]/40;
                end
                end
                direction<=2'b00;
            end
           else if((down||(!direct_change&&direction==2'b01))) begin
                if(food_valid&&((food_x==snake_head_x)&&(food_y==snake_head_y-1))) begin 
                    ate<=1;
                    point<=point+1;
                    snake_head_y<=snake_head_y-1;
                    snake_1d[(snake_head_y-1)*40+snake_head_x]<=1;
                    game_over<=0;
                    else_case<=0;
                end
                else if(snake_head_y==0||snake_1d[(snake_head_y-1)*40+snake_head_x]) begin
                    game_over<=1;
                    ate<=0;
                    else_case<=0;
                end
                else begin
                    snake_head_y<=snake_head_y-1;
                    snake_1d[snake_tail_y*40+snake_tail_x]<=0;
                    snake_1d[(snake_head_y-1)*40+snake_head_x] <= 1;
                    ate<=0;
                    game_over<=0;
                    else_case<=1;
                    if (point == 0) begin
                        snake_tail_x <= snake_head_x;
                        snake_tail_y <= snake_head_y - 1;
                    end
                    else begin
                    snake_tail_x<=snake_stack[1]%40;
                    snake_tail_y<=snake_stack[1]/40;
                end
                end
                direction<=2'b01;
        end
        else if(right||(!direct_change&&direction==2'b10)) begin
                if(food_valid&&((food_x==snake_head_x+1)&&(food_y==snake_head_y))) begin 
                    ate<=1;
                    point<=point+1;
                    snake_head_x<=snake_head_x+1;
                    snake_1d[snake_head_y*40+snake_head_x+1]<=1;
                    game_over<=0;
                    else_case<=0;
                end
                else if(snake_head_x==39||snake_1d[snake_head_y*40+snake_head_x+1]) begin
                    else_case<=0;
                    ate<=0;
                    game_over<=1;
                end
                else begin
                    else_case<=1;
                    snake_head_x<=snake_head_x+1;
                    snake_1d[snake_tail_y*40+snake_tail_x]<=0;
                    snake_1d[snake_head_y*40+snake_head_x+1] <= 1;
                    ate<=0;
                    game_over<=0;        
                    if (point == 0) begin
                        snake_tail_x <= snake_head_x+1;
                        snake_tail_y <= snake_head_y ;
                    end
                    else begin
                    snake_tail_x<=snake_stack[1]%40;
                    snake_tail_y<=snake_stack[1]/40;
                end
                end
                direction<=2'b10;
        end
       else if(left||(!direct_change&&direction==2'b11)) begin
                if(food_valid&&((food_x==snake_head_x-1)&&(food_y==snake_head_y))) begin 
                    ate<=1;
                    point<=point+1;
                    snake_head_x<=snake_head_x-1;
                    snake_1d[snake_head_y*40+snake_head_x-1]<=1;        
                    game_over<=0;
                    else_case<=0;
                end
                else if(snake_head_x==0||snake_1d[snake_head_y*40+snake_head_x-1]) begin
                    game_over<=1;
                    ate<=0;
                    else_case<=0;
                end
                else begin
                    snake_head_x<=snake_head_x-1;
                    snake_1d[snake_tail_y*40+snake_tail_x]<=0;
                    snake_1d[snake_head_y*40+snake_head_x-1] <= 1;
                    ate<=0;
                    game_over<=0;
                    else_case<=1;
                    
                    if (point == 0) begin
                        snake_tail_x <= snake_head_x-1;
                        snake_tail_y <= snake_head_y ;
                    end
                    else begin
                    snake_tail_x<=snake_stack[1]%40;
                    snake_tail_y<=snake_stack[1]/40;
                end 
                end
                direction<=2'b11;
                end
                end
                end
                end
    always@(negedge tick or posedge rst) begin
    if(rst)
        snake_stack[0] <= 11'd579;
    else begin 
        if(food_valid&&((food_x==snake_head_x)&&(food_y==snake_head_y))) begin
                     snake_stack[point] = 40*(snake_head_y)+snake_head_x ;
                     end
        if(else_case) begin
            for (i=0; i<1199; i=i+1) begin
                if(i<point)
                     snake_stack[i]=snake_stack[i+1];
                end
            snake_stack[point]=40*(snake_head_y)+snake_head_x;
                    end
    end
    end
endmodule
