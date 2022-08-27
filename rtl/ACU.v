/*#########################################################################
//# Alu Control Unit 
//#########################################################################
//#
//# Copyright (C) 2021 Jose Maria Jaramillo Hoyos
//# 
//# This program is free software: you can redistribute it and/or modify
//# it under the terms of the GNU General Public License as published by
//# the Free Software Foundation, either version 3 of the License, or
//# (at your option) any later version.
//#
//# This program is distributed in the hope that it will be useful,
//# but WITHOUT ANY WARRANTY; without even the implied warranty of
//# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//# GNU General Public License for more details.
//#
//# You should have received a copy of the GNU General Public License
//# along with this program.  If not, see <https://www.gnu.org/licenses/>.
//#
//########################################################################*/

module ACU(

//// inputs ////

ACU_AluOP_InBUS,
ACU_Funt3_InBUS,
ACU_Funt7_InBUS, /*bit 5 of the funct7 field*/
ACU_Opcode_InBUS, /*bit 5 of the opcode field*/

//// outputs ///
ACU_AluControl_OutBUS

);

//============================================================
//  PORT DECLARATIONS
//============================================================

input [1:0] ACU_AluOP_InBUS;
input [2:0] ACU_Funt3_InBUS;
input [6:0] ACU_Funt7_InBUS;
input [6:0] ACU_Opcode_InBUS;
output reg [3:0] ACU_AluControl_OutBUS;



//============================================================
//  PARAMETER DECLARATIONS
//============================================================

/*Operation Based in Funct3 field*/
localparam ADD_SUB = 3'b000,
			  SLT     = 3'b010, // set less than
			  SLTU    = 3'b011, // set less than unsigned
           XOR     = 3'b100,
			  OR      = 3'b110,
			  AND     = 3'b111,  
			  SLL     = 3'b001, // shift left logical  
			  SRL_SRA = 3'b101; // shift right logical /  shift right arithmetic

			  
/******** Student code here ********/

/*You must complete with the funct3 field
of the new multiplication instruction*/





				
/******** End of student code ********/
			  
			 
/*Alu operation control signals*/
localparam ALU_ADD   = 4'b0000,
			  ALU_SUB   = 4'b0001,
			  ALU_SLL   = 4'b0010,
			  ALU_SLT   = 4'b0011,
			  ALU_SLTU  = 4'b0100, /*set less than*/
			  ALU_XOR   = 4'b0101,
			  ALU_SRL   = 4'b0110,
			  ALU_SRA   = 4'b0111,
			  ALU_OR    = 4'b1000,
			  ALU_AND   = 4'b1001,
			  ALU_BUFFB = 4'b1010,
			  ALU_BUFFA = 4'b1011;
			  
			  
/******** Student code here ********/

/* You must complete with the Alu Opcode 
for the new multiplication instruction.

HINT: this is the same value used 
in the file ALU.V */

			  
			  


/******** End of student code ********/
			  
			  
				
			
//=======================================================
//  REG/WIRE declarations
//=======================================================

reg [3:0] Funct3_Operation;
wire Sub_Op;
wire Sra_Op;
wire Mult_Op_Ext;

//============================================================
//  PARAMETER DECLARATIONS
//============================================================



always@(Mult_Op_Ext,ACU_Funt3_InBUS,Sub_Op,Sra_Op)
begin

	if(Mult_Op_Ext== 1'b1) // if it is a multplication instruction 
	begin
	
		/******** Student code here ********/
		
		/*You must set the value of the Funct3_Operation
	   register according to the multiplication instruction*/
		
		/*
		HINT:
	
			case(ACU_Funt3_InBUS)
			
				value0: ...
				...
				default: ...
		
			endcase
		*/
		
		/******** End of student code ********/
		
	end
	
	else // instruction is R-TYPE or  ADDI,SLTI,SLTIU,XORI,ORI,ANDI,SLLI,SRLI,SRAI
	begin
	
		case(ACU_Funt3_InBUS)
	
			ADD_SUB: if (Sub_Op) 
							Funct3_Operation= ALU_SUB;
						else 
							Funct3_Operation= ALU_ADD;
						
			SLT: Funct3_Operation=ALU_SLT;
		
			SLTU: Funct3_Operation=ALU_SLTU;
		
			XOR: Funct3_Operation = ALU_XOR;
		
			OR: Funct3_Operation = ALU_OR;
		
			AND: Funct3_Operation = ALU_AND;
		
			SLL: Funct3_Operation = ALU_SLL;
		
			SRL_SRA: if(Sra_Op)
							Funct3_Operation= ALU_SRA;
						else
							Funct3_Operation=ALU_SRL;	
		
			default: Funct3_Operation=4'bxxxx;
			
		endcase
	end
	

end 


always@(ACU_AluOP_InBUS,Funct3_Operation)
begin
	
	casex(ACU_AluOP_InBUS)
		
		2'b00: ACU_AluControl_OutBUS=Funct3_Operation;
		
		2'b01: ACU_AluControl_OutBUS = ALU_ADD;  /*Load/Store/ operations */
		
		2'b10: ACU_AluControl_OutBUS = ALU_BUFFA; /*Lui operation*/
		
		2'b11: ACU_AluControl_OutBUS = ALU_BUFFB; /*Jalr operation*/
		
		default: ACU_AluControl_OutBUS=ALU_ADD;
	
	endcase
	
end


assign Sub_Op = ACU_Opcode_InBUS[5]&ACU_Funt7_InBUS[5];
assign Sra_Op = ACU_Funt7_InBUS[5];
assign Mult_Op_Ext = (~ACU_Opcode_InBUS[6])&(ACU_Opcode_InBUS[5])&(ACU_Opcode_InBUS[4])&(~ACU_Opcode_InBUS[3])&(~ACU_Opcode_InBUS[2])&(ACU_Opcode_InBUS[1])&(ACU_Opcode_InBUS[0])&(ACU_Funt7_InBUS[0]);


endmodule
