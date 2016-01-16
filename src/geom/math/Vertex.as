package geom.math {
	public class Vertex {
		static public const NULL:Vertex = new Vertex( -111, -222, -333);
		
		private var x:Number = 0;
		private var y:Number = 0;
		private var z:Number = 0;
		
		public function Vertex(x:Number = 0, y:Number = 0, z:Number = 0) {
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function getX():Number {
			return x;
		}
		
		public function getY():Number {
			return y;
		}
		
		public function getZ():Number {
			return z;
		}
		
		public function clone():Vertex {
			return new Vertex(x, y, z);
		}
		
		public function round():void {
			x = ExtraMath.round(x, 0.0000001);
			y = ExtraMath.round(y, 0.0000001);
			y = ExtraMath.round(y, 0.0000001);
		}
	}
}