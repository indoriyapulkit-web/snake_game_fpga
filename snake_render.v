module snake_render(
    input [9:0] pixel_x,
    input [9:0] pixel_y,

    input [1199:0] snake_1d,
    input food_valid,
    input [5:0] food_x,
    input [4:0] food_y,

    input video_on,

    output reg [3:0] red,
    output reg [3:0] green,
    output reg [3:0] blue
);

    wire [5:0] grid_x;
    wire [4:0] grid_y;
    wire [10:0] grid_index;

    // Convert pixel coordinates to grid coordinates.
    assign grid_x = pixel_x[9:4];

    // Flip the vertical coordinate.
    // Logical Y = 29 - screen Y.
    assign grid_y = 5'd29 - pixel_y[8:4];

    // Flattened mapping: index = y * 40 + x
    assign grid_index =
        ({6'b0, grid_y} * 11'd40) + {5'b0, grid_x};

    always @(*) begin

        // Default: black outside the visible region
        red   = 4'b0000;
        green = 4'b0000;
        blue  = 4'b0000;

        if (video_on) begin

            // White background
            red   = 4'b1111;
            green = 4'b1111;
            blue  = 4'b1111;

            // Snake: green
            if (snake_1d[grid_index] == 1'b1) begin
                red   = 4'b0000;
                green = 4'b1111;
                blue  = 4'b0000;
            end

            // Food: red, only when valid
            else if (food_valid &&
                     (grid_x == food_x) &&
                     (grid_y == food_y)) begin
                red   = 4'b1111;
                green = 4'b0000;
                blue  = 4'b0000;
            end

        end
    end

endmodule