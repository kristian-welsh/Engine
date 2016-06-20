package geom {
	import math.Matrix;
	
	public class Transform {
		private var pos:Matrix;
		
		public function Transform(x:Number = 0, y:Number = 0, z:Number = 0) {
			pos = new Matrix(1, 4);
			pos.updateCell(3, 0, 1);
			translate(x, y, z);
		}
		
		public function scale(x:Number, y:Number, z:Number):void {
			pos = new Matrix([
				[x, 0, 0, 0],
				[0, y, 0, 0],
				[0, 0, z, 0],
				[0, 0, 0, 1]
			]).dot(pos);
		}
		
		public function translate(x:Number, y:Number, z:Number):void {
			pos = new Matrix([
				[1, 0, 0, x],
				[0, 1, 0, y],
				[0, 0, 1, z],
				[0, 0, 0, 1]
			]).dot(pos, true);
		}
		
		public function rotate(x:Number, y:Number, z:Number):void {
			pos =
				new Matrix([
					[1, 0          ,  0          , 0],
					[0, Math.cos(x), -Math.sin(x), 0],
					[0, Math.sin(x),  Math.cos(x), 0],
					[0, 0          ,  0          , 1]]).dot(
				new Matrix([
					[ Math.cos(y), 0, Math.sin(y), 0],
					[ 0          , 1, 0          , 0],
					[-Math.sin(y), 0, Math.cos(y), 0],
					[ 0          , 0, 0          , 1]])).dot(
				new Matrix([
					[Math.cos(z), -Math.sin(z), 0, 0],
					[Math.sin(z),  Math.cos(z), 0, 0],
					[0          ,  0          , 1, 0],
					[0          ,  0          , 0, 1]])).dot(pos);
		}
		
		public function getX():Number {
			return pos.getCell(0, 0);
		}
		
		public function getY():Number {
			return pos.getCell(1, 0);
		}
		
		public function getZ():Number {
			return pos.getCell(2, 0);
		}
	}
}