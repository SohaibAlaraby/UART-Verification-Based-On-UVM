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
- Microcontroller Communication: Used to connect microcontrollers to sensors, modules, and other microcontrollers.<br />
- Serial Ports: Commonly found in computers for serial communication.<br />
- Modems: Used in modems for data communication over telephone lines.<br />
- Embedded Systems: Widely used in embedded systems for serial communication.<br />
  
##  UVM Testbench
### UVM Testbench Structure<br />
<img src="Img/UVM.png" width="500"><br />
### UVM Testbench Topology & Factory Registrations<br />
<img src="Img/Testbench_Topology_And_Factory_registration.png" width="500"><br />

### Data Transmitting and receiving<br />
- w_data signal is the write data at the TX and the r_data signal is the read data at the RX.<br />
<img src="Img/waveform.png" width="1000"><br />

## FSM Of TX and RX & FIFO Behavior<br />
- TX/n_reg is the current state of the TX and RX/n_reg is the same for RX and FSM starts when start bit 0 arrives.<br />
- States are {start , Data Transfer/Receiving , Parity , End}.<br />
- Also FIFO_RX is the fifo of the RX and the w_data is the data that received by the RX (when the receiver receives a bit the shift register will add it).<br />
- in FIFO_RX/r_data is the read data in FIFO and it will extract the data from the fifo when a read signal arrives.<br />
<img src="Img/FSM_And_FIFO.png" width="1000"><br />

## Data Flow<br />
- rx_data_out signal also represents a shift register to the received data (look how the data flow in the register).<br />

<img src="Img/Dataflow.png" width="1000"><br />

