
module sigmoid(

    input [31:0] in,
    input aclk,
    output [31:0] out
    );
    
    wire [31:0] out1;
    wire [31:0] out2;    
    wire [31:0] out;
    wire dummy_out_0;
    wire dummy_out_1;
    wire dummy_out_2;
    wire dummy_out_3;
    wire dummy_out_4;
    wire dummy_out_5;
    wire dummy_out_6;
    wire dummy_out_7;

    floating_point_0 exponential (
        .aclk(aclk),                                  // input wire aclk
        .s_axis_a_tvalid(1'b1),                       // input wire s_axis_a_tvalid
        .s_axis_a_tready(dummy_out_0),                // output wire s_axis_a_tready
        .s_axis_a_tdata(in),                          // input wire [31 : 0] s_axis_a_tdata
        .m_axis_result_tvalid(dummy_out_1),           // output wire m_axis_result_tvalid
        .m_axis_result_tready(1'b1),                  // input wire m_axis_result_tready
        .m_axis_result_tdata(out1)                    // output wire [31 : 0] m_axis_result_tdata
    );

    floating_point_1 add (
        .aclk(aclk),                                  // input wire aclk
        .s_axis_a_tvalid(1'b1),                       // input wire s_axis_a_tvalid
        .s_axis_a_tready(dummy_out_2),                // output wire s_axis_a_tready
        .s_axis_a_tdata(out1),                        // input wire [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(1'b1),                       // input wire s_axis_b_tvalid
        .s_axis_b_tready(dummy_out_3),                // output wire s_axis_b_tready
        .s_axis_b_tdata(32'd1),                       // input wire [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(dummy_out_4),           // output wire m_axis_result_tvalid
        .m_axis_result_tready(1'b1),                  // input wire m_axis_result_tready
        .m_axis_result_tdata(out2)                    // output wire [31 : 0] m_axis_result_tdata
    );

    floating_point_2 divide (
        .aclk(aclk),                                  // input wire aclk
        .s_axis_a_tvalid(1'b1),                       // input wire s_axis_a_tvalid
        .s_axis_a_tready(dummy_out_5),                // output wire s_axis_a_tready
        .s_axis_a_tdata(32'd1),                       // input wire [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(1'b1),                       // input wire s_axis_b_tvalid
        .s_axis_b_tready(dummy_out_6),                // output wire s_axis_b_tready
        .s_axis_b_tdata(out2),                        // input wire [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(dummy_out_7),           // output wire m_axis_result_tvalid
        .m_axis_result_tready(1'b1),                  // input wire m_axis_result_tready
        .m_axis_result_tdata(in)                      // output wire [31 : 0] m_axis_result_tdata
    );

endmodule
