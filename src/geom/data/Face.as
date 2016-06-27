package geom.data {
	public class Face {
		private var edges:Vector.<Edge> = new Vector.<Edge>();
		
		public function Face(edge1:Edge, edge2:Edge, edge3:Edge) {
			edges.push(edge1);
			edges.push(edge2);
			edges.push(edge3);
		}
		
		public function getVerteces():Vector.<Vertex> {
			var verteces:Vector.<Vertex> = new Vector.<Vertex>
			
			var curVertex:Vertex;
			for (var i:uint = 0; i < 3; i++) {
				for (var j:uint = 0; j < 2; j++) {
					curVertex = (j ? edges[i].getStart() : edges[i].getEnd());
					if (verteces.indexOf(curVertex) == -1)
						verteces.push(curVertex);
				}
			}
			return verteces;
		}
		
		public function getEdgeAt(edgeIndex:uint):Edge {
			return edges[edgeIndex];
		}
	}
}