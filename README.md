# fifo-uvm-verification

UVM-based verification environment for a FIFO design using SystemVerilog, constrained-random stimulus, functional coverage, and assertions.

---

## Overview
This project implements a UVM-based verification environment for a FIFO design. The focus is on verifying correct data ordering and handling of edge cases such as overflow and underflow.

Both constrained-random stimulus and directed tests are used to cover typical and corner-case scenarios.

---

## Design Under Test
The FIFO supports synchronous read and write operations with the following signals:
- write enable (`wr_en`)
- read enable (`rd_en`)
- data input/output (`data_in`, `data_out`)
- status flags (`full`, `empty`)

---

## Verification Approach

The testbench is structured using standard UVM components:

- **Interface**
  - Includes a clocking block for proper synchronization
  - Contains assertions for protocol checking (e.g. no write when full)

- **Driver**
  - Drives DUT inputs based on sequence items
  - Handles reset and timing via the clocking block

- **Monitor**
  - Samples DUT signals on clock edges
  - Converts them into transactions
  - Collects functional and cross coverage

- **Sequencer**
  - Controls stimulus flow
  - Provides sequences with access to DUT signals through a virtual interface

- **Scoreboard**
  - Uses a queue-based reference model
  - Checks data integrity on read operations
  - Detects overflow and underflow conditions

- **Environment**
  - Instantiates agent and scoreboard
  - Connects monitor output to scoreboard

---

## Test Scenarios

- **Random test**
  - Constrained-random read/write stimulus

- **Overflow test**
  - FIFO is filled until full
  - Additional writes are applied to verify full-condition behavior

- **Underflow test**
  - Writes are disabled
  - Read operations are forced to verify empty-condition behavior

---

## Coverage

Functional coverage includes:
- write and read activity
- FIFO status signals (`full`, `empty`)

Cross coverage:
- write vs read
- write vs full
- read vs empty

---

## How to run

+UVM_TESTNAME=fifo_test

+UVM_TESTNAME=fifo_overflow_test

+UVM_TESTNAME=fifo_underflow_test

---

## Notes

- Clocking block is used to avoid race conditions between DUT and testbench
- Assertions are implemented in the interface for protocol validation
- Scoreboard uses a queue-based reference model to track expected data

---

## Possible improvements

- Parameterize FIFO depth
- Add reset-during-operation tests
- Extend assertion coverage
- Improve coverage closure
