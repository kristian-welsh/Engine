package drawing {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	public class Image {
		private var width:Number = 0;
		private var height:Number = 0;
		
		private var backgroundColour:Number = Colours.BLACK;
		private var bitmap:Bitmap;
		private var bitmapData:BitmapData;
		
		public function Image(width:uint, height:uint, container:DisplayObjectContainer) {
			this.width = width;
			this.height = height;
			
			bitmapData = new BitmapData(width, height, true, Colours.BLACK);
			bitmap = new Bitmap(bitmapData);
			container.addChild(bitmap);
		}
		
		public function drawBackground():void {
			for (var p:int = 0; p < width * height; p++)
				setPixel(new Point(p % width, p / width), backgroundColour);
		}
		
		public function drawPoint(point:Point):void {
			setPixel(point, Colours.WHITE);
		}
		
		public function drawLine(start:Point, end:Point):void {
			var diffX:Number = end.x - start.x;
			var diffY:Number = end.y - start.y;
			var stepSize:uint = Math.max(Math.abs(diffX), Math.abs(diffY)) + 1;
			var curPoint:Point;
			for (var i:uint = 0; i <= stepSize; i++) {
				curPoint = new Point(start.x + diffX * i / stepSize, start.y + diffY * i / stepSize);
				drawPoint(curPoint)
			}
		}
		
		private function setPixel(point:Point, colour:uint):void {
			bitmapData.setPixel(point.x, point.y, colour);
		}
	}
}