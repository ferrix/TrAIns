/*
 * trAIns - An AI for OpenTTD
 * Copyright (C) 2009  Luis Henrique O. Rios
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/


class Math {
	static function Log(a, b){
		return log(a)/log(b);
	}
	static function Log2(a){
		return Math.Log(a, 2);
	}
	static function Pow(x, y){
		local pow = 1;
		for(local i = 0 ; i < x ; i++){
			pow *= y;
		}
		return pow;
	}
	static function Pow2(x){
		return Math.Pow(x, 2);
	}
	static function Min(a, b){
		return a > b ? b : a;
	}
}
