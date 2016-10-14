package geom.data {
	import flash.geom.Point;
	import geom.transform.Transform;
	import math.Matrix;
	
	/** will be useful in future because UV mapping etc */
	public class Vertex {
		static public const NULL:Vertex = new Vertex(-111, -222, -333);
		
		private var transform:Transform;
		
		public function Vertex(x:Number, y:Number, z:Number, parent:Transform = null) {
			transform = new Transform(x, y, z, parent);
		}
		
		public function getPos():Matrix {
			return transform.calcPos();
		}
		
		public function toPoint():Point {
			return new Point(getPos().getCell(0, 0), getPos().getCell(1, 0));
		}
		
		public function get x():Number {
			return getPos().getCell(0, 0);
		}
		
		public function get y():Number {
			return getPos().getCell(1, 0);
		}
		
		public function get z():Number {
			return getPos().getCell(2, 0);
		}
	}
}