package geom.data {
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
	}
}