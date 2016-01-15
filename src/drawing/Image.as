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
			for (var p:int = 0; p < width * height; p++) {
				setPixel(new Point(p % width, p / width), backgroundColour);
			}
		}
		
		public function drawWhite(point:Point):void {
			setPixel(point, Colours.WHITE);
		}
		
		public function drawRed(point:Point):void {
			setPixel(point, Colours.RED);
		}
		
		public function drawGreen(point:Point):void {
			setPixel(point, Colours.GREEN);
		}
		
		public function drawBlue(point:Point):void {
			setPixel(point, Colours.BLUE);
		}
		
		public function floodfill(point:Point, colour:uint):void {
			bitmapData.floodFill(point.x, point.y, colour);
		}
		
		private function setPixel(point:Point, colour:uint):void {
			bitmapData.setPixel(point.x, point.y, colour);
		}
	}
}