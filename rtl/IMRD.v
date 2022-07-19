/*#########################################################################
//# Instruction memory read signal generator for single cycle core
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

module IMRD (

input IMRD_clk,
input IMRD_reset_in,
output reg IMRD_read

);


always@(posedge IMRD_clk or negedge IMRD_reset_in)
begin
	
	if(!IMRD_reset_in)
		IMRD_read=1'b0;
	else
		IMRD_read=1'b1;
end


endmodule
