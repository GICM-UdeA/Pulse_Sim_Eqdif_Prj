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
   
2. **Abrir Vivado y reconstruir el proyecto**:
   
   ![open_vivado](https://raw.githubusercontent.com/GICM-UdeA/Pulse_Sim_Eqdif_Prj/refs/heads/main/readme_assets/open_vivado.png)
   
   Abre Vivado 2022.2. y en la ventana de inicio abre la consola Tcl y ejecuta los siguientes comandos:
   
   Dirigete al directorio principal del proyecto:
   ```bash
   cd main_directory/hardware_design
   ```
   donde `main_directory` hace referencia a la ubicación del repositorio descargado en su equipo. 
   A continuación vamos a crear un nuevo proyecto mediante el comando siguiente, especificando el nombre del proyecto `project_name` y la referencia del dispositivo FPGA a utilizar en el proyecto `project_device`, Para lo cuál en este caso utilizaremos un FPGA de la familia Virtex-7  **(`-part xc7z020clg400-1`)** (PYNQ-Z1 o ARTY-Z7).
   ```bash
   create_project project_name main_directory/project_name -part project_device
   ```
   A continuación importaremos los archivos fuente **.vhd** al nuevo proyecto mediante el siguiente comando
   ```bash
   add_files -norecurse {src/eq_dif_model.vhd src/neutrino_signal.vhd src/signal_mux.vhd src/expo_transf_Z.vhd src/serial_tx.vhd src/rng_pulse_trigger.vhd}
   ```
   Cargados los archivos anteriores al Workspace creado, entonces vamos a ejecutar el .tcl script que se encargará de importar los módulos nativos utilizados en el proyecto pero que estan incluidos dentro de las librerias, además de realizar el ruteo y conexiones entre módulos del proyecto
    ```bash
   source bd/serialtx_pulses_bd.tcl
   ```
   Al finalizar la ejecución del script, se puede ver dentro del Block Design -> Diagram el proyecto replicado, sin embargo para poder se cargado en el FPGA SoC objetivo, se debe cargar el archivo de constraints para determinar los pines I/O y las asignaciones o propiedades de hardware que tendrá el diseño al programar la FPGA cpn el mismo.

   Para cargar los constraints por defecto se ejecuta en la terminal tcl el siguiente comando
   ```bash
   add_files constraints/constraints.xdc
   ```
   **NOTA:** El archivo .xdc que almacena los constraints contenido dentro del actual repositorio es especifico y solo utilizable para la plataforma xc7z020clg400-1 (PYNQ-Z1 ó ARTY-Z7), por lo cuál, una implementacion con hardware diferente al utilizado por defecto requerirá otras configuraciones adaptadas a la plataforma utilizada.

3. **Implementación y Generación del archivo bitstream .bit**
   
   realizar el proceso de generar el archivo .bit que se cargará en la plataforma de hardware (PYNQ-Z1 o ARTY-Z7) seleccionando la opción **Generate Bitstream**

   ![generate bit](https://raw.githubusercontent.com/GICM-UdeA/Pulse_Sim_Eqdif_Prj/refs/heads/main/readme_assets/generate_bit.png)

Posterior a recibir la confirmación de creación satisfactoria del archivo **.bit** se procede a programar la pltaforma seleccionando la opción **Program Device**

   ![program_device](https://raw.githubusercontent.com/GICM-UdeA/Pulse_Sim_Eqdif_Prj/refs/heads/main/readme_assets/program_device.png)

¡Listo! ya esta el proyecto cargado en la plataforma de hardware para ser testeado con el sistema de adquisición.

4. **Programar el ESP32 para recepción de los datos y generación de los triggers**

   Posterior al proceso de configuración de la plataforma FPGA es necesario programar la ESP32 mediante el uso de ESP-IDF IoT Development Framework (**Opcional**: Utilización de Visual Studio Code para su uso) con el código  
   
   
   
