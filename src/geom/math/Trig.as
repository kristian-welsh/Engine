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
	}

}