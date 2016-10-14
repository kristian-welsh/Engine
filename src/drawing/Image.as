package drawing {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.utils.Timer;
	import geom.data.Edge;
	import geom.data.Face;
	import geom.data.Vertex;
	import geom.projector.Projector;
	import geom.shapes.Shape;
	
	public class Image {
		private var width:Number = 0;
		private var height:Number = 0;
		
		private var backgroundColour:Number = Colours.BLACK;
		private var bitmap:Bitmap;
		private var bitmapData:BitmapData;
		private var projector:Projector;
		
		public function Image(width:uint, height:uint, container:DisplayObjectContainer, projector:Projector) {
			this.width = width;
			this.height = height;
			this.projector = projector;
			
			bitmapData = new BitmapData(width, height, true, Colours.BLACK);
			bitmap = new Bitmap(bitmapData);
			container.addChild(bitmap);
		}
		
		public function drawBackground():void {
			for (var p:int = 0; p < width * height; p++)
				setPixel(new Point(p % width - Settings.WIDTH/2, p / width - Settings.HEIGHT/2), backgroundColour);
		}
		
		public function draw(shape:Shape):void {
			for (var i:uint = 0; i < shape.numFaces(); i++)
				drawFace(shape, i);
		}
		
		private function orientation(a:Point, b:Point, c:Point):int {
			return (b.x-a.x)*(c.y-a.y) - (b.y-a.y)*(c.x-a.x)
		}
		
		private function drawFace(shape:Shape, faceIndex:uint):void {
			var face:Face = shape.getFaceAt(faceIndex);
			
			var v0:Point = projector.cast(face.getVerteces()[0]);
			var v1:Point = projector.cast(face.getVerteces()[1]);
			var v2:Point = projector.cast(face.getVerteces()[2]);
			
			var minX:Number = Math.min(v0.x, v1.x, v2.x);
			var minY:Number = Math.min(v0.y, v1.y, v2.y);
			var maxX:Number = Math.max(v0.x, v1.x, v2.x);
			var maxY:Number = Math.max(v0.y, v1.y, v2.y);
			
			minX = Math.max(minX, -Settings.WIDTH/2);
			minY = Math.max(minY, -Settings.HEIGHT/2);
			maxX = Math.min(maxX, Settings.WIDTH/2);
			maxY = Math.min(maxY, Settings.HEIGHT/2);
			
			var p:Point = new Point();
			for (p.x = minX; p.x < maxX; p.x++) {
				for (p.y = minY; p.y < maxY; p.y++) {
					
					var w0:int = orientation(v1, v2, p);
					var w1:int = orientation(v2, v0, p);
					var w2:int = orientation(v0, v1, p);
					
					if (orientation(v0, v1, v2) < 0) {
						if (w0 < 0 && w1 < 0 && w2 < 0) {
							drawPoint(p);
						}
					} else if (orientation(v0, v1, v2) > 0) {
						if (w0 > 0 && w1 > 0 && w2 > 0) {
							drawPoint(p);
						}
					}
				}
			}
			
			drawEdge(face.getEdgeAt(0));
			drawEdge(face.getEdgeAt(1));
			drawEdge(face.getEdgeAt(2));
		}
		
		private function drawEdge(edge:Edge):void {
			var startPoint:Point = projector.cast(edge.getStart());
			var endPoint:Point = projector.cast(edge.getEnd());
			drawLine(startPoint, endPoint);
		}
		
		public function drawLine(start:Point, end:Point):void {
			var diffX:Number = end.x - start.x;
			var diffY:Number = end.y - start.y;
			var stepSize:uint = Math.max(Math.abs(diffX), Math.abs(diffY)) + 1;
			
			var curPoint:Point;
			for (var i:uint = 0; i <= stepSize; i++) {
				curPoint = new Point(start.x + diffX * i / stepSize, start.y + diffY * i / stepSize);
				drawPoint(curPoint, Colours.BLUE)
			}
		}
		
		public function drawPoint(point:Point, colour:uint = Colours.WHITE):void {
			setPixel(point, colour);
		}
		
		private function setPixel(point:Point, colour:uint):void {
			bitmapData.setPixel(point.x + Settings.WIDTH/2, point.y + Settings.HEIGHT/2, colour);
		}
	}
}