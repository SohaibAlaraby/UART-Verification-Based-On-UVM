# UART-Verification-Based-On-UVM
UART (Universal Asynchronous Receiver/Transmitter) is a hardware communication protocol that is used for asynchronous serial communication. UART is commonly used for communication between microcontrollers and peripheral devices such as sensors, modems, and other microcontrollers. It is widely used because of its simplicity and effectiveness:
## How UART Works:
1- Asynchronous Communication:<br /> 
UART is asynchronous, meaning it does not use a clock signal to synchronize the transmitter and receiver. Instead, it relies on the baud rate (the speed of data transmission) to maintain proper timing.<br />

2- Components of UART:<br />
- Transmitter (TX): The component that sends data.<br />
- Receiver (RX): The component that receives data.<br />
- FIFO (Memory): The component that the data is stored in and extracted from .<br />
- Baudrate generator (RX): The component that generate the ticks to transfer and receive bits.<br />

3- Data Processing: The ALU processes binary data and performs operations as instructed by the control unit of the CPU.<br />

4- Inputs and Outputs: Typically, an ALU has two data inputs (operands) and one output. It also has control inputs to select the<br /> operation to be performed.

The ALU is a critical component for executing the instructions of a program, as it handles the necessary computations and logic decisions.
##  UVM Testbench Structure
<img src="Img/uvm_mem_model_block_diagram (1).png" width="500">

## Report summary 
<img src="Img/final_report.png" width="1000">





## Testbench Components And Objects That Registered In Factory
<img src="Img/testbench_structure.png" width="1000">
