package math {
	
	// TODO: testing
	// TODO: custom errors
	public class Matrix {
		private var data:Array = [];
		
		static public function identity(width:uint):Matrix {
			var returnMe:Matrix = new Matrix(width);
			for (var i:uint = 0; i < width; i++) {
				returnMe.updateCell(i, i, 1);
			}
			return returnMe;
		}
		
		static public function perspective():Matrix {
			var returnMe:Matrix = Matrix.identity(4);
			returnMe.updateCell(3, 3, 0);
			returnMe.updateCell(3, 2, -1);
			return returnMe;
		}
		
		public function Matrix(... args) {
			if (args.length == 0) {
				populate(4, 4, 0);
			} else if (args.length == 1 && args[0] is uint) {
				populate(args[0], args[0], 0);
			} else if (args.length == 2 && args[0] is uint && args[1] is uint) {
				populate(args[0], args[1], 0);
			} else if (args.length == 3 && args[0] is uint && args[1] is uint && args[2] is Number) {
				populate(args[0], args[1], args[2]);
			} else if (args.length == 1 && args[0] is Array && isData(args[0])) {
				if(isValidData(args[0]))
					data = args[0];
				else
					invalidMatrix(args[0]);
			} else if (isData(args)) {
				if(isValidData(args))
					data = args;
				else
					invalidMatrix(args);
			} else {
				invalidMatrix(args);
			}
		}
		
		private function populate(width:uint, height:uint, value:Number):void {
			for (var i:uint = 0; i < height; i++) {
				data.push([]);
				for (var j:uint = 0; j < width; j++) {
					data[i].push(value);
				}
			}
		}
		
		private function isData(args:Array):Boolean {
			for (var i:uint = 0; i < args.length; i++) {
				if (!(args[i] is Array))
						return false;
				for (var j:uint = 0; j < args[i].length; j++)
					if (args[i][j] is Array)
						return false;
			}
			return true;
		}
		
		private function isValidData(args:Array):Boolean {
			var width:uint = args[0].length;
			for (var i:uint = 0; i < args.length; i++) {
				if (args[i].length != width)
					return false;
				for (var j:uint = 0; j < args[i].length; j++)
					if (args[i][j] === null || args[i][j] === undefined || !isNum(args[i][j]))
						return false;
			}
			return true;
		}
		
		private function isNum(arg:*):Boolean {
			return arg is Number || arg is int || arg is uint;
		}
		
		private function invalidMatrix(args:Array):void {
			throw new Error("Invalid Matrix. Arguments: " + args);
		}
		
		public function add(arg:Matrix):Matrix {
			if(!sameDimentions(arg))
				incompatableDimentions(arg);
			var newData:Matrix = new Matrix(width(), height());
			for (var i:uint = 0; i < height(); i++)
				for (var j:uint = 0; j < width(); j++)
					newData.updateCell(i, j, getCell(i, j) + arg.getCell(i, j));
			return newData;
		}
		
		public function subtract(arg:Matrix):Matrix {
			if(!sameDimentions(arg))
				incompatableDimentions(arg);
			var newData:Matrix = new Matrix(width(), height());
			for (var i:uint = 0; i < height(); i++)
				for (var j:uint = 0; j < width(); j++)
					newData.updateCell(i, j, getCell(i, j) - arg.getCell(i, j));
			return newData;
		}
		
		public function dot(arg:Matrix):Matrix {
			if(width() != arg.height())
				incompatableDimentions(arg);
			var newData:Matrix = new Matrix(arg.width(), arg.height());
			for (var i:uint = 0; i < arg.width(); i++) {
				for (var j:uint = 0; j < height(); j++) {
					var tempSum:Number = 0;
					for (var k:uint = 0; k < width(); k++) {
						tempSum += getCell(j, k) * arg.getCell(k, i);
					}
					newData.updateCell(j, i, tempSum);
				}
			}
			return newData;
		}
		
		public function multiply(arg:Matrix):Matrix {
			if(!sameDimentions(arg))
				incompatableDimentions(arg);
			var newData:Matrix = new Matrix(width(), height());
			for (var i:uint = 0; i < height(); i++)
				for (var j:uint = 0; j < width(); j++)
					newData.updateCell(i, j, getCell(i, j) * arg.getCell(i, j));
			return newData;
		}
		
		public function scale(arg:Number):Matrix {
			var newData:Matrix = new Matrix(width(), height());
			for (var i:uint = 0; i < height(); i++)
				for (var j:uint = 0; j < width(); j++)
					newData.updateCell(i, j, getCell(i, j) * arg);
			return newData;
		}
		
		public function transpose():Matrix {
			var newData:Matrix = new Matrix(height(), width());
			for (var i:uint = 0; i < height(); i++)
				for (var j:uint = 0; j < width(); j++)
					newData.updateCell(j, i, getCell(i, j));
			return newData;
		}
		
		private function sameDimentions(arg:Matrix):Boolean {
			return width() == arg.width() && height() == arg.height();
		}
		
		private function incompatableDimentions(arg:Matrix):void {
			throw new Error("Incompatable matrix dimentions. Matrix 1: " + this + "Matrix 2: " + arg);
		}
		
		public function updateCell(y:int, x:int, value:Number):void {
			data[y][x] = value;
		}
		
		public function getCell(i:int, j:int):Number {
			return data[i][j];
		}
		
		public function width():uint {
			return data[0].length;
		}
		
		public function height():uint {
			return data.length;
		}
		
		public function toString():String {
			var returnMe:String = "" + width() + " x " + height() + " Matrix\n";
			
			for (var i:uint = 0; i < height(); i++) {
				returnMe += "| ";
				for (var j:uint = 0; j < width(); j++)
					returnMe += data[i][j] + ", ";
				returnMe += " |\n";
			}
			
			return returnMe;
		}
	}
}