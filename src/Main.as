package {
	import drawing.Colours;
	import drawing.Image;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import geom.shapes.CubeInfo;
	import geom.transform.Transformations;
	import geom.transform.TransformData;
	
	public class Main extends Sprite {
		
		static private const SIZE:uint = 1000;
		
		private var image:Image;
		
		private var cubeInfo:CubeInfo = new CubeInfo();
		private var screenTransform:TransformData = new TransformData(300, 300, 100, 100, 20);
		
		public function Main() {
			if (stage) init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			initImage();
			drawCube();
		}
		
		private function initImage():void {
			image = new Image(SIZE, SIZE, stage);
		}
		
		private function drawCube():void {
			//drawCubeLines();
			//drawCubePoints();
			drawCubeFaces();
		}
		
		private function drawCubePoints():void {
			for (var i:uint = 0; i < cubeInfo.points.length; i++)
				drawCubePoint(i);
		}
		
		private function drawCubePoint(cubePoint:uint):void {
			var point:Point = new Point(cubeInfo.points[cubePoint][0], cubeInfo.points[cubePoint][1]);
			point = geom.transform.Transformations.transform2DPoint(point, screenTransform);
			image.drawWhite(point);
		}
		
		private function drawCubeLines():void {
			for (var i:uint = 0; i < cubeInfo.lines.length; i++)
				drawCubeLine(i);
		}
		
		private function drawCubeLine(cubeLine:uint):void {
			// get 2D projected points to draw line between
			var startPointValues:Array = cubeInfo.points[cubeInfo.lines[cubeLine][0]];
			var endPointValues:Array = cubeInfo.points[cubeInfo.lines[cubeLine][1]];
			var startPoint:Point = Transformations.transform2DPoint(new Point(startPointValues[0], startPointValues[1]), screenTransform);
			var endPoint:Point = Transformations.transform2DPoint(new Point(endPointValues[0], endPointValues[1]), screenTransform);
			
			// draw line in viewport
			var diffX:Number = endPoint.x - startPoint.x;
			var diffY:Number = endPoint.y - startPoint.y;
			var stepSize:uint = Math.max(Math.abs(diffX), Math.abs(diffY)) + 1;
			var curPoint:Point;
			for (var i:uint = 0; i <= stepSize; i++) {
				curPoint = new Point(startPoint.x + diffX * i / stepSize, startPoint.y + diffY * i / stepSize);
				image.drawRed(curPoint);
			}
		}
		
		private function drawCubeFaces():void {
			for (var i:uint = 0; i < cubeInfo.faces.length; i++)
				drawCubeFace(i);
		}
		
		private function drawCubeFace(cubeFace:uint):void {
			var points:Array = [];
			var face:Array = cubeInfo.faces[cubeFace];
			
			points = getFacePoints(face);
			points = pointsTo2DPoints(points);
			points = Transformations.transform2DPoints(points, screenTransform);
			
			// draw face by drawing all 3 lines then flood-filling inside it doesn't realy work, replace with triple simultaneous inequalities.
			drawCubeLine(face[0]);
			drawCubeLine(face[1]);
			drawCubeLine(face[2]);
			image.floodfill(averageOfPoints(points), Colours.BLUE);
		}
		
		private function getFacePoints(face:Array):Array {
			var points:Array = [];
			var curPoint:Array;
			
			for (var i:uint = 0; i < 3; i++) {
				for (var j:uint = 0; j < 2; j++) {
					curPoint = getCubePoint(getCubeLine(face[i])[j]);
					if (!arrayContains3DPoint(points, curPoint))
						points.push(curPoint);
				}
			}
			return points;
		}
		
		private function arrayContains3DPoint(array:Array, point:Array):Boolean {
			for (var i:uint = 0; i < array.length; i++)
				if (equality3DPoints(array[i], point))
					return true;
			return false;
		}
		
		// compare 2 3D points
		private function equality3DPoints(point1:Array, point2:Array):Boolean {
			assert(point1.length == 3);
			assert(point2.length == 3);
			
			for (var i:uint = 0; i < 3; i++) {
				assert(point1[i] != null);
				assert(point2[i] != null);
				
				if (point1[i] != point2[i])
					return false;
			}
			return true;
		}
		
		private function getCubeLine(lineNum:uint):Array {
			return cubeInfo.lines[lineNum];
		}
		
		private function getCubePoint(pointNum:uint):Array {
			return cubeInfo.points[pointNum];
		}
		
		// takes an array of 3D points, and returns an array of geom.Point, This is cast orthogonally.
		private function pointsTo2DPoints(points:Array):Array {
			var points2D:Array = [];
			for (var i:uint = 0; i < points.length; i++)
				points[i] = new Point(points[i][0], points[i][1])
			return points;
		}
		
		// finds the arithmatic mean point of all 2Dpoints in array points
		private function averageOfPoints(points:Array):Point {
			var averagePoint:Point = new Point();
			var curPoint:Point;
			for (var i:uint = 0; i < points.length; i++) {
				averagePoint.x += points[i].x;
				averagePoint.y += points[i].y;
			}
			averagePoint.x /= points.length;
			averagePoint.y /= points.length;
			return averagePoint;
		}
	}
}