# FPGA Implementation of Dijkstra's Shortest Path Algorithm

A hardware implementation of **Dijkstra's Shortest Path Algorithm** using **Verilog HDL** on a **Xilinx FPGA**. The system computes the shortest path between user-selected nodes and displays the result through UART communication while also providing a Python-based graphical visualization.

---

## 📌 Project Overview

Dijkstra's algorithm is one of the most widely used graph traversal algorithms for finding the shortest path between two nodes in a weighted graph. While the algorithm is commonly implemented in software, this project demonstrates its implementation entirely in hardware using an FPGA.

The graph is stored in Block RAM (BRAM), and the algorithm is executed by a Finite State Machine (FSM) that performs node selection, distance updates, and path reconstruction. Users provide the source and destination nodes using a 4×4 matrix keypad. After computation, the shortest path is transmitted to a host computer via UART and displayed on a PuTTY terminal. A Python-based web application further visualizes the resulting route.

---

## ✨ Features

- Hardware implementation of Dijkstra's Algorithm
- Verilog HDL based modular architecture
- Xilinx FPGA implementation
- 4×4 matrix keypad input
- BRAM-based graph storage
- FSM-controlled shortest path computation
- UART communication with PuTTY
- Python-based route visualization
- Modular and reusable design

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
- PySerial
- PuTTY

---

## 🏗 System Architecture

```
                 +-----------------------+
                 |     4×4 Keypad        |
                 +-----------+-----------+
                             |
                             v
                  +----------------------+
                  | Keypad Sequencer     |
                  +-----------+----------+
                              |
                              v
                  +----------------------+
                  | Dijkstra FSM         |
                  +-----------+----------+
                              |
          +-------------------+-------------------+
          |                                       |
          v                                       v
+----------------------+            +----------------------------+
| Graph BRAM           |            | Distance / Visited BRAM    |
| (Adjacency Matrix)   |            | & Predecessor Storage      |
+----------------------+            +----------------------------+
                              |
                              v
                  +----------------------+
                  | Comparator Logic     |
                  +-----------+----------+
                              |
                              v
                  +----------------------+
                  | Route Reporter       |
                  +-----------+----------+
                              |
                              v
                    +------------------+
                    | UART Transmitter |
                    +---------+--------+
                              |
                              v
                     PuTTY Serial Terminal
                              |
                              v
                 Python Web Visualization
```

---

## ⚙ Implementation Approach

The weighted graph is stored as an adjacency matrix in Block RAM. During execution, the user selects the source and destination nodes through the 4×4 keypad. The Dijkstra FSM initializes the graph data, repeatedly selects the minimum unvisited node using comparator logic, relaxes the neighboring edges, and updates the distance and predecessor information stored in BRAM.

Once the destination node is reached, the route is reconstructed from the predecessor memory. The computed shortest path is transmitted over UART and displayed on a PuTTY terminal. A Python-based web application reads the serial output and visualizes the final route.

---

## 📂 Module Description

| Module | Description |
|---------|-------------|
| **top.v** | Top-level module integrating all hardware components. |
| **dijkstra_fsm.v** | Controls the execution of Dijkstra's algorithm. |
| **bram_adj_matrix.v** | Stores the weighted graph as an adjacency matrix. |
| **bram_dist_visited.v** | Stores distance, visited, and predecessor information. |
| **comparator.v** | Identifies the minimum unvisited node. |
| **keypad_sequencer.v** | Reads and sequences keypad inputs. |
| **display_no.v** | Converts keypad input into node numbers. |
| **route_reporter.v** | Reconstructs and formats the shortest path. |
| **uart_tx.v** | Transmits results through UART. |
| **lcd_controller.v** | Controls the LCD status display. |
| **bin2bcd.v** | Converts binary values into BCD format. |

---

## 🔄 Project Workflow

1. User selects the source node.
2. User selects the destination node.
3. The graph is initialized.
4. The FSM executes Dijkstra's Algorithm.
5. Distances and predecessor information are updated.
6. The shortest route is reconstructed.
7. Results are transmitted via UART.
8. The shortest path is displayed on PuTTY.
9. The Python application visualizes the computed route.

---

## 📊 Results

The design was successfully implemented and verified on FPGA hardware. The system correctly computes the shortest path for multiple source and destination combinations. User inputs are accepted through the keypad, the shortest route is displayed on the PuTTY terminal through UART communication, and the Python-based web application accurately visualizes the computed path.

---

## 🚀 Future Improvements

- Support larger weighted graphs
- Dynamic graph loading
- Hardware priority queue implementation
- VGA/HDMI graphical output
- Real-time navigation applications

---

## 👥 Authors

Developed as an FPGA-based implementation of **Dijkstra's Shortest Path Algorithm** using **Verilog HDL**, integrating hardware computation, UART communication, and Python-based visualization.
