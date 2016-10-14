package geom.projector {
	import flash.geom.Point;
	import geom.data.Vertex;
	import math.Matrix;
	
	public class Projector {
		private var projection:Matrix
		private var dimentions:Matrix
		
		public function Projector(projection:Matrix = null) {
			this.projection = projection || Matrix.identity(4);
			this.dimentions = new Matrix(
				[Settings.WIDTH],
				[Settings.WIDTH],//using height here makes cubes rectangles, i think i misundersnd this.
				[1],
				[1]);
		}
		
		public function cast(input:Vertex):Point {
			var pos:Matrix = dimentions.multiply(projection.dot(input.getPos()));
			return new Point(getX(pos), getY(pos));
		}
		
		private function getX(pos:Matrix):Number {
			return pos.getCell(0, 0) / pos.getCell(3, 0);
		}
		
		private function getY(pos:Matrix):Number {
			return pos.getCell(1, 0) / pos.getCell(3, 0);
		}
	}
}