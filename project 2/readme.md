Here is a GitHub-ready README.md for the FM Radio Receiver Verilog project.

Writing
FM Radio Receiver Using Verilog
Overview

This project implements a basic digital FM radio receiver/demodulator using Verilog HDL.

The design accepts digital I/Q (In-phase and Quadrature) samples from an FM receiver front end and uses a phase-difference discriminator to recover the modulating audio signal.

Note: This project is a digital FM demodulator for simulation/FPGA learning. It does not directly interface an antenna or tune the 88–108 MHz FM broadcast band. A real receiver requires an RF tuner/front end and ADC.

Features
Verilog HDL implementation
I/Q digital input
FM phase-difference demodulation
Signed 16-bit I/Q samples
Signed 32-bit audio output
Synthesizable RTL structure
Verilog simulation testbench
VCD waveform generation
Suitable for FPGA/HDL learning
Project Structure
fm-radio-receiver-verilog/
│
├── rtl/
│   └── fm_receiver.v
│
├── tb/
│   └── fm_receiver_tb.v
│
├── simulation/
│   └── expected_output.txt
│
└── README.md

Block Diagram
       FM RF Signal
             │
             ▼
     ┌─────────────────┐
     │   RF Tuner /    │
     │   Down Converter│
     └────────┬────────┘
              │
              ▼
           ADC / I-Q
              │
       ┌──────┴──────┐
       │             │
       ▼             ▼
    I Samples     Q Samples
       │             │
       └──────┬──────┘
              │
              ▼
     ┌─────────────────┐
     │  FM Discriminator│
     │    (Verilog)     │
     └────────┬────────┘
              │
              ▼
        Demodulated
        Audio Output

Working Principle

An FM signal contains information in the instantaneous phase/frequency variation of the carrier.

For complex I/Q samples, a simple FM discriminator can estimate the phase change between consecutive samples using:

phase difference ∝
I_previous × Q_current
-
Q_previous × I_current


The resulting value is proportional to the instantaneous frequency deviation and therefore represents the recovered FM audio/baseband signal.

The Verilog implementation stores the previous I/Q samples and calculates the discriminator output for each new sample.

Module Interface
fm_receiver
Signal	Width	Direction	Description
clk	1	Input	System clock
rst	1	Input	Active-high reset
i_in	16	Input	Signed I sample
q_in	16	Input	Signed Q sample
audio_out	32	Output	Demodulated audio
Main RTL File

The main Verilog module is:

rtl/fm_receiver.v


Module declaration:

module fm_receiver (
    input  wire               clk,
    input  wire               rst,
    input  wire signed [15:0] i_in,
    input  wire signed [15:0] q_in,
    output reg  signed [31:0] audio_out
);

Testbench

The simulation testbench is:

tb/fm_receiver_tb.v


The testbench generates a sequence of I/Q samples and observes the resulting demodulated audio output.

Sample Simulation Output

Example console output:

FM Radio Receiver Simulation
--------------------------------------------
Time    I Input    Q Input    Audio Output
--------------------------------------------
30        1000        0           0
40         980      200           0
50         920      390      200000
60         830      560      200000
70         710      700      200000
80         560      830      200000
90         390      920      200000
100        200      980      200000
--------------------------------------------
FM Demodulation Complete


The exact values can vary according to the input sample sequence and RTL pipeline timing.

Simulation
Using Icarus Verilog

Compile the design:

iverilog -o fm_receiver_sim rtl/fm_receiver.v tb/fm_receiver_tb.v


Run the simulation:

vvp fm_receiver_sim


The testbench generates:

fm_receiver.vcd


View the waveform with GTKWave:

gtkwave fm_receiver.vcd

Waveform Signals

The waveform contains:

clk
rst
i_in
q_in
audio_out


The I/Q inputs represent the complex baseband signal. Changes in their phase relationship produce corresponding changes in the audio_out signal.

Hardware Implementation

For a practical FPGA FM receiver, the complete system could be:

FM Antenna
    │
    ▼
RF Tuner
    │
    ▼
IF / Baseband
    │
    ▼
ADC
    │
    ▼
I/Q Samples
    │
    ▼
FPGA
    │
    ├── FM Demodulator
    │
    ├── Low-Pass Filter
    │
    ├── Audio Processing
    │
    └── Volume Control
    │
    ▼
DAC / PWM
    │
    ▼
Audio Amplifier
    │
    ▼
Speaker

Limitations

This implementation is intentionally simplified for educational purposes.

It does not include:

RF tuner
Antenna interface
ADC driver
Digital down-converter
Automatic frequency control
Stereo pilot decoding
19 kHz pilot extraction
38 kHz stereo subcarrier decoding
57 kHz RDS decoding
Audio low-pass filtering
DAC/audio amplifier interface

These blocks can be added to create a more complete FPGA-based FM receiver.

Future Improvements

Possible improvements include:

Add a digital low-pass audio filter.
Add an FPGA ADC interface.
Add frequency tuning/control.
Add stereo FM decoding.
Add volume control.
Add PWM or I2S audio output.
Add an LCD/OLED frequency display.
Add RDS decoding.
Implement the design on a development board.
Applications

This project can be used for:

FPGA FM radio projects
Digital signal processing demonstrations
Verilog HDL learning
I/Q signal processing
FM demodulation experiments
Communication-system laboratory projects
FPGA-based SDR experimentation
Tools

The project can be simulated using:

Icarus Verilog
GTKWave

It can also be adapted for FPGA development tools such as:

Xilinx Vivado
Intel Quartus Prime
Lattice Radiant
License

This project is provided for educational and experimental purposes.