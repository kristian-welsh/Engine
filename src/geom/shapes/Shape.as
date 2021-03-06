package geom.shapes {
	import geom.data.Edge;
	import geom.data.Face;
	import geom.data.Vertex;
	import geom.transform.Transform;
	import geom.transform.TransformData;
	
	public class Shape {
		protected var points:Vector.<Vertex> = new Vector.<Vertex>();
		protected var edges:Vector.<Edge> = new Vector.<Edge>();
		protected var faces:Vector.<Face> = new Vector.<Face>();
		private var pos:Transform = new Transform(0, 0, 0);
		
		/// only to be called from inheriting class's super
		public function Shape(data:ShapeData) {
			for each (var point:Array in data.points)
				points.push(new Vertex(point[0], point[1], point[2], pos));
			
			for each (var line:Array in data.lines)
				edges.push(new Edge(points[line[0]], points[line[1]]));
			
			for each (var face:Array in data.faces)
				faces.push(new Face(edges[face[0]], edges[face[1]], edges[face[2]]));
		}
		
		public function numFaces():Number {
			return faces.length;
		}
		
		public function getFaceAt(index:uint):Face {
			return faces[index];
		}
		
		public function transform(data:TransformData):void {
			pos.applyTransform(data)
		}
	}
}