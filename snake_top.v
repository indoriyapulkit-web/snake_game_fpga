module snake_top(
    input clk,rst,
    input up, down ,left,right,
    output [3:0] red_o,
    output [3:0] green_o,
    output [3:0] blue_o,
    output hsync_o,
    output vsync_o,
    output reg [6:0] seg_o,
    output reg [7:0] an_o
    );
    wire hsync,vsync,video_on,tick,game_over,ate;
    wire [9:0] pixel_x,pixel_y;
    wire [10:0] point ;
    wire [5:0] food_x;
    wire [4:0] food_y;
    wire [1199:0] snake;
    wire food_valid;
    wire [3:0] red,green,blue;
    VGA_controller vg(clk,rst,hsync,vsync,video_on,pixel_x,pixel_y);
    
    tick_gen ptg(clk,rst,tick);
   
    food_gen fg(rst,tick,ate,snake,food_x,food_y,food_valid);
    
    snake_logic sl(rst,tick,food_valid, up , down, left, right,food_x,food_y,ate,game_over,point,snake);
    
    snake_render sr(pixel_x,pixel_y,snake,food_valid,food_x,food_y,video_on,red,green,blue);
    
    assign red_o=red;
    assign green_o=green;
    assign blue_o=blue;
    assign hsync_o= hsync;
    assign vsync_o=vsync;
    reg [15:0] refresh_counter;
reg [1:0] digit_select;

reg [15:0] bcd;
reg [3:0] current_digit;
reg blank_digit;

integer i;
    // =============================================
// Convert binary point to 4-digit BCD
// =============================================
always @(*) begin
    bcd = 16'd0;

    for (i = 10; i >= 0; i = i - 1) begin

        if (bcd[3:0] >= 5)
            bcd[3:0] = bcd[3:0] + 4'd3;

        if (bcd[7:4] >= 5)
            bcd[7:4] = bcd[7:4] + 4'd3;

        if (bcd[11:8] >= 5)
            bcd[11:8] = bcd[11:8] + 4'd3;

        if (bcd[15:12] >= 5)
            bcd[15:12] = bcd[15:12] + 4'd3;

        bcd = {bcd[14:0], point[i]};
    end
end


// =============================================
// Multiplexing counter
// Assumes clk = 100 MHz
// =============================================
always @(posedge clk or posedge rst) begin
    if (rst) begin
        refresh_counter <= 0;
        digit_select    <= 0;
    end
    else begin
        if (refresh_counter == 16'd49999) begin
            refresh_counter <= 0;
            digit_select <= digit_select + 1'b1;
        end
        else begin
            refresh_counter <= refresh_counter + 1'b1;
        end
    end
end


// =============================================
// Select digit
// AN0 = ones
// AN1 = tens
// AN2 = hundreds
// AN3 = thousands
// =============================================
always @(*) begin
    blank_digit = 0;
    current_digit = 0;

    case (digit_select)
        2'd0: begin
            current_digit = bcd[3:0];
        end

        2'd1: begin
            current_digit = bcd[7:4];
            blank_digit = (bcd[15:4] == 0);
        end

        2'd2: begin
            current_digit = bcd[11:8];
            blank_digit = (bcd[15:8] == 0);
        end

        2'd3: begin
            current_digit = bcd[15:12];
            blank_digit = (bcd[15:12] == 0);
        end
    endcase
end


// =============================================
// Seven-segment decoder
// Nexys A7 uses active-low segment signals
// seg_o[6:0] = {CG,CF,CE,CD,CC,CB,CA}
// =============================================
always @(*) begin
    if (blank_digit) begin
        seg_o = 7'b1111111;
    end
    else begin
        case (current_digit)
            4'd0: seg_o = 7'b1000000;
            4'd1: seg_o = 7'b1111001;
            4'd2: seg_o = 7'b0100100;
            4'd3: seg_o = 7'b0110000;
            4'd4: seg_o = 7'b0011001;
            4'd5: seg_o = 7'b0010010;
            4'd6: seg_o = 7'b0000010;
            4'd7: seg_o = 7'b1111000;
            4'd8: seg_o = 7'b0000000;
            4'd9: seg_o = 7'b0010000;

            default: seg_o = 7'b1111111;
        endcase
    end
end


// =============================================
// Enable one digit at a time
// Nexys A7 anodes are active-low
// =============================================
always @(*) begin
    an_o = 8'b11111111;

    case (digit_select)
        2'd0: an_o[0] = 1'b0;
        2'd1: an_o[1] = 1'b0;
        2'd2: an_o[2] = 1'b0;
        2'd3: an_o[3] = 1'b0;
    endcase
end
endmodule
