package geom.math {
	import flash.geom.Point;
	import geom.math.PolarPoint;
	
	public class Trig {
		static public function degToRad(deg:Number):Number {
			return deg * Math.PI / 180;
		}
		
		static public function radToDeg(rad:Number):Number {
			return rad * 180 / Math.PI;
		}
		
		// result in radians
		static public function cartesianToPolar(point:Point):PolarPoint {
			var r:Number = Math.sqrt(point.x * point.x + point.y * point.y);
			var angle:Number = Math.atan(point.y / point.x);
			
			// some funky math stuff was turning negative x values into positive. Probably an issue with the modularity of atan
			// bit of a hacky work arround and will likely break, but fixes it for now.
			if (point.x < 0)
				angle += degToRad(180);
			
			return new PolarPoint(r, angle);
		}
	}

}