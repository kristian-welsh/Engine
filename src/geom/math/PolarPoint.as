package geom.math {
	import flash.geom.Point;
	
	public class PolarPoint {
		public var r:Number = 0;
		public var angle:Number = 0;
		
		public function PolarPoint(r:Number, angle:Number) {
			this.r = r;
			this.angle = angle;
		}
		
		public function toCartesian():Point {
			var newY:Number = r * Math.sin(angle);
			var newX:Number = r * Math.cos(angle);
			return new Point(newX, newY);
		}
	}
}