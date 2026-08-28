`timescale 1ns/1ps

module fm_receiver_tb;

    reg clk;
    reg rst;

    reg signed [15:0] i_in;
    reg signed [15:0] q_in;

    wire signed [31:0] audio_out;

    fm_receiver uut (
        .clk(clk),
        .rst(rst),
        .i_in(i_in),
        .q_in(q_in),
        .audio_out(audio_out)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin

        $display("FM Radio Receiver Simulation");
        $display("--------------------------------------------");
        $display("Time\tI Input\tQ Input\tAudio Output");
        $display("--------------------------------------------");

        clk = 1'b0;
        rst = 1'b1;

        i_in = 16'sd0;
        q_in = 16'sd0;

        #20;
        rst = 1'b0;

        // I/Q sample 1
        i_in = 16'sd1000;
        q_in = 16'sd0;
        #10;
        $display("%0t\t%d\t%d\t%d",
                 $time, i_in, q_in, audio_out);

        // I/Q sample 2
        i_in = 16'sd980;
        q_in = 16'sd200;
        #10;
        $display("%0t\t%d\t%d\t%d",
                 $time, i_in, q_in, audio_out);

        // I/Q sample 3
        i_in = 16'sd920;
        q_in = 16'sd390;
        #10;
        $display("%0t\t%d\t%d\t%d",
                 $time, i_in, q_in, audio_out);

        // I/Q sample 4
        i_in = 16'sd830;
        q_in = 16'sd560;
        #10;
        $display("%0t\t%d\t%d\t%d",
                 $time, i_in, q_in, audio_out);

        // I/Q sample 5
        i_in = 16'sd710;
        q_in = 16'sd700;
        #10;
        $display("%0t\t%d\t%d\t%d",
                 $time, i_in, q_in, audio_out);

        // I/Q sample 6
        i_in = 16'sd560;
        q_in = 16'sd830;
        #10;
        $display("%0t\t%d\t%d\t%d",
                 $time, i_in, q_in, audio_out);

        // I/Q sample 7
        i_in = 16'sd390;
        q_in = 16'sd920;
        #10;
        $display("%0t\t%d\t%d\t%d",
                 $time, i_in, q_in, audio_out);

        // I/Q sample 8
        i_in = 16'sd200;
        q_in = 16'sd980;
        #10;
        $display("%0t\t%d\t%d\t%d",
                 $time, i_in, q_in, audio_out);

        #20;

        $display("--------------------------------------------");
        $display("FM Demodulation Complete");

        $finish;
    end

    // Generate waveform
    initial begin
        $dumpfile("fm_receiver.vcd");
        $dumpvars(0, fm_receiver_tb);
    end

endmodule
