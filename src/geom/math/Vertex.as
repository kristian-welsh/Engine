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
		
		public function toCartesian():PolarVertex {
			// use pithagorean axial diagonal length calculation to get length from origin.
			// radial length to point on sphere
			var r:Number = Math.sqrt(x * x + y * y + z * z);
			
			// find angle to take to 2nd dimention
			var azimuth:Number = Math.atan(y / x);
			// find angle from line given by "azimuth" and h, such that h is the base of new triangle with length r and angle "polar"
			var polar:Number = Math.acos(z / r);
			
			// some funky math stuff was turning negative x values into positive on zRotation in 2D polar. Probably an issue with the modularity of atan
			// bit of a hacky work arround and will likely break, but fixes it for now.
			// i half-guessed the relevent axis for these 2 as i am unused to spherical co-ordinates.
			if (z < 0)
				polar += Trig.degToRad(180);
			if (x < 0)
				azimuth += Trig.degToRad(180);
			
			return new PolarVertex(r, azimuth, polar);
		}
	}
}