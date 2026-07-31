# FPGA-Based Hardware Dijkstra's Pathfinding Engine

## 📖 1. Project Overview

The **FPGA-Based Hardware Dijkstra's Pathfinding Engine** is an interactive, fully digital hardware accelerator that computes the shortest path between 16 interconnected geographical nodes (representing real-world towns in coastal Karnataka, India) using Dijkstra's algorithm. 

Unlike software implementations that evaluate nodes sequentially, this engine uses a parallel hardware comparator tree to compute minimum distances in $O(\log_2 N)$ cycles, dramatically reducing latency[cite: 3]. The system features:
* **Direct Hardware User Interface:** Uses a 16-bit one-hot keypad array for selecting source and target nodes, complete with hardware debouncing and multi-press detection.
* **Interactive LCD Display:** An on-chip controller drives a 16x2 HD44780 character LCD to report real-time system status and user prompts.
* **Automated Route Tracing & Reporting:** Automatically unwinds the shortest path using a back-pointer array, converts town IDs to ASCII strings, and streams the full route alongside the total calculated metric distance (in km) over a parameterized UART serial connection.

---

## 🏛️ 2. Design and Architecture

### System Architecture
The design is structured as a decoupled control-data-path system. Top-level integration manages the flow of data between the user input sequencer, the core algorithmic solver (FSM + Comparator Tree), and external display/serial reporting peripherals.

```mermaid
flowchart LR
    %% --- Custom Styling & Node Shapes ---
    classDef io fill:#f9f,stroke:#333,stroke-width:1px
    classDef mem fill:#e1f5fe,stroke:#0288d1,stroke-width:2px
    classDef ctrl fill:#fff3e0,stroke:#f57c00,stroke-width:2px

    %% --- Input Section ---
    subgraph INPUT [" User Input & Sequencing "]
        A(["16-Bit Keypad Array"]):::io
        B["keypad_sequencer<br/>(Debounce & Decode)"]
    end

    %% --- Processing Engine ---
    subgraph ENGINE [" Dijkstra's Core Processing Engine "]
        C["dijkstra_fsm<br/>(Algorithm Controller)"]:::ctrl
        F["comparator_tree<br/>(Parallel Min-Finder)"]
        
        subgraph MEM [" On-Chip Block Memory "]
            E[("bram_adj_matrix<br/>16x16 Road Network")]:::mem
            G[("bram_dist_visited<br/>Node State Memory")]:::mem
        end
    end

    %% --- Output Section ---
    subgraph OUTPUT [" Display & Serial Reporting "]
        D["lcd_controller<br/>(16x2 Display Driver)"]
        H["route_reporter<br/>(Path Unwinder + Formatter)"]
        I["uart_tx<br/>(Serial Transmitter)"]
        J(["PC Serial Monitor"]):::io
    end

    %% --- Connections ---
    A -->|"Raw Input"| B
    B -->|"src_node / tgt_node"| C
    B -->|"State / Status"| D
    
    C <-->|"Edge Weights"| E
    C <-->|"Update Dist / Prev"| G
    C -->|"Start / Latch"| F
    F <-->|"Read dist_flat"| G
    
    G -->|"prev[] / dist"| H
    H -->|"8-bit ASCII Stream"| I
    I -->|"TX Pin"| J
```
