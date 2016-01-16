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
		static public function cartesianToPolar(point:Vertex):PolarVertex {
			// use pithagorean axial diagonal length calculation to get length from origin.
			// radial length to point on sphere
			var r:Number = Math.sqrt(point.getX() * point.getX() + point.getY() * point.getY() + point.getZ() * point.getZ());
			
			// find angle to take to 2nd dimention
			var azimuth:Number = Math.atan(point.getY() / point.getX());
			// find angle from line given by "azimuth" and h, such that h is the base of new triangle with length r and angle "polar"
			var polar:Number = Math.acos(point.getZ() / r);
			
			// some funky math stuff was turning negative x values into positive on zRotation in 2D polar. Probably an issue with the modularity of atan
			// bit of a hacky work arround and will likely break, but fixes it for now.
			// i half-guessed the relevent axis for these 2 as i am unused to spherical co-ordinates.
			if (point.getZ() < 0)
				polar += degToRad(180);
			if (point.getX() < 0)
				azimuth += degToRad(180);
			
			return new PolarVertex(r, azimuth, polar);
		}
	}

}