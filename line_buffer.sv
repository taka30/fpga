`timescale 1ns/1ps

module line_buffer # (
    parameter P_DAT_WIDTH = 8,
    parameter P_IMG_WIDTH = 200
) (
    input                   i_clk,
    input                   i_rstn,
    input                   i_valid,
    input [P_DAT_WIDTH-1:0] i_data,
    input                   o_valid,
    input [P_DAT_WIDTH-1:0] o_data

);
    wire w_rd_en, w_wr_en;
    reg [31:0] r_delay_cnt;

    always @( posedge i_clk ) begin 
        if (~i_rstn) begin
            r_delay_cnt <= 'd0;
        end
        else if ( i_valid && (r_delay_cnt >= P_IMG_WIDTH) ) begin
            r_delay_cnt <= P_IMG_WIDTH;
        end
        else if ( i_valid ) begin
            r_delay_cnt <= r_delay_cnt + 'd1;
        end
        else begin
            r_delay_cnt <= r_delay_cnt;
        end
    end
  
    assign w_wr_en = i_valid;
    assign w_rd_en = i_valid & (r_delay_cnt == P_IMG_WIDTH);
    assign o_valid = w_rd_en;

    xfifo_0 line_buff (
        .clk         ( i_clk ),
        .srst        ( ~i_rstn  ),
        .din         ( i_data   ),
        .wr_en       ( w_wr_en  ),
        .rd_en       ( w_rd_en  ),
        .dout        ( o_data   ),
        .full        (  ), // open
        .empty       (  ), // open
        .wr_rst_busy (  ), // open
        .rd_rst_busy (  )  // open
    );
   
endmodule