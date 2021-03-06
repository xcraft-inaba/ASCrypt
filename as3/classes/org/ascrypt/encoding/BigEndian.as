﻿package org.ascrypt.encoding 
{
	/**
	* Converts bytes and text in UTF-16 BE encoding.
	* @author Mika Palmu
	*/
	public class BigEndian 
	{
		/**
		* Converts text to an array of bytes.
		* @param text An ASCII or UTF-8 encoded string.
		* @return An array of UTF-16 BE bytes.
		*/
		public static function textToBytes(text:String):Array
		{
			var b:Array = [];
			var l:int = text.length * 2;
			for (var i:int = 0; i < l; i += 2)
			{
				b[i] = text.charCodeAt(i / 2) >>> 8 & 0xFF;
				b[i + 1] = text.charCodeAt(i / 2) & 0xFF;
			}
			return b;
		}
		
		/**
		* Converts an array of bytes to text.
		* @param bytes An array of UTF-16 BE bytes.
		* @return An UTF-16 BE encoded string.
		*/
		public static function bytesToText(bytes:Array):String
		{
			var l:int = bytes.length;
			var c:int, s:String = new String("");
			for (var i:int = 0; i < l; i += 2)
			{
				c = (bytes[i] << 8) | (bytes[i + 1] & 0xFF);
				s += String.fromCharCode(c);
			}
			return s;
		}
		
	}
	
}
