package geom.projector {
	import math.Matrix;
	
	// Still need to apply a camera transform etc to move scene into -z.
	public class PerspectiveProjector extends Projector {
		public function PerspectiveProjector() {
			// http://www.songho.ca/opengl/gl_projectionmatrix.html
			var fov:Number = Settings.FOV;
			var n:Number = 100;
			var f:Number = 300;
			var r:Number = n * Math.tan(fov/2);
			var l:Number = n * -Math.tan(fov/2);
			var t:Number = n * Math.tan(fov/2);
			var b:Number = n * -Math.tan(fov/2);
			super(new Matrix([
				[(2*n)/(r-l),           0,  (r+l)/(r-l),              0],
				[0          , (2*n)/(t-b),  (t+b)/(t-b),              0],
				[0          ,           0, -(f+n)/(f-n), -(2*f*n)/(f-n)],
				[0          ,           0,           -1,              0]]));
		}
	}

}