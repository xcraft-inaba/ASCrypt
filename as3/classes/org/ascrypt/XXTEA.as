﻿package org.ascrypt 
{
	import org.ascrypt.utilities.*;
	
	/**
	* Encrypts and decrypts data with the XXTEA (Corrected Block TEA) algorithm.
	* <br/><br/>XXTEA is a block cipher that operates on variable-length blocks (multiple of 32 bits, minimum of 64 bits) and fixed key size of 128 bits.
	* @author Mika Palmu
	*/
	public class XXTEA
	{
		/**
		* Private error messages of the class.
		*/
		private static const ERROR_KEY:String = "Invalid key size. Key size is fixed at 128 bits.\n";
		private static const ERROR_BLOCK:String = "Invalid block size. Minimum block size is 64 bits and the block size needs to be multiple of 32 bits.\n";
		
		/**
		* Encrypts bytes with the specified key.
		* @param key An array of ASCII or UTF-8 key bytes.
		* @param bytes An array of ASCII or UTF-8 input bytes.
		* @return An array of encrypted bytes.
		*/
		public static function encrypt(key:Array, bytes:Array):Array
		{
			check(key, bytes);
			var h:Array = UTIL.pack(key);
			var v:Array = UTIL.pack(bytes);
			if (v.length <= 1) v[1] = 0; var n:int = v.length;
			var z:int = v[n - 1], y:int = v[0], d:int = 0x9E3779B9;
			var m:int, e:int, s:int = 0, q:int = Math.floor(6 + 52 / n);
			while (q-- > 0) 
			{
				s += d;
				e = s >>> 2 & 3;
				for (var i:int = 0; i < n; i++)
				{
					y = v[(i + 1) % n];
					m = (z >>> 5 ^ y << 2) + (y >>> 3 ^ z << 4) ^ (s ^ y) + (h[i & 3 ^ e] ^ z);
					z = v[i] += m;
				}
			}
			return UTIL.unpack(v);
		}
		
		/**
		* Decrypts bytes with the specified key.
		* @param key An array of ASCII or UTF-8 key bytes.
		* @param bytes An array of ASCII or UTF-8 input bytes.
		* @return An array of decrypted bytes.
		*/
		public static function decrypt(key:Array, bytes:Array):Array
		{
			check(key, bytes);
			var h:Array = UTIL.pack(key);
			var v:Array = UTIL.pack(bytes);
			var n:int = v.length, z:int = v[n - 1], y:int = v[0], d:int = 0x9E3779B9;
			var m:int, e:int, q:int = Math.floor(6 + 52 / n), s:int = q * d;
			while (s != 0) 
			{
				e = s >>> 2 & 3;
				for (var i:int = n - 1; i >= 0; i--) 
				{
					z = v[i > 0 ? i - 1 : n - 1];
					m = (z >>> 5 ^ y << 2) + (y >>> 3 ^ z << 4) ^ (s ^ y) + (h[i & 3 ^ e] ^ z);
					y = v[i] -= m;
				}
				s -= d;
			}
			return UTIL.unpack(v);
		}
		
		/**
		* Private static methods of the class.
		*/
		private static function check(k:Array, b:Array):void
		{
			if (k.length != 16) throw Error(ERROR_KEY);
			if (b.length < 8 || b.length % 4 != 0) throw Error(ERROR_BLOCK);
		}
		
	}
	
}
