package geom.projector {
	import math.Matrix;
	
	public class PerspectiveProjector extends Projector {
		public function PerspectiveProjector() {
			super(new Matrix([
				[1, 0, 0, 0],
				[0, 1, 0, 0],
				[0, 0, 1, 0],
				[0, 0, -1, 0]]));
		}
	}

}