module food_gen(
    input rst, tick, ate,
    input [1199:0] snake,
    output reg [5:0] food_x,
    output reg [4:0] food_y,
    output reg food_valid
);

    reg [15:0] lfsr;
    reg searching;

    wire [5:0] candidate_x;
    wire [4:0] candidate_y;
    wire [10:0] candidate_index;

    // Candidate coordinates
    assign candidate_x = lfsr[5:0];
    assign candidate_y = lfsr[10:6];

    // Flattened index = y * 40 + x
    assign candidate_index =
        candidate_y * 11'd40 + candidate_x;

    always @(posedge tick or posedge rst) begin
        if (rst) begin
            lfsr       <= 16'hACE1;
            food_x     <= 0;
            food_y     <= 0;
            food_valid <= 0;
            searching  <= 1;
        end
        else begin
            // Advance the pseudo-random generator
            lfsr <= {
                lfsr[14:0],
                lfsr[15] ^ lfsr[13] ^
                lfsr[12] ^ lfsr[10]
            };

            // Snake ate the food: request a new location
            if (ate) begin
                searching  <= 1;
                food_valid <= 0;
            end
            else if (searching) begin

                // Check whether candidate is inside the grid
                if ((candidate_x < 40) &&
                    (candidate_y < 30)) begin

                    // Check whether the cell is empty
                    if (snake[candidate_index] == 1'b0) begin
                        food_x     <= candidate_x;
                        food_y     <= candidate_y;
                        food_valid <= 1;
                        searching  <= 0;
                    end
                    else begin
                        searching  <= 1;
                        food_valid <= 0;
                    end

                end
                else begin
                    // Invalid coordinate; try again next tick
                    searching  <= 1;
                    food_valid <= 0;
                end

            end
        end
    end

endmodule