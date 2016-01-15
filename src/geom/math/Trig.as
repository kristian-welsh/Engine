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
			var r:Number = Math.sqrt(point.getX() * point.getX() + point.getY() * point.getY() + point.getZ() * point.getZ());
			
			// use angle = atan(o/a) for each axis
			var xRotation:Number = Math.atan(point.getY() / point.getZ());
			var yRotation:Number = Math.atan(point.getZ() / point.getX());
			var zRotation:Number = Math.atan(point.getY() / point.getX());
			
			// some funky math stuff was turning negative x values into positive on zRotation. Probably an issue with the modularity of atan
			// bit of a hacky work arround and will likely break, but fixes it for now.
			if (point.getZ() < 0)
				xRotation += degToRad(180);
			
			// i half-guessed the relevent axis for these 2
			if (point.getX() < 0)
				yRotation += degToRad(180);
			
			if (point.getX() < 0)
				zRotation += degToRad(180);
			
			return new PolarVertex(r, xRotation, yRotation, zRotation);
		}
	}

}