package geom.math {
	import geom.transform.Transform;
	public class Vertex {
		static public const NULL:Vertex = new Vertex( -111, -222, -333);
		public var transform:Transform;
		
		public function Vertex(x:Number, y:Number, z:Number, parent:Transform = null) {
			transform = new Transform(x, y, z, parent);
		}
		
		public function getX():Number {
			return transform.getX();
		}
		
		public function getY():Number {
			return transform.getY();
		}
		
		public function getZ():Number {
			return transform.getZ();
		}
		
		public function clone():Vertex {
			return new Vertex(getX(), getY(), getZ());
		}
	}
}