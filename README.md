# FPGA-Digital-Clock
**Introduction**

The FPGA Digital Clock is a digital system designed and implemented on a Field-Programmable Gate Array (FPGA) to display and maintain real-time hours, minutes, and seconds. The project demonstrates how basic digital logic, counters, clock division, and display control can be combined to build a functional digital clock using hardware description language (HDL).

In this project, the high-frequency clock signal provided by the FPGA board is divided down to generate a precise 1 Hz clock signal. This 1 Hz signal is then used to increment the seconds, minutes, and hours counters. The counters are designed to follow the standard time format, with seconds and minutes ranging from 00 to 59 and hours ranging from 00 to 23.

The clock information is displayed using 7-segment displays, allowing the current time to be viewed in a human-readable format. The design can be implemented using Verilog or VHDL and synthesized onto an FPGA development board.

The main functional blocks of the project are:

- FPGA system clock
- Clock divider / frequency divider
- 1 Hz clock generation
- Seconds counter
- Minutes counter
- Hours counter
- 7-segment display driver
- Display multiplexing
- Reset control

The basic operation of the system can be represented as:

<img width="246" height="797" alt="image" src="https://github.com/user-attachments/assets/509bb430-9899-45f8-a7c0-90e2e889cac1" />

**Objective**

The primary objective of this project is to understand the implementation of a real-time digital system using FPGA-based hardware. It provides practical experience with clock management, synchronous counters, sequential logic, reset operation, and 7-segment display interfacing.

This project demonstrates how an FPGA can be used to implement a simple but complete digital system entirely through programmable hardware logic.
