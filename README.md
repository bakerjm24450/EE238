# EE228
This directory contains the tools used for EE 228 Digital Systems Design at VMI. It includes the following:
* VS Code workspace
* VS Code devcontainer that builds a Docker container
  * Container is based on an Ubuntu image with miniconda installed
  * In addition the SymbiFlow tools are installed in the container
    * yosys for synthesis
    * vtr for place and route
    * Architecture definitions for Xilinx Artix-7, specifically using the Digilent Basys3 board
  * Modifications to the pack, place, and route scripts are installed, including combining place and route in a single step
* VS code tasks to create a bit file for the Basys3
  * SystemVerilog file must be supplied, along with a PCF file, and optionally an SDC file
  * An optional, project-specific Makefile can be included to override the settings in the default Makefile
