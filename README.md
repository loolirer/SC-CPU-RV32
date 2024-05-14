# Processador Ciclo Único RISC-V 32 Bits 💻

Repositório dedicado ao trabalho final da matéria de Laboratório de Arquitetura de Sistemas Digitais do curso de Engenharia Elétrica da UFCG.

O projeto envolve melhorar o processador ciclo único desenvolvido no laboratório com o auxílio da placa *FPGA Altera DE2* e o sintetizador *Quartus II*.

O processador atual possui as seguintes especificações:

- Intruções de 32 Bits;
- Registros de 32 Bits;
- 8 KiB de SRAM;
- Clock de 1 MHz.

e comporta as seguintes instruções:

- Tipo R - `ADD`, `SUB`, `AND`, `OR`, `XOR`, `SLT`, `SLL`, `SRL`;
- Tipo I - `ADDI`, `ANDI`, `ORI`, `XORI`, `SLTI`, `SLLI`, `SRLI`, `LW`;
- Tipo S - `SW`;
- Tipo B - `BEQ`;
- Tipo U - `LUI`.

Como aplicação prática, o projeto dispõe de um código que simula um **Controlador PID Digital** Implementado em RISC-V.


A organização do projeto se encontra da seguinte maneira: 

    ├── /code/ # Códigos
    |   |
    |   ├── /VHDL/ Projeto de Descrição de Hardware da CPU em Verilog  
    |   |
    |   └── /RV32/ Projeto prático em RISC-V e teste de instruções
    |
    └── /docs/ # Requerimentos do projeto 

A disciplina foi ministrada pelos professores Rafael B. C. Lima e Gutemberg Gonçalves dos Santos Júnior em 2024.

---


