package geom.math {
	public class PolarVertex {
		//azimutha and polar are in radians.
		private var r:Number;
		private var azimuth:Number;
		private var polar:Number;
		
		public function PolarVertex(r:Number, azimuth:Number, polar:Number) {
			this.r = r;
			this.azimuth = azimuth;
			this.polar = polar;
		}
		
		// http://mathworld.wolfram.com/SphericalCoordinates.html
		public function toCartesian():Vertex {
			// code from polarpoint
			var newX:Number = r * Math.cos(azimuth) * Math.sin(polar);
			var newY:Number = r * Math.sin(azimuth) * Math.sin(polar);
			var newZ:Number = r * Math.cos(polar);
			return new Vertex(newX, newY, newZ);
		}
		
		public function increaseAzimuth(amount:Number):void {
			azimuth += amount;
		}
		
		// i will need complicated math stuff to make x and y roatation available
		public function increasePolar(amount:Number):void {
			polar += amount;
		}
	}
}