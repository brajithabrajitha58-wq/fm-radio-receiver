`timescale 1ns/1ps

module fm_receiver (
    input  wire               clk,
    input  wire               rst,

    // Signed I/Q samples from an ADC or digital RF front end
    input  wire signed [15:0] i_in,
    input  wire signed [15:0] q_in,

    // Demodulated FM audio/baseband output
    output reg  signed [31:0] audio_out
);

    // Previous I/Q samples
    reg signed [15:0] i_prev;
    reg signed [15:0] q_prev;

    // Multiplication results
    reg signed [31:0] product_iq;
    reg signed [31:0] product_qi;

    // Phase-difference discriminator result
    reg signed [32:0] phase_diff;

    /*
     * FM discriminator
     *
     * For consecutive complex samples:
     *
     * audio ∝ I_prev * Q_current
     *          -
     *          Q_prev * I_current
     *
     * This is proportional to the phase/frequency
     * change between consecutive I/Q samples.
     */

    always @(posedge clk or posedge rst) begin

        if (rst) begin
            i_prev    <= 16'sd0;
            q_prev    <= 16'sd0;

            product_iq <= 32'sd0;
            product_qi <= 32'sd0;

            phase_diff <= 33'sd0;
            audio_out  <= 32'sd0;
        end

        else begin

            // Calculate complex phase difference
            product_iq <= i_prev * q_in;
            product_qi <= q_prev * i_in;

            phase_diff <= product_iq - product_qi;

            // Demodulated audio output
            audio_out <= phase_diff[31:0];

            // Save current sample for next clock
            i_prev <= i_in;
            q_prev <= q_in;

        end
    end

endmodule