package geom.projector {
	import flash.geom.Point;
	import geom.math.Vertex;
	
	public class OrthographicProjector implements Projector {
		public function cast(input:Vertex):Point {
			return new Point(input.getX(), input.getY());
		}
	}

}