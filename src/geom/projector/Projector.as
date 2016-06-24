package geom.projector {
	import flash.geom.Point;
	import geom.math.Vertex;
	
	public interface Projector {
		function cast(input:Vertex):Point;
	}
}