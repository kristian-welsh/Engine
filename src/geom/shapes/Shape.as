package geom.shapes {
	import geom.math.Edge;
	import geom.math.Tri;
	import geom.math.Vertex;
	import geom.transform.Transformations;
	import geom.transform.TransformData;

	public class Shape {
		protected var points:Vector.<Vertex> = new Vector.<Vertex>();
		protected var edges:Vector.<Edge> = new Vector.<Edge>();
		protected var faces:Vector.<Tri> = new Vector.<Tri>();
		
		/// only to be called from inheriting class's super
		public function Shape(data:ShapeData) {
			for each (var point:Array in data.points)
				points.push(new Vertex(point[0], point[1], point[2]));
			
			for each (var line:Array in data.lines)
				edges.push(new Edge(points[line[0]], points[line[1]]));
			
			for each (var face:Array in data.faces)
				faces.push(new Tri(edges[face[0]], edges[face[1]], edges[face[2]]));
		}
		
		public function numFaces():Number {
			return faces.length;
		}
		
		public function getFaceAt(index:uint):Tri {
			return faces[index];
		}
		
		public function transform(data:TransformData):void {
			Transformations.applyTransformToVerteces(points, data);
		}
	}
}