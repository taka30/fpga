`timescale 1ns/1ps

module frame_edge_process # (
    parameter P_DAT_WIDTH  = 8,
    parameter P_IMG_WIDTH  = 200,
    parameter P_IMG_HEIGHT = 200
) (
    input  [31:0]            i_hcnt,
    input  [31:0]            i_vcnt,
    input  [P_DAT_WIDTH-1:0] i_kernel_0,
    input  [P_DAT_WIDTH-1:0] i_kernel_1,
    input  [P_DAT_WIDTH-1:0] i_kernel_2,
    input  [P_DAT_WIDTH-1:0] i_kernel_3,
    input  [P_DAT_WIDTH-1:0] i_kernel_4,
    input  [P_DAT_WIDTH-1:0] i_kernel_5,
    input  [P_DAT_WIDTH-1:0] i_kernel_6,
    input  [P_DAT_WIDTH-1:0] i_kernel_7,
    input  [P_DAT_WIDTH-1:0] i_kernel_8,
    output reg [P_DAT_WIDTH-1:0] o_kernel_0,
    output reg [P_DAT_WIDTH-1:0] o_kernel_1,
    output reg [P_DAT_WIDTH-1:0] o_kernel_2,
    output reg [P_DAT_WIDTH-1:0] o_kernel_3,
    output reg [P_DAT_WIDTH-1:0] o_kernel_4,
    output reg [P_DAT_WIDTH-1:0] o_kernel_5,
    output reg [P_DAT_WIDTH-1:0] o_kernel_6,
    output reg [P_DAT_WIDTH-1:0] o_kernel_7,
    output reg [P_DAT_WIDTH-1:0] o_kernel_8
);

    always @(*) begin
        if ( ( i_hcnt == 'd0 ) && (i_vcnt == 'd1) ) begin // (top, left)
            o_kernel_0 = i_kernel_0;
            o_kernel_1 = i_kernel_1;
            o_kernel_2 = i_kernel_1;
            o_kernel_3 = i_kernel_3;
            o_kernel_4 = i_kernel_4;
            o_kernel_5 = i_kernel_4;
            o_kernel_6 = i_kernel_3;
            o_kernel_7 = i_kernel_4;
            o_kernel_8 = i_kernel_4;
        end 
        else if ( ( i_hcnt == P_IMG_WIDTH-1 ) && (i_vcnt == P_IMG_HEIGHT) ) begin // (bottom, right)
            o_kernel_0 = i_kernel_4;
            o_kernel_1 = i_kernel_4;
            o_kernel_2 = i_kernel_5;
            o_kernel_3 = i_kernel_4;
            o_kernel_4 = i_kernel_4;
            o_kernel_5 = i_kernel_5;
            o_kernel_6 = i_kernel_7;
            o_kernel_7 = i_kernel_7;
            o_kernel_8 = i_kernel_8; 
        end
        else if ( ( i_hcnt == 'd0 ) && (i_vcnt == P_IMG_HEIGHT) ) begin // (bottom, left) 
            o_kernel_0 = i_kernel_3;
            o_kernel_1 = i_kernel_4;
            o_kernel_2 = i_kernel_4;
            o_kernel_3 = i_kernel_3;
            o_kernel_4 = i_kernel_4;
            o_kernel_5 = i_kernel_4;
            o_kernel_6 = i_kernel_6;
            o_kernel_7 = i_kernel_7;
            o_kernel_8 = i_kernel_7; 
        end
        else if ( ( i_hcnt == P_IMG_WIDTH-1 ) && (i_vcnt == 'd1) ) begin // (top, right)
            o_kernel_0 = i_kernel_1;
            o_kernel_1 = i_kernel_1;
            o_kernel_2 = i_kernel_2;
            o_kernel_3 = i_kernel_4;
            o_kernel_4 = i_kernel_4;
            o_kernel_5 = i_kernel_5;
            o_kernel_6 = i_kernel_4;
            o_kernel_7 = i_kernel_4;
            o_kernel_8 = i_kernel_5; 
        end
        else if ( i_hcnt == 'd0 ) begin // (x, left)
            o_kernel_0 = i_kernel_0;
            o_kernel_1 = i_kernel_1;
            o_kernel_2 = i_kernel_1;
            o_kernel_3 = i_kernel_3;
            o_kernel_4 = i_kernel_4;
            o_kernel_5 = i_kernel_4;
            o_kernel_6 = i_kernel_6;
            o_kernel_7 = i_kernel_7;
            o_kernel_8 = i_kernel_7; 
        end
        else if ( i_vcnt == 'd1 ) begin // (top, x)
            o_kernel_0 = i_kernel_0;
            o_kernel_1 = i_kernel_1;
            o_kernel_2 = i_kernel_2;
            o_kernel_3 = i_kernel_3;
            o_kernel_4 = i_kernel_4;
            o_kernel_5 = i_kernel_5;
            o_kernel_6 = i_kernel_3;
            o_kernel_7 = i_kernel_4;
            o_kernel_8 = i_kernel_5; 
        end
        else if ( i_hcnt == P_IMG_WIDTH-1 ) begin // (x, right)
            o_kernel_0 = i_kernel_1;
            o_kernel_1 = i_kernel_1;
            o_kernel_2 = i_kernel_2;
            o_kernel_3 = i_kernel_4;
            o_kernel_4 = i_kernel_4;
            o_kernel_5 = i_kernel_5;
            o_kernel_6 = i_kernel_7;
            o_kernel_7 = i_kernel_7;
            o_kernel_8 = i_kernel_8;                        
        end
        else if ( i_vcnt == P_IMG_HEIGHT ) begin // (bottom, x)
            o_kernel_0 = i_kernel_3;
            o_kernel_1 = i_kernel_4;
            o_kernel_2 = i_kernel_5;
            o_kernel_3 = i_kernel_3;
            o_kernel_4 = i_kernel_4;
            o_kernel_5 = i_kernel_5;
            o_kernel_6 = i_kernel_6;
            o_kernel_7 = i_kernel_7;
            o_kernel_8 = i_kernel_8;            
        end
        else begin // other
            o_kernel_0 = i_kernel_0;
            o_kernel_1 = i_kernel_1;
            o_kernel_2 = i_kernel_2;
            o_kernel_3 = i_kernel_3;
            o_kernel_4 = i_kernel_4;
            o_kernel_5 = i_kernel_5;
            o_kernel_6 = i_kernel_6;
            o_kernel_7 = i_kernel_7;
            o_kernel_8 = i_kernel_8;            
        end
    end
endmodule

module average_filter_3x3 # (
    parameter P_DAT_WIDTH  = 8,
    parameter P_IMG_WIDTH  = 200,
    parameter P_IMG_HEIGHT = 200
) (
    input i_clk,
    input i_rstn,
    // axi4 stream slave
    input  [P_DAT_WIDTH-1:0] i_saxis_tdata,
    output                   o_saxis_tready,
    input                    i_saxis_tvalid,
    input                    i_saxis_tuer,
    input                    i_saxis_tlast,

    // axi4 stream master
    output [P_DAT_WIDTH-1:0] o_maxis_tdata,
    input                    i_maxis_tready,
    output                   o_maxis_tvalid,
    output                   o_maxis_tuer,
    output                   o_maxis_tlast
);
    // reg & wire declaratiion
    reg  [P_DAT_WIDTH-1:0] r_kernel [8:0];
    wire [P_DAT_WIDTH-1:0] w_line_data [2:0];
    wire                   w_line_valid [2:0];
    reg  [31:0] r_delay_cnt;
    reg  [31:0] r_hcnt;
    reg  [31:0] r_vcnt;
    reg  [31:0] r_hcnt_delay [2:0];
    reg  [31:0] r_vcnt_delay [2:0];
    wire w_rd_en;
    wire w_wr_en;
    reg  [11:0] r_sum;
    wire [11:0] w_sum;
    wire [11:0] w_div9_out;
    wire [P_DAT_WIDTH-1:0] w_kernel [8:0];

    // axi4-stream master interface
    assign o_saxis_tready = 1'b1;
    assign o_maxis_tdata = w_div9_out[7:0];
    assign o_maxis_tvalid = w_line_valid[1];
    assign o_maxis_tuer = ((r_vcnt_delay[2] == 'd1) && (r_hcnt_delay[2] == 'd0));
    assign o_maxis_tlast = (r_hcnt_delay[2] == P_IMG_WIDTH-1);

    // copying in a frame edge.
    frame_edge_process # (
        .P_DAT_WIDTH(P_DAT_WIDTH),
        .P_IMG_WIDTH(P_IMG_WIDTH),
        .P_IMG_WIDTH(P_IMG_HEIGHT)
    ) frame_edge_process_inst (
        .i_hcnt (r_hcnt_delay[2]),
        .i_vcnt (r_vcnt_delay[2]),
        .i_kernel_0 (r_kernel[0]),
        .i_kernel_1 (r_kernel[1]),
        .i_kernel_2 (r_kernel[2]),
        .i_kernel_3 (r_kernel[3]),
        .i_kernel_4 (r_kernel[4]),
        .i_kernel_5 (r_kernel[5]),
        .i_kernel_6 (r_kernel[6]),
        .i_kernel_7 (r_kernel[7]),
        .i_kernel_8 (r_kernel[8]),
        .o_kernel_0 (w_kernel[0]),
        .o_kernel_1 (w_kernel[1]),
        .o_kernel_2 (w_kernel[2]),
        .o_kernel_3 (w_kernel[3]),
        .o_kernel_4 (w_kernel[4]),
        .o_kernel_5 (w_kernel[5]),
        .o_kernel_6 (w_kernel[6]),
        .o_kernel_7 (w_kernel[7]),
        .o_kernel_8 (w_kernel[8])
    );

    // Calculate average value. 
    assign w_sum = (
        {4'b0000, w_kernel[0]} + 
        {4'b0000, w_kernel[1]} + 
        {4'b0000, w_kernel[2]} + 
        {4'b0000, w_kernel[3]} + 
        {4'b0000, w_kernel[4]} + 
        {4'b0000, w_kernel[5]} + 
        {4'b0000, w_kernel[6]} + 
        {4'b0000, w_kernel[7]} + 
        {4'b0000, w_kernel[8]}
    );    
    always @( posedge i_clk) r_sum <= w_sum;

    // 2 cycles latency
    div9 div9_inst (
        .ap_clk (i_clk),
        .ap_rst (~i_rstn),
        .src_V  (r_sum),
        .dst_V  (w_div9_out)
    );

    // 3x3 matrix structure
    genvar i;
    generate
       for (i = 0; i < 3; i=i+1) begin : gen_matrix
            // kernel 
            always @( posedge i_clk ) begin 
                if (~i_rstn) begin
                    r_kernel[3*i+0] <= 'd0;
                    r_kernel[3*i+1] <= 'd0;
                    r_kernel[3*i+2] <= 'd0;
                end
                else if (i_saxis_tvalid) begin
                    r_kernel[3*i+0] <= w_line_data[i];
                    r_kernel[3*i+1] <= r_kernel[3*i+0];
                    r_kernel[3*i+2] <= r_kernel[3*i+1];
                end
            end
            
            // line buffer 
            if (i > 0) begin
                line_buffer # (
                    .P_DAT_WIDTH (P_DAT_WIDTH),
                    .P_IMG_WIDTH (P_IMG_WIDTH)
                ) line_buffer_inst (
                    .i_clk   (i_clk),
                    .i_rstn  (i_rstn),
                    .i_valid (w_line_valid[i-1]),
                    .i_data  (w_line_data[i-1]),
                    .o_valid (w_line_valid[i]),
                    .o_data  (w_line_data[i])
                );           
            end
            else begin 
                assign w_line_data[0]  = i_saxis_tdata;
                assign w_line_valid[0] = i_saxis_tvalid;
            end 
        end
    endgenerate
    
    // Generate sync signals 
    always @( posedge i_clk ) begin : vertical_coutner
        if (~i_rstn) begin
            r_vcnt <= 'd0; 
        end
        else if (i_saxis_tvalid) begin
            if (i_saxis_tuer) r_vcnt <= 'd0;
            else if (i_saxis_tlast) r_vcnt <= r_vcnt + 'd1;
            else r_vcnt <= r_vcnt;
        end
        else begin
            r_vcnt <= r_vcnt;
        end
    end
    always @( posedge i_clk ) begin
        if (~i_rstn) begin
            r_vcnt_delay[0] <= 'd0;
            r_vcnt_delay[1] <= 'd0;
            r_vcnt_delay[2] <= 'd0;
        end
        else if (i_saxis_tvalid) begin
            r_vcnt_delay[2:0] <= {r_vcnt_delay[1:0], r_vcnt};
        end
        else begin
            r_vcnt_delay[2:0] <= r_vcnt_delay[2:0];
        end
    end

    always @( posedge i_clk ) begin : horizantal_counter
        if (~i_rstn) begin
            r_hcnt <= 'd0; 
        end
        else if (i_saxis_tvalid) begin
            if (i_saxis_tlast) r_hcnt <= 'd0;
            else r_hcnt <= r_hcnt + 'd1;
        end
        else begin
            r_hcnt <= r_hcnt;
        end
    end
    always @( posedge i_clk ) begin
        if (~i_rstn) begin
            r_hcnt_delay[0] <= 'd0;
            r_hcnt_delay[1] <= 'd0;
            r_hcnt_delay[2] <= 'd0;
        end
        else if (i_saxis_tvalid) begin
            r_hcnt_delay[2:0] <= {r_hcnt_delay[1:0], r_hcnt};
        end
        else begin
            r_hcnt_delay[2:0] <= r_hcnt_delay[2:0];
        end
    end

endmodule