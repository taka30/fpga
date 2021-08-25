`timescale 1ns/1ps


module tb ();

    parameter P_CLK_PERIOD = 1.666;
    parameter P_DAT_WIDTH  = 8;
    parameter P_IMG_WIDTH  = 200;
    parameter P_IMG_HEIGHT = 200;
    parameter P_BLK_CYCLE  = 30;
    parameter P_INPUT_DELAY = 0;

    // clock & reset
    reg r_sysclk;
    reg r_rstn;

    // axi4 stream master
    reg [P_DAT_WIDTH-1:0] r_maxis_tdata  = 'd0;
    reg                   r_maxis_tvalid = 1'b0;
    wire                  w_maxis_tready;
    reg                   r_maxis_tuser  = 1'b0;
    reg                   r_maxis_tlast  = 1'b0;

    // axi4 stream slave
    wire [P_DAT_WIDTH-1:0] w_saxis_tdata;
    wire                   w_saxis_tvalid;
    reg                    r_saxis_tready = 1'b0;
    wire                   w_saxis_tuser;
    wire                   w_saxis_tlast;

    wire [11:0] w_cnt;
    wire [11:0] w_div9_out;
    wire [7:0]  w_dout [3:0];

    assign w_maxis_tready = r_saxis_tready;

    // Generate clock
    initial begin 
        r_sysclk = 1'b0;
        forever #(P_CLK_PERIOD/2) r_sysclk = ~r_sysclk;
    end

    // Test pattern
    integer ix = 0, iy = 0;   
    reg [P_DAT_WIDTH-1:0] img_cnt = 'd0;
    initial begin
        
        // reset
        r_rstn = 1'b0;

        repeat (10) @(posedge r_sysclk);
   
        // release reset
        r_rstn = 1'b1;
        r_saxis_tready = 1'b1;

        for (iy = 0; iy < P_IMG_HEIGHT; iy=iy+1) begin
            for (ix=0; ix < P_IMG_WIDTH; ix=ix+1) begin

                @ (posedge r_sysclk);

                while ( w_maxis_tready != 1'b1 ); // wait
                
                if ( (ix == 0) && (iy == 0) ) begin
                     r_maxis_tdata  = #(P_INPUT_DELAY) ix;
                     r_maxis_tvalid = #(P_INPUT_DELAY) 'd1;
                     r_maxis_tuser  = #(P_INPUT_DELAY) 'd1;
                     r_maxis_tlast  = #(P_INPUT_DELAY) 'd0;
                end
                else if (ix == P_IMG_WIDTH-1) begin
                     r_maxis_tdata  = #(P_INPUT_DELAY) ix;
                     r_maxis_tvalid = #(P_INPUT_DELAY) 'd1;
                     r_maxis_tuser  = #(P_INPUT_DELAY) 'd0;
                     r_maxis_tlast  = #(P_INPUT_DELAY) 'd1;                    
                end
                else if (
                    ( (ix >= 0) && (ix < P_IMG_WIDTH)) && 
                    ( (iy >= 0) && (iy < P_IMG_HEIGHT))
                ) begin
                     r_maxis_tdata  = #(P_INPUT_DELAY) ix;
                     r_maxis_tvalid = #(P_INPUT_DELAY) 'd1;
                     r_maxis_tuser  = #(P_INPUT_DELAY) 'd0;
                     r_maxis_tlast  = #(P_INPUT_DELAY) 'd0;                                        
                end
                else begin
                     r_maxis_tdata  = #(P_INPUT_DELAY) 'd0;
                     r_maxis_tvalid = #(P_INPUT_DELAY) 'd1;
                     r_maxis_tuser  = #(P_INPUT_DELAY) 'd0;
                     r_maxis_tlast  = #(P_INPUT_DELAY) 'd0;                                                            
                end                

                img_cnt = img_cnt + 'd0;

            end // ix   

            // Blanking
            @(posedge r_sysclk);
            r_maxis_tdata  = #(P_INPUT_DELAY) 'd0;
            r_maxis_tvalid = #(P_INPUT_DELAY) 'd0;
            r_maxis_tuser  = #(P_INPUT_DELAY) 'd0;
            r_maxis_tlast  = #(P_INPUT_DELAY) 'd0;
            repeat (P_BLK_CYCLE) @(posedge r_sysclk);
   
        end // iy

        // read last line
        for (ix=0; ix < P_IMG_WIDTH; ix=ix+1) begin
            while ( w_maxis_tready != 1'b1 ); // wait
            @ (posedge r_sysclk);
            r_maxis_tdata  = #(P_INPUT_DELAY) 'd0;
            r_maxis_tvalid = #(P_INPUT_DELAY) 'd1;
            r_maxis_tuser  = #(P_INPUT_DELAY) 'd0;
            r_maxis_tlast  = #(P_INPUT_DELAY) 'd0; 
        end
        @(posedge r_sysclk);
        r_maxis_tdata  = #(P_INPUT_DELAY) 'd0;
        r_maxis_tvalid = #(P_INPUT_DELAY) 'd0;
        r_maxis_tuser  = #(P_INPUT_DELAY) 'd0;
        r_maxis_tlast  = #(P_INPUT_DELAY) 'd0;
        repeat (P_BLK_CYCLE) @(posedge r_sysclk);

        $finish(2);
    end
    
    // DUT
    average_filter_3x3 # (
        .P_DAT_WIDTH(P_DAT_WIDTH),
        .P_IMG_WIDTH(P_IMG_WIDTH),
        .P_IMG_WIDTH(P_IMG_HEIGHT)
    ) filter_inst (
        .i_clk  (r_sysclk),
        .i_rstn (r_rstn),
        // axi4 stream slave
        .i_saxis_tdata  ( r_maxis_tdata ),
        .o_saxis_tready ( w_maxis_tready ),
        .i_saxis_tvalid ( r_maxis_tvalid ),
        .i_saxis_tuer   ( r_maxis_tuser ),
        .i_saxis_tlast  ( r_maxis_tlast ),
        // axi4 stream master
        .o_maxis_tdata  ( w_saxis_tdata ),
        .i_maxis_tready ( r_saxis_tready ),
        .o_maxis_tvalid ( w_saxis_tvalid ),
        .o_maxis_tuer   ( w_saxis_tuser ),
        .o_maxis_tlast  ( w_saxis_tlast )
    );

endmodule