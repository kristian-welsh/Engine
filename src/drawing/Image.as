package drawing {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.geom.Rectangle;
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
				oldEdges(shape.getFaceAt(i));
			for (var i:uint = 0; i < shape.numFaces(); i++)
				drawFace(shape, i);
		}
		
		private function orientation(a:Point, b:Point, c:Point):int {
			return (b.x-a.x)*(c.y-a.y) - (b.y-a.y)*(c.x-a.x)
		}
		
		private function drawFace(shape:Shape, faceIndex:uint):void {
			var face:Face = shape.getFaceAt(faceIndex);
			
			var v0:Vertex = projector.cast(face.getVerteces()[0]);
			var v1:Vertex = projector.cast(face.getVerteces()[1]);
			var v2:Vertex = projector.cast(face.getVerteces()[2]);
			
			var p0:Point = v0.toPoint();
			var p1:Point = v1.toPoint();
			var p2:Point = v2.toPoint();
			
			var minX:Number = Math.min(p0.x, p1.x, p2.x);
			var minY:Number = Math.min(p0.y, p1.y, p2.y);
			var maxX:Number = Math.max(p0.x, p1.x, p2.x);
			var maxY:Number = Math.max(p0.y, p1.y, p2.y);
			
			minX = Math.max(minX, -Settings.WIDTH/2);
			minY = Math.max(minY, -Settings.HEIGHT/2);
			maxX = Math.min(maxX, Settings.WIDTH/2);
			maxY = Math.min(maxY, Settings.HEIGHT/2);
			
			var p:Point = new Point();
			
			var r:Function = Math.round;
			
			// It might be worth porting to C++ at this point for performance
			var foo:Function = function(a:Vertex, b:Vertex, c:Vertex):void {
				if(a.y < b.y) {
					for (p.y = a.y; p.y <= b.y; p.y++) {
						for (p.x = interpolateX(a, b, p); p.x <= interpolateX(a, c, p); p.x++) {
							drawPoint(p);
						}
					}
				} else if (a.y > b.y) {
					for (p.y = b.y; p.y <= a.y; p.y++) {
						p.x = interpolateX(b, a, p);
						drawPoint(p);
					}
				} else {
					p.y = a.y;
					for (p.x = Math.min(a.x, b.x); p.x <= Math.max(a.x, b.x); p.x++) {
						drawPoint(p);
					}
				}
			}
			
			foo(v0, v1, v2);
			foo(v0, v2, v1);
			foo(v1, v2, v0);
				//puts(v0.z + ", " + v1.z + ", " + interpolateZ(v0, v1, p));
			/*
			for (p.x = minX; p.x < maxX; p.x++) {
				for (p.y = minY; p.y < maxY; p.y++) {
					var w0:int = orientation(p1, p2, p);
					var w1:int = orientation(p2, p0, p);
					var w2:int = orientation(p0, p1, p);
					
					if (orientation(p0, p1, p2) < 0) {
						if (w0 < 0 && w1 < 0 && w2 < 0) {
							drawPoint(p);
						}
					} else if (orientation(p0, p1, p2) > 0) {
						if (w0 > 0 && w1 > 0 && w2 > 0) {
							drawPoint(p);
						}
					}
				}
			}
			*/
		}
		
		private function oldEdges(face:Face):void {
			drawEdge(face.getEdgeAt(0));
			drawEdge(face.getEdgeAt(1));
			drawEdge(face.getEdgeAt(2));
		}
		
		private function interpolateX(a:Vertex, b:Vertex, p:Point):Number {
			var m:Number = (a.x - b.x) / (a.y - b.y);
			var result:Number = m * (p.y - a.y) + a.x;
			return result;
		}
		
		private function interpolateZ(a:Vertex, b:Vertex, p:Point):Number {
			var m:Number = (a.z - b.z) / (a.y - b.y);
			var result:Number = m * (p.y - a.y) + a.z;
			return result;
		}
		
		// will need to put all in buffer first, then draw each pixel in buffer.
		private function calcDepth(a:Vertex, b:Vertex, c:Vertex, d:Point):uint {
			var pa:Point = a.toPoint();
			var pb:Point = b.toPoint();
			var pc:Point = c.toPoint();
			var aPrime:Point = new Point(aPrimeX(pa, pb, pc, d), aPrimeY(pa, pb, pc, d));
			var bPrime:Point = new Point(aPrimeX(pb, pc, pa, d), aPrimeY(pb, pc, pa, d));
			var cPrime:Point = new Point(aPrimeX(pc, pa, pb, d), aPrimeY(pc, pa, pb, d));
			var ratioA:Number = distance(pa, d) / distance(d, aPrime);
			var ratioB:Number = distance(pb, d) / distance(d, bPrime);
			var ratioC:Number = distance(pc, d) / distance(d, cPrime);
			return ratioA * a.getPos().getCell(2, 0) + ratioB * b.getPos().getCell(2, 0) + ratioC * c.getPos().getCell(2, 0);
		}
		
		/** BLACK MAGIC calculated from https://math.stackexchange.com/questions/1873340/ratio-of-bisected-cevian-in-triangle-given-intersection-point notes in my notebook derive it. */
		private function aPrimeY(a:Point, b:Point, c:Point, d:Point):uint {
			return ((d.y - a.y) / (d.x - a.x)) * (aPrimeX(a, b, c, d) - d.x) + d.y;
		}
		
		private function aPrimeX(a:Point, b:Point, c:Point, d:Point):uint {
			return (c.x * (a.x * d.y + d.x * b.y - a.x * b.x - d.x * a.y) + b.x * (a.x * c.y + d.x * a.y - a.x * d.y - d.x * c.y)) / ((d.y - a.y) * (c.x - b.x) + (b.y - c.y) * (d.x - a.x));
		}
		
		private function distance(a:Point, b:Point):Number {
			return Math.sqrt(Math.pow(a.x - b.x, 2) + Math.pow(a.y - b.y, 2));
		}
		
		private function drawEdge(edge:Edge):void {
			var startPoint:Vertex = projector.cast(edge.getStart());
			var endPoint:Vertex = projector.cast(edge.getEnd());
			drawLine(startPoint.toPoint(), endPoint.toPoint());
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