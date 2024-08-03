# UART-Verification-Based-On-UVM
UART (Universal Asynchronous Receiver/Transmitter) is a hardware communication protocol that is used for asynchronous serial communication. UART is commonly used for communication between microcontrollers and peripheral devices such as sensors, modems, and other microcontrollers. It is widely used because of its simplicity and effectiveness:
## How UART Works:
1- Asynchronous Communication:<br /> 
- UART is asynchronous, meaning it does not use a clock signal to synchronize the transmitter and receiver. Instead, it relies on the baud rate (the speed of data transmission) to maintain proper timing.<br />

2- Components of UART:<br />
- Transmitter (TX): The component that sends data.<br />
- Receiver (RX): The component that receives data.<br />
- FIFO (Memory): The component that the data is stored in and extracted from .<br />
- Baudrate generator (RX): The component that generate the ticks to transfer and receive bits.<br />

3- Data Format:<br />

- Data is typically sent in packets that include a start bit, data bits, optional parity bit, and stop bits.<br />
- Start Bit: Indicates the beginning of a data packet (usually set to 0).<br />
- Data Bits: The actual data being transmitted (commonly 7 or 8 bits).<br />
- Parity Bit (optional): Used for error checking (can be even or odd).<br />
- Stop Bits: Indicates the end of a data packet (can be 1, 1.5, or 2 bits, usually set to 1).<br />

4- Transmission Process:<br />

- Idle State: The line is in a high state (logic 1).<br />
- Start Bit: When the transmitter wants to send data, it pulls the line low (logic 0) to indicate the start bit.<br />
- Data Bits: The data bits are transmitted sequentially, starting with the least significant bit (LSB) to the most significant bit (MSB).<br />
- Parity Bit: If parity is used, the parity bit is sent after the data bits.<br />
- Stop Bit: The transmitter sets the line high (logic 1) to indicate the end of the data packet.<br />

5- Reception Process:

- The receiver continuously monitors the line for the start bit.<br />
- Once the start bit is detected, the receiver samples the data bits, parity bit (if used), and stop bits at the baud rate.<br />
- The received data is then processed and made available to the system.<br />
- The ALU is a critical component for executing the instructions of a program, as it handles the necessary computations and logic decisions.<br />

## Key Features of UART:<br />
- Simple Protocol: UART is simple and does not require complex hardware.<br />
- Error Checking: Basic error checking is provided through parity bits.<br />
- Flexible Baud Rates: Baud rates can be easily configured to match the communication needs.<br />
- Point-to-Point Communication: UART is typically used for direct communication between two devices.<br />
- Full-Duplex Communication: UART can transmit and receive data simultaneously using separate lines for TX and RX.<br />

## Applications of UART:
- Microcontroller Communication: Used to connect microcontrollers to sensors, modules, and other microcontrollers.
- Serial Ports: Commonly found in computers for serial communication.
- Modems: Used in modems for data communication over telephone lines.
- Embedded Systems: Widely used in embedded systems for serial communication.
  
##  UVM Testbench
### UVM Testbench Structure
<img src="Img/UVM.png" width="500">
### UVM Testbench Topology and Factory registrations
<img src="Img/Testbench_Topology_And_Factory_registration.png" width="500">

## Report summary 
<img src="Img/final_report.png" width="1000">





## Testbench Components And Objects That Registered In Factory
<img src="Img/testbench_structure.png" width="1000">
