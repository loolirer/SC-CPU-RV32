`default_nettype none // Comando para desabilitar declaração automática de wires
module Mod_Teste (// Clocks
                  input CLOCK_27, CLOCK_50,

				  // Chaves e Botões
				  input [3:0] KEY,
				  input [17:0] SW,

				  // Displays de 7 seg e LEDs
				  output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
				  output [8:0] LEDG,
				  output [17:0] LEDR,

				  // Serial
				  output UART_TXD,
				  input UART_RXD,
				  inout [7:0] LCD_DATA,
				  output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,

				  // GPIO
				  inout [35:0] GPIO_0, GPIO_1
				  );

	assign GPIO_1 = 36'hzzzzzzzzz;
	assign GPIO_0 = 36'hzzzzzzzzz;
	assign LCD_ON = 1'b1;
	assign LCD_BLON = 1'b1;
	wire [7:0] w_d0x0, w_d0x1, w_d0x2, w_d0x3, w_d0x4, w_d0x5,
	w_d1x0, w_d1x1, w_d1x2, w_d1x3, w_d1x4, w_d1x5;
	
	LCD_TEST _LCD (.iCLK(CLOCK_50),
				   .iRST_N(KEY[0]),
				   .d0x0(w_d0x0),.d0x1(w_d0x1),.d0x2(w_d0x2),.d0x3(w_d0x3),.d0x4(w_d0x4),.d0x5(w_d0x5),
				   .d1x0(w_d1x0),.d1x1(w_d1x1),.d1x2(w_d1x2),.d1x3(w_d1x3),.d1x4(w_d1x4),.d1x5(w_d1x5),
				   .LCD_DATA(LCD_DATA),
				   .LCD_RW(LCD_RW),
				   .LCD_EN(LCD_EN),
				   .LCD_RS(LCD_RS)
				   );
	
// ---------- Modifique abaixo --------

	// Fios de 1 bit
	wire w_ULASrcA; 
	wire w_ULASrcB; 
	wire w_Zero;
	wire w_Branch;
	wire w_MemWrite;
	wire w_ResultSrc;
	wire w_PCSrc;
	wire w_reset;
	wire w_RegWrite;
	
	// Fios de 2 e 3 bits
	wire [1:0] w_ImmSrc;
	wire [2:0] w_ULAControl; 
	
	// Fios de 32 bits
	wire [31:0] w_Wd3;
	wire [31:0] w_Imm;
	wire [31:0] w_RData;
	wire [31:0] w_RegData;
	wire [31:0] w_rd1;
	wire [31:0] w_rd2;
	wire [31:0] w_SrcA;
	wire [31:0] w_SrcB;
	wire [31:0] w_PCp4; 
	wire [31:0] w_ULAResult;
	wire [31:0] w_PC;
	wire [31:0] w_PCn;
	wire [31:0] w_ImmPC;
	wire [31:0] w_Inst;

	// Saídas de visualização de dados
	assign LEDG[0] = w_Zero;
	assign LEDG[1] = cpu_clk;  

	// Visualizando sinais de controle
	assign LEDR[0] = w_Branch;
	assign LEDR[1] = w_ResultSrc;
	assign LEDR[2] = w_MemWrite;
	assign LEDR[5:3] = w_ULAControl;
	assign LEDR[6] = w_ULASrcA;
	assign LEDR[7] = w_ULASrcB;
	assign LEDR[9:8] = w_ImmSrc;
	assign LEDR[10] = w_RegWrite;
	
	// Visualizando instruções no displays de 7 segmentos
	SEG_7 H0(.out(HEX0[0:6]),
			 .in(w_Inst[3:0])
			 );
				
	SEG_7 H1(.out(HEX1[0:6]),
			 .in(w_Inst[7:4])
			 );
				
	SEG_7 H2(.out(HEX2[0:6]),
		     .in(w_Inst[11:8])
			 );
				
	SEG_7 H3(.out(HEX3[0:6]),
			 .in(w_Inst[15:12])
			 );
				
	SEG_7 H4(.out(HEX4[0:6]),
			 .in(w_Inst[19:16])
			 );
				
	SEG_7 H5(.out(HEX5[0:6]),
		     .in(w_Inst[23:20])
			 );
				
	SEG_7 H6(.out(HEX6[0:6]),
		     .in(w_Inst[27:24])
			 );
				
	SEG_7 H7(.out(HEX7[0:6]),
		     .in(w_Inst[31:28])
			 );

	// Visualizando registros		 
	wire [31:0] w_x30;
	wire [31:0] w_x31;
	assign w_x30 = {w_d0x0, w_d0x1, w_d0x2, w_d0x3};
	assign w_x31 = {w_d1x0, w_d1x1, w_d1x2, w_d1x3};
	assign w_d0x4 = w_PC;

	// Chave para reiniciar registros e PC
	assign w_reset = KEY[2];
	
	// ------------- CLOCK -------------
	wire cpu_clk; // Clock 1 MHz

	CLK_1MHz Clock(.clk_1MHz(cpu_clk), 
				   .clk_50MHz(CLOCK_50)
				   );
						  
	// -------------- PC ---------------
	MUX2 MuxPCSrc(.out(w_PCn), 
				  .i0(w_PCp4),
				  .i1(w_ImmPC),
				  .sel(w_PCSrc)
				  );
	
	PC _PC(.PCin(w_PCn),
		   .clk(cpu_clk),        
		   .rst(w_reset),        
		   .PC(w_PC)
		   );
			  
	assign w_PCp4 = w_PC + 3'h4;
	assign w_ImmPC = w_PC + w_Imm; 
	
    // ------ Instruction Memory -------
    InstructionMemory _InstructionMemory(.A(w_PC),
										 .RD(w_Inst[31:0])
										 );
	
	// --------- Register File ---------
	RegisterFile _RegisterFile(.wd(w_Wd3),
						       .wa(w_Inst[11:7]),
						       .we(w_RegWrite),
						       .clk(cpu_clk),
						       .rst(w_reset), 
						       .ra1(w_Inst[19:15]),
						       .ra2(w_Inst[24:20]),
						       .rd1(w_rd1),
						       .rd2(w_rd2),
						       .x30(w_x30),
						       .x31(w_x31)
						       );

	// --------- Control Unit ----------				
	ControlUnit _ControlUnit(.OP(w_Inst[6:0]), 
							 .Funct7(w_Inst[31:25]), 
							 .Funct3(w_Inst[14:12]), 
							 .RegWrite(w_RegWrite), 
							 .ULASrcA(w_ULASrcA), 
							 .ULASrcB(w_ULASrcB), 
							 .ULAControl(w_ULAControl),
							 .ImmSrc(w_ImmSrc),
							 .ResultSrc(w_ResultSrc),
							 .MemWrite(w_MemWrite),
							 .Branch(w_Branch)
							 );
									  
	assign w_PCSrc = w_Branch & w_Zero;

	// -------------- ULA --------------
	MUX2 MuxULASrcA(.out(w_SrcA),
					.i0(w_rd1),
					.i1(32'b0),
					.sel(w_ULASrcA)
					);
	
	MUX2 MuxULASrcB(.out(w_SrcB),
					.i0(w_rd2),
					.i1(w_Imm),
					.sel(w_ULASrcB)
					);
							
	ULA _ULA(.SrcA(w_SrcA), 
			 .SrcB(w_SrcB), 
			 .ULAControl(w_ULAControl), 
			 .ULAResult(w_ULAResult), 
			 .Zero(w_Zero)
			 );	 	
	
	// ------ Immediate Extension ------
	ImmExt _ImmExt(.out(w_Imm),
				   .in(w_Inst),
				   .sel(w_ImmSrc)
				   );
	
    // ---------- Data Memory ----------
	DataMemory _DataMemory(.a(w_ULAResult),  
						   .wd(w_rd2),  
						   .we(w_MemWrite),        
						   .clk(cpu_clk),      
						   .rst(w_reset),     
						   .rd(w_RData) 
						   );
									
	MUX2 MuxResSrc(.out(w_Wd3), 
				   .i0(w_ULAResult),
				   .i1(w_RData),
				   .sel(w_ResultSrc));				 

endmodule