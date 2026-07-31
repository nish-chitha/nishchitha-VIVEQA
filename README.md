# FPGA Implementation of Dijkstra's Shortest Path Algorithm

A hardware implementation of **Dijkstra's Shortest Path Algorithm** using **Verilog HDL** on a **Xilinx FPGA**. The system computes the shortest path between user-selected nodes and visualizes the result through a **Python-based interactive web application**.

---

## 📌 Project Overview

This project implements **Dijkstra's Shortest Path Algorithm** entirely in hardware using **Verilog HDL** on a **Xilinx FPGA**. The weighted graph is stored in Block RAM (BRAM), and the shortest path is computed using a dedicated Finite State Machine (FSM).

The source and destination nodes are selected using a **4×4 matrix keypad** connected to the FPGA. Once the computation is complete, the FPGA transmits the result to a **Python web application**, which displays the shortest route on an interactive map along with the total distance and computation time.

This project demonstrates the integration of **digital hardware design**, **serial communication**, and **software visualization** to create a complete hardware-accelerated pathfinding system.

---

## ✨ Features

- Hardware implementation of Dijkstra's Algorithm
- Verilog HDL based modular architecture
- Xilinx FPGA implementation
- 4×4 Matrix Keypad user input
- BRAM-based graph storage
- FSM-controlled shortest path computation
- UART communication between FPGA and host computer
- Python-based interactive web application
- Real-time route visualization
- Displays shortest path, total distance, and computation time

---

## 🛠 Hardware Platform

- Xilinx FPGA Development Board
- 4×4 Matrix Keypad
- USB-UART Interface
- Host Computer

---

## 💻 Software & Tools

- Verilog HDL
- Xilinx Vivado
- Python 3
- Flask
- PySerial
- HTML
- CSS
- JavaScript

---

## 🏗 System Architecture

```
              4×4 Matrix Keypad
                      │
                      ▼
             Keypad Sequencer
                      │
                      ▼
              Dijkstra FSM
                      │
        ┌─────────────┴─────────────┐
        ▼                           ▼
 Graph BRAM                 Distance / Visited BRAM
 (Adjacency Matrix)         & Predecessor Memory
                      │
                      ▼
              Comparator Logic
                      │
                      ▼
              Route Reporter
                      │
                      ▼
               UART Transmitter
                      │
                      ▼
             Python Web Application
                      │
                      ▼
        Interactive Route Visualization
```

---

## ⚙ Implementation Approach

The weighted graph is stored as an adjacency matrix inside FPGA Block RAM. When the user selects the source and destination nodes using the 4×4 keypad, the Dijkstra FSM initializes the graph data and begins the shortest path computation.

The FSM repeatedly selects the minimum unvisited node using comparator logic, updates the shortest distances of neighboring nodes, and stores predecessor information in BRAM. After the destination node is reached, the shortest route is reconstructed and transmitted to the host computer through UART.

A Python-based web application receives the transmitted data, processes the computed route, and displays it on an interactive map. The interface also presents the total distance and computation time, providing an intuitive visualization of the FPGA-generated output.

---

## 📂 Module Description

| Module | Description |
|---------|-------------|
| **top.v** | Top-level module integrating all project components. |
| **dijkstra_fsm.v** | Controls the execution of Dijkstra's Algorithm. |
| **bram_adj_matrix.v** | Stores the weighted graph as an adjacency matrix. |
| **bram_dist_visited.v** | Stores distance, visited, and predecessor information. |
| **comparator.v** | Finds the minimum unvisited node during each iteration. |
| **keypad_sequencer.v** | Processes keypad input and generates source and destination nodes. |
| **display_no.v** | Converts keypad input into graph node numbers. |
| **route_reporter.v** | Reconstructs the shortest route from predecessor information. |
| **uart_tx.v** | Transmits computed route data to the Python application. |
| **lcd_controller.v** | Controls LCD status messages during execution. |
| **bin2bcd.v** | Converts binary values to BCD format for display. |

---

## 🔄 Project Workflow

1. User selects the source node using the 4×4 keypad.
2. User selects the destination node.
3. The graph stored in BRAM is initialized.
4. The Dijkstra FSM computes the shortest path.
5. Distance and predecessor values are updated.
6. The final route is reconstructed.
7. The computed path is transmitted through UART.
8. The Python web application receives the route data.
9. The shortest path is displayed on an interactive map together with the total distance and computation time.

---

## 📊 Results

The proposed system was successfully implemented and validated on FPGA hardware. The hardware implementation accurately computes the shortest path for multiple source and destination combinations.

The computed route is transmitted from the FPGA to a Python-based web application, where it is visualized on an interactive map. The interface displays the complete route, total travel distance, and execution time, demonstrating seamless integration between FPGA hardware and software visualization.

---

## 🚀 Future Improvements

- Support larger road networks
- Dynamic graph loading
- GPS integration
- Live traffic updates
- Wireless communication
- Mobile application support

---

## 👨‍💻 Authors

Developed as an FPGA-based implementation of **Dijkstra's Shortest Path Algorithm** using **Verilog HDL**, integrating hardware computation with a Python-based web application for interactive route visualization.
