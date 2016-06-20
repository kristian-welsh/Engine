package geom.shapes {
	import geom.math.Edge;
	import geom.math.Tri;
	import geom.math.Vertex;
	
	public class Cube {
		private var points:Vector.<Vertex> = new Vector.<Vertex>();
		private var edges:Vector.<Edge> = new Vector.<Edge>();
		private var faces:Vector.<Tri> = new Vector.<Tri>();
		
		public function Cube(info:CubeInfo) {
			for each (var point:Array in info.points) {
				points.push(new Vertex(point[0], point[1], point[2]));
			}
			
			for each (var line:Array in info.lines)
				edges.push(new Edge(points[line[0]], points[line[1]]));
			
			for each (var face:Array in info.faces)
				faces.push(new Tri(edges[face[0]], edges[face[1]], edges[face[2]]));
		}
		
		public function numPoints():Number {
			return points.length;
		}
		
		public function numEdges():Number {
			return edges.length;
		}
		
		public function numFaces():Number {
			return faces.length;
		}
		
		public function getFaceAt(faceIndex:uint):Tri {
			return faces[faceIndex];
		}
	}
}