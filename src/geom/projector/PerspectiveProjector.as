package geom.projector {
	import math.Matrix;
	
	/* matrix that didn't work, I would like to understand why
		[1/Math.tan(a/2), 0,               0,           0            ]
		[0,               1/Math.tan(a/2), 0,           0            ]
		[0,               0,               (f+n)/(f-n), (2*f*n)/(f-n)]
		[0,               0,               -1,          0            ]
	*/
	// Still need to apply a camera transform etc to move scene into -z.
	public class PerspectiveProjector extends Projector {
		public function PerspectiveProjector() {
			var z:Number = 600; // viewer distance
			super(new Matrix([
				[1, 0, -1/z, 0],
				[0, 1, -1/z, 0],
				[0, 0,  1  , 0],
				[0, 0,  1/z, 0]]));
		}
	}

}