module VGA_controller(
    input clk,
    input rst,

    output reg hsync,
    output reg vsync,
    output reg video_on,

    output reg [9:0] pixel_x,
    output reg [9:0] pixel_y
);

reg pixel_clk;

reg [9:0] h_count;
reg [9:0] v_count;

reg count_pclk;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        pixel_clk <= 0;
        count_pclk<=0;
    end
    else begin 
        if(count_pclk==1) begin
            pixel_clk <= ~pixel_clk;
            count_pclk<=0;
            end
        else 
            count_pclk<=1;
        
    end
end


// Horizontal and vertical counters
always @(posedge pixel_clk or posedge rst) begin
    if (rst) begin
        h_count <= 0;
        v_count <= 0;
    end
    else begin

        if (h_count == 799) begin
            h_count <= 0;

            if (v_count == 524)
                v_count <= 0;
            else
                v_count <= v_count + 1;
        end
        else begin
            h_count <= h_count + 1;
        end

    end
end


// Pixel coordinates
always @(*) begin
    pixel_x = h_count;
    pixel_y = v_count;
end


// Visible area
always @(*) begin
    if ((h_count < 640) && (v_count < 480))
        video_on = 1;
    else
        video_on = 0;
end


always @(*) begin
    if ((h_count >= 656) && (h_count < 752))
        hsync = 0;
    else
        hsync = 1;
end


always @(*) begin
    if ((v_count >= 490) && (v_count < 492))
        vsync = 0;
    else
        vsync = 1;
end

endmodule
