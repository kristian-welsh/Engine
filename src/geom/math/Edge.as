package geom.math {
	public class Edge {
		private var startPoint:Vertex = Vertex.NULL;
		private var endPoint:Vertex = Vertex.NULL;
		
		public function Edge(startPoint:Vertex, endPoint:Vertex) {
			this.startPoint = startPoint;
			this.endPoint = endPoint;
		}
		
		public function getStart():Vertex {
			return startPoint;
		}
		
		public function getEnd():Vertex {
			return endPoint;
		}
	}
}