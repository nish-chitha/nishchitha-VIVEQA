`timescale 1ns / 1ps

module top (
    input  wire        clk,          
    input  wire        rst_btn,      
    input  wire [15:0] buttons,     // 16 input pins
    output wire        uart_txd,     // Physical TX pin to PC
    output wire        lcd_rs,      // NEW
    output wire        lcd_rw,      // NEW
    output wire        lcd_e,       // NEW
    output wire [7:0]  lcd_data     // NEW
);

    wire        sys_rst;
    wire [3:0]  src_node, tgt_node;
    wire        start_calc;
    wire        fsm_done;
    
    wire [3:0]  adj_row, adj_col;
    wire [7:0]  adj_weight;
    wire [15:0] dist_rd;
    wire [3:0]  prev_rd_data, prev_rd_addr;
    wire        dist_wr_en, visited_set_en, prev_wr_en;
    wire [3:0]  dist_wr_addr, visited_set_addr, prev_wr_addr;
    wire [15:0] dist_wr_data;
    wire [3:0]  prev_wr_data;
    
    wire        tree_start, tree_done, tree_found;
    wire [15:0] tree_min_dist;
    wire [3:0]  tree_min_idx;
    wire [255:0] dist_flat;
    wire [15:0]  visited_flat;
    
    wire        tx_start, tx_busy, tx_done;
    wire [7:0]  tx_data;
    wire [15:0] final_route_dist;


// --- NEW FIXES START HERE ---
    wire [1:0]  seq_state;      // MUST BE 2 BITS!
    wire [2:0]  lcd_msg_sel;    // MUST BE 3 BITS!

    reg [25:0] reset_stretch_cnt;   // MUST BE 26 BITS to hold 48,000,000!
    reg        reset_flash;         

    always @(posedge clk) begin     
        if (sys_rst) begin
            reset_stretch_cnt <= 26'd48_000_000; // Exactly 2 seconds at 24 MHz
            reset_flash       <= 1'b1;
        end else if (reset_stretch_cnt > 0) begin
            reset_stretch_cnt <= reset_stretch_cnt - 1;
        end else begin
            reset_flash <= 1'b0;
        end
    end
    // --- NEW FIXES END HERE ---


lcd_controller lcd_inst (
    .clk(clk), .rst(sys_rst), .msg_sel(lcd_msg_sel),
    .lcd_rs(lcd_rs), .lcd_rw(lcd_rw), .lcd_e(lcd_e), .lcd_data(lcd_data)
);

    // 1. Keypad Sequencer
    keypad_sequencer seq_inst (
        .clk(clk),
        .rst_btn(rst_btn),
        .raw_buttons(buttons),
        .src_node(src_node),
        .tgt_node(tgt_node),
        .start_calc(start_calc),
        .sys_rst(sys_rst),
        .seq_state_out(seq_state)
    );
assign lcd_msg_sel = reset_flash                 ? 3'd0 :  // Welcome (was 3'd5)
                      fsm_done                     ? 3'd4 :  // Done
                      (seq_state == 2'b10)         ? 3'd3 :  // Calculating
                      (seq_state == 2'b01)         ? 3'd2 :  // Enter Dest
                      (seq_state == 2'b00)         ? 3'd1 :  // Enter Source
                      3'd1;                                   // default -> Enter Source
    // 2. Dijkstra FSM
    dijkstra_fsm fsm_inst (
        .clk(clk),
        .rst(sys_rst),
        .start(start_calc),
        .src_node(src_node),
        .tgt_node(tgt_node),
        .tree_start(tree_start),
        .tree_done(tree_done),
        .tree_found(tree_found),
        .tree_min_dist(tree_min_dist),
        .tree_min_idx(tree_min_idx),
        .adj_row(adj_row),
        .adj_col(adj_col),
        .adj_weight(adj_weight),
        .dist_wr_en(dist_wr_en),
        .dist_wr_addr(dist_wr_addr),
        .dist_wr_data(dist_wr_data),
        .visited_set_en(visited_set_en),
        .visited_set_addr(visited_set_addr),
        .prev_wr_en(prev_wr_en),
        .prev_wr_addr(prev_wr_addr),
        .prev_wr_data(prev_wr_data),
        .dist_rd(dist_rd),
        .fsm_done(fsm_done),
        .min_dist(final_route_dist)
    );

    // 3. Helper Memories & Tree
    bram_adj_matrix adj_matrix_inst (
        .clk(clk),
        .en(1'b1),
        .row_addr(adj_row),
        .col_addr(adj_col),
        .weight_out(adj_weight)
    );

    bram_dist_visited memory_state_inst (
        .clk(clk),
        .rst(sys_rst),
        .dist_wr_en(dist_wr_en),
        .dist_wr_addr(dist_wr_addr),
        .dist_wr_data(dist_wr_data),
        .visited_set_en(visited_set_en),
        .visited_set_addr(visited_set_addr),
        .prev_wr_en(prev_wr_en),
        .prev_wr_addr(prev_wr_addr),
        .prev_wr_data(prev_wr_data),
        .rd_addr(fsm_done ? prev_rd_addr : adj_col), // FSM uses it during calc, Route Reporter during trace
        .dist_rd(dist_rd),
        .prev_rd(prev_rd_data),
        .dist_flat(dist_flat),     
        .visited_flat(visited_flat) 
    );

    comparator_tree tree_inst (
        .clk(clk),
        .rst(sys_rst),
        .start(tree_start),
        .dist_flat(dist_flat),
        .visited_flat(visited_flat),
        .done(tree_done),
        .found(tree_found),
        .min_dist(tree_min_dist),
        .min_idx(tree_min_idx)
    );

    // 4. Route Reporter (UART Controller)
    route_reporter reporter_inst (
        .clk(clk),
        .rst(sys_rst),
        .fsm_done(fsm_done),
        .tgt_node(tgt_node),
        .src_node(src_node),
        .total_dist(final_route_dist), 
        .prev_rd_addr(prev_rd_addr),
        .prev_rd_data(prev_rd_data),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx_busy(tx_busy),
        .tx_done(tx_done)
    );

    // 5. Your provided UART Module
    // 100,000,000 Hz / 115200 Baud = 868 Clocks Per Bit
    uart_tx #(
        .CLKS_PER_BIT(2500),
        .PARITY_EN(0)
    ) uart_inst (
        .clk(clk),
        .rst(sys_rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(uart_txd),
        .tx_busy(tx_busy),
        .tx_done(tx_done)
    );

endmodule