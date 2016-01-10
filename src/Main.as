package{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flashdevelop.utils.FlashConnect;
	
	public class Main extends Sprite {
		
		private const SIZE:uint = 1000;
		private var image:Bitmap;
		private var imageData:BitmapData;
		
		// similar to .obj file format
		// entire thing is 0 based
		// this is centered around an origin of 0
		// we are viewing from the side; so y is up, x is right, z is towards.
		private var cubeInfo:Object = {
			// x y z
			"points": [
				// top
				[ 1,  1,  1],//0
				[ 1,  1, -1],
				[-1,  1,  1],
				[-1,  1, -1],
				
				// bottom
				[ 1, -1,  1],//4
				[ 1, -1, -1],
				[-1, -1,  1],
				[-1, -1, -1]
			],
			
			// each line connects 2 points
			"lines": [
				// top face
				[0, 1],//0
				[0, 2],
				[3, 1],
				[3, 2],
				[0, 3],// cross top
				
				// bottom face
				[4, 5],//5
				[4, 6],
				[7, 5],
				[7, 6],
				[4, 7],// cross bottom
				
				// mid-faces
				[0, 4],//10
				[1, 5],
				[2, 6],
				[3, 7],
				
				[0, 5],// cross front 14
				[1, 7],// cross left
				[3, 6],// cross back
				[2, 4] // cross right
			],
			
			// each face connects 3 lines
			"faces": [
				// top
				[4, 0, 2],
				[4, 1, 3],
				
				// bottom
				[9, 5, 7],
				[9, 6, 8],
				
				// front
				[14, 0, 11],
				[14, 10, 5],
				
				// left
				[15, 11, 7],
				[15, 2, 13],
				
				// back
				[16, 8, 13],
				[16, 3, 12],
				
				// right
				[17, 1, 10],
				[17, 6, 12]
			]
		};
		
		private var cubeData:Object = {
			"info": cubeInfo,
			"x-translate": 300,
			"y-translate": 300,
			"x-scale": 100,
			"y-scale": 100,
			"rotation": 0 // degrees, based at origin
		}
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			initImage();
			initCube();
		}
		
		private function initImage():void {
			imageData = new BitmapData(SIZE, SIZE);
			image = new Bitmap(imageData);
			this.addChild(image);
			blackout();
		}
		
		private function blackout():void {
			for (var i:int = 0; i < SIZE * SIZE; i++) {
				imageData.setPixel(i % SIZE, i / SIZE, 0x000000);
			}
		}
		
		private function drawWhite(x:uint, y:uint):void {
			imageData.setPixel(x, y, 0xFFFFFF);
		}
		
		private function drawRed(x:uint, y:uint):void {
			imageData.setPixel(x, y, 0xFF0000);
		}
		
		private function drawGreen(x:uint, y:uint):void {
			imageData.setPixel(x, y, 0x00FF00);
		}
		
		private function drawBlue(x:uint, y:uint):void {
			imageData.setPixel(x, y, 0x0000FF);
		}
		
		private function transformX(x:uint):uint {
			return x * cubeData["x-scale"] + cubeData["x-translate"];
		}
		
		private function transformY(y:uint):uint {
			return y * cubeData["y-scale"] + cubeData["y-translate"];
		}
		
		private function initCube():void {
			drawCubePoints();
			drawCubeLines();
		}
		
		private function drawCubePoints():void {
			for (var i:uint = 0; i < cubeData.info.points.length; i++)
				drawCubePoint(i);
		}
		
		private function drawCubeLines():void {
			for (var i:uint = 0; i < cubeData.info.lines.length; i++)
				drawCubeLine(i);
		}
		
		private function drawCubePoint(cubePoint:uint):void {
			var pointX:uint = cubeData.info.points[cubePoint][0];
			var pointY:uint = cubeData.info.points[cubePoint][1];
			drawWhite(transformX(pointX), transformY(pointY));
		}
		
		private function drawCubeLine(cubeLine:uint):void {
			var startPoint = cubeData.info.points[cubeData.info.lines[cubeLine][0]];
			var endPoint = cubeData.info.points[cubeData.info.lines[cubeLine][1]];
			FlashConnect.trace("start: " + startPoint + ", end: " + endPoint);
		}
	}
}