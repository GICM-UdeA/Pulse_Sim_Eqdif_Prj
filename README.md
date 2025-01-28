# Pulse_Sim_Eqdif_Prj
# Simulación de Pulsos en Plataformas de Hardware Reconfigurable

[![Versión](https://img.shields.io/badge/Vivado_Design_Suite-2022.2-blue)](https://www.xilinx.com/products/design-tools/vivado.html)
[![Versión](https://img.shields.io/badge/ESP_IDF-5.3.1-blue)](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/versions.html)

## Descripción

Este repositorio contiene la documentación necesaria para la reconstrucción e implementación de un sistema que usa plataformas de hardware reconfigurable basadas en FPGAs, el cuál permite el modelado y la generación de pulsos digitales basados en eventos mediante el uso de VHDL, los cuales son enviados a un sistema de conversión digital-analógico (DAC) utilizando el protocolo de comunicación UART.

El proyecto fue desarrollado principalmente con la suite Xilinx Vivado 2022.2, utilizando plataformas de desarrollo basadas en los SoC ZYNQ-7000, como las tarjetas Arty Z7 y PYNQ Z1. Sin embargo, la solución es escalable a otras implementaciones similares.

## Contenido del Repositorio

- [**hardware_design/src/**](https://github.com/GICM-UdeA/Pulse_Sim_Eqdif_Prj/tree/main/hardware_design/src): Archivos fuente en VHDL.
- [**hardware_design/bd/**](https://github.com/GICM-UdeA/Pulse_Sim_Eqdif_Prj/tree/main/hardware_design/bd): Archivo fuente .tcl que contiene el diseño de bloques de los módulos implementados en el diseño de hardware.
- **hardware_design/constraints/**: Archivo .xdc de restricciones y asignación de puertos I/O.
- **serial_rx_dac/**: Archivo fuente en C ESP-IDF (Espressif IoT Development Framework) para recepción de datos serializados y conversión DAC.

## Requisitos

Para la replicación del proyecto alojado en el repositorio se requieren las siguientes herramientas preferiblemente en sus respectivas versiones:

- [**Vivado Design Suite** Version 2022.2.](https://www.xilinx.com/products/design-tools/vivado.html)
- [**ESP-IDF** Version 5.3.1.](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/versions.html)
- **Plataforma de Desarrollo basada en SoC ZYNQ-7000** ([Arty Z7](https://digilent.com/reference/programmable-logic/arty-z7/start?srsltid=AfmBOoq5fKQ_C9_Ehuk8bZ9r4JkzufxCzzVSnbsX_8uWH6j2porYrgu8) o [PYNQ Z1](https://digilent.com/reference/programmable-logic/pynq-z1/start?srsltid=AfmBOoovGXU23vFhH0iEZgLWwIhasXWkMV4HqRLBCp5aw8TR3t5Z5Eds) fueron las usadas para este proyecto).
- **Placa de Desarrollo SoC ESP32** (Como recurso de conversión DAC utilizado en el proyecto).
- **Osciloscopio** (En este caso se utiliza el Osciloscopio USB Analog Discovery 2).

## Cómo Usar

1. **Clonar el Repositorio**:
   ```bash
   git clone https://github.com/GICM-UdeA/Pulse_Sim_Eqdif_Prj.git
   
2. **Abrir Vivado y Reconstruir el Proyecto**:
   
   ![open_vivado](https://raw.githubusercontent.com/GICM-UdeA/Pulse_Sim_Eqdif_Prj/refs/heads/main/readme_assets/open_vivado.png)
   - Abre Vivado 2022.2. y en la ventana de inicio dirijase a **`Tools > Run Tcl Script...`**
