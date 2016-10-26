/**
 * Created by aimozg on 18.01.14.
 */
package classes.internals
{
	import classes.*;
	public class Utils extends Object
	{
		private static const NUMBER_WORDS_NORMAL:Array		= ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"];
		private static const NUMBER_WORDS_CAPITAL:Array		= ["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"];
		private static const NUMBER_WORDS_POSITIONAL:Array	= ["zeroth", "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth"];

		public function Utils()
		{
		}
		
		// curryFunction(f,args1)(args2)=f(args1.concat(args2))
		// e.g. curryFunction(f,x,y)(z,w) = f(x,y,z,w)
		public static function curry(func:Function,...args):Function
		{
			if (func == null) CoC_Settings.error("carryFunction(null,"+args+")");
			return function (...args2):*{
				return func.apply(null,args.concat(args2));
			};
		}
		
		public static function formatStringArray(stringList:Array):String { //Changes an array of values into "1", "1 and 2" or "1, (x, )y and z"
			switch (stringList.length) {
				case  0: return "";
				case  1: return stringList[0];
				case  2: return stringList[0] + " and " + stringList[1];
				default:
			}
			var concat:String = stringList[0];
			for (var x:int = 1; x < stringList.length - 1; x++) concat += ", " + stringList[x];
			return concat + " and " + stringList[stringList.length - 1];
		}
		
		public static function num2Text(number:int):String {
			if (number >= 0 && number <= 10) return NUMBER_WORDS_NORMAL[number];
			return number.toString();
		}
		
		public static function num2Text2(number:int):String {
			if (number < 0) return number.toString(); //Can't really have the -10th of something
			if (number <= 10) return NUMBER_WORDS_POSITIONAL[number];
			switch (number % 10) {
				case 1: return number.toString() + "st";
				case 2: return number.toString() + "nd";
				case 3: return number.toString() + "rd";
				default:
			}
			return number.toString() + "th";
		}
		
		public static function Num2Text(number:int):String {
			if (number >= 0 && number <= 10) return NUMBER_WORDS_CAPITAL[number];
			return number.toString();
		}
		
		// Basically, you pass an arbitrary-length list of arguments, and it returns one of them at random.
		// Accepts any type.
		// Can also accept a *single* array of items, in which case it picks from the array instead.
		// This lets you pre-construct the argument, to make things cleaner
		public static function randomChoice(...args):*
		{
			var choice:Number;
			if ((args.length == 1) && (args[0] is Array))
			{
				choice = int(Math.round(Math.random() * (args[0].length - 1)));
				return args[0][choice];
			}
			else
			{
				choice = int(Math.round(Math.random() * (args.length - 1)));
				return args[choice];
			}
		}
		
		public static function rand(max:Number):Number
		{
			return int(Math.random() * max);
		}
		
		public static function validateNonNegativeNumberFields(o:Object, func:String, nnf:Array):String
		{
			var error:String = "";
			for each (var field:String in nnf) {
				if (!o.hasOwnProperty(field) || !(o[field] is Number) && o[field] != null) error += "Misspelling in "+func+".nnf: '"+field+"'. ";
				else if (o[field] == null) error += "Null '"+field+"'. ";
				else if (o[field] < 0) error += "Negative '"+field+"'. ";
			}
			return error;
		}
		
		public static function validateNonEmptyStringFields(o:Object, func:String, nef:Array):String
		{
			var error:String = "";
			for each (var field:String in nef) {
				if (!o.hasOwnProperty(field) || !(o[field] is String) && o[field] != null) error += "Misspelling in "+func+".nef: '"+field+"'. ";
				else if (o[field] == null) error += "Null '"+field+"'. ";
				else if (o[field] == "") error += "Empty '"+field+"'. ";
			}
			return error;
		}
		
		/* None of these functions are called anymore
		// lazy(obj,arg1,...,argN)() = obj[arg1]...[argN]
		public static function lazyIndex(obj:*,...args):Function{
			return function():*{
				while(args.length>0)
					obj=obj[args.shift()];
				return obj;
			};
		}
		// lazy2(func,arg1,...,argN)() = func()[arg1]...[argN]
		public static function lazyCallIndex(func:Function,...args):Function{
			var _args:Array = args.slice();
			return function():*{
				var obj:*=func();
				var __args:Array = _args.slice();
				while(__args.length>0)
					obj=obj[__args.shift()];
				return obj
			};
		}
		// lazy2(func,arg1,...,argN)(args2) = func()[arg1]...[argN](args2)
		public static function lazyCallIndexCall(func:Function,...args):Function{
			var _args:Array = args.slice();
			return function (...fargs):*{
				var obj:*=func();
				var __args:Array = _args.slice();
				while(__args.length>0)
					obj=obj[__args.shift()];
				return obj.apply(null,fargs);
			};
		}
		*/
	}
}
