﻿package org.ascrypt
{
	/**
	* Encodes and decodes data with base16 (hex) encoding.
	* <br/><br/>Base16 is hexadecimal representation of binary data that only uses characters A-Z, a-z, and 0-9.
	* @author Mika Palmu
	*/
	public class Base16
	{
		/**
		* Encodes bytes to a base16 string.
		* @param bytes An array of ASCII or UTF-8 bytes.
		* @return An encoded base16 string.
		*/
		public static function encode(bytes:Array):String
		{
			var l:int = bytes.length;
			var v:String, h:Array = [];
			for (var i:int = 0; i < l; i++)
			{
				v = bytes[i].toString(16);
				if (v.length < 2) h[i] = "0" + v;
				else h[i] = v;
			}
			return h.join("");
		}
		
		/**
		* Decodes base16 string to bytes.
		* @param text A base16 encoded string.
		* @return An array of decoded bytes.
		*/
		public static function decode(text:String):Array
		{
			var l:int = text.length;
			var v:String, b:Array = [];
			for (var i:int = 0; i < l; i += 2)
			{
				v = text.substr(i, 2);
				b[i / 2] = parseInt(v, 16);
			}
			return b;
		}
		
	}
	
}
