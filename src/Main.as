package {
	import drawing.Colours;
	import drawing.Image;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Timer;
	import geom.math.Edge;
	import geom.math.Tri;
	import geom.math.Vertex;
	import geom.shapes.Cube;
	import geom.shapes.CubeInfo;
	import geom.transform.Transformations;
	import geom.transform.TransformData;
	import math.Matrix;
	import org.flashdevelop.utils.FlashConnect;
	
	public class Main extends Sprite {
		
		static private const SIZE:uint = 1000;
		
		private var image:Image;
		
		private var rot:Number = 0;
		
		private var cubeInfo:CubeInfo = new CubeInfo();
		private var screenTransform:TransformData = new TransformData(300, 300, 0, 100, 100, 1, 0, 0, 0);
		private var cube:Cube;
		private var timer:Timer = new Timer(100);
		private var text:TextField;
		
		public function Main() {
			if (stage) init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			initImage();
			initDebug();
			cube = new Cube(cubeInfo);
			drawCubeFaces();
			timer.addEventListener(TimerEvent.TIMER, foo);
			timer.start();
		}
		
		private function printLine(message:String):void {
			var lines:Array = text.text.split("\r");
			if (lines.length > 5) {
				for (var i:uint = 0; i < lines.length - 1; i++) {
					lines[i] = lines[i+1]
				}
				lines.length--;
				text.text = lines.join("\n");
			}
			text.appendText(message + "\n");
		}
		
		private function initDebug():void {
			text = new TextField();
			text.textColor = Colours.WHITE;
			printLine("Debug Init");
			stage.addChild(text);
		}
		
		private function foo(e:Event):void {
			rot += 0.25;
			printLine("rot: " + rot % 360);
			screenTransform = new TransformData(300, 300, 0, 100, 100, 100, rot, rot/2, rot/4);
			blackout();
			drawCubeFaces();
		}
		
		private function blackout():void {
			image.drawBackground();
		}
		
		private function initImage():void {
			image = new Image(SIZE, SIZE, stage);
		}
		
		private function drawCubeLine(cubeLine:Edge):void {
			// get 2D projected points to draw line between
			var startVertex:Vertex = Transformations.applyTransformToVertex(cubeLine.getStart(), screenTransform);
			var endVertex:Vertex = Transformations.applyTransformToVertex(cubeLine.getEnd(), screenTransform);
			var startPoint:Point = new Point(startVertex.getX(), startVertex.getY());
			var endPoint:Point = new Point(endVertex.getX(), endVertex.getY());
			
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
		
		// one of the faces isn't filling, but this system is being replaced soon, so i don't care.
		private function drawCubeFace(cubeFace:uint):void {
			var points:Vector.<Vertex> = new Vector.<Vertex>();
			var points2D:Vector.<Point> = new Vector.<Point>();
			var face:Tri = cube.getFaceAt(cubeFace);
			
			points = face.getVerteces();
			points = Transformations.applyTransformToVerteces(points, screenTransform);
			points2D = pointsTo2DPoints(points);
			
			// draw face by drawing all 3 lines then flood-filling inside it doesn't realy work, replace with triple simultaneous inequalities.
			drawCubeLine(face.getEdgeAt(0));
			drawCubeLine(face.getEdgeAt(1));
			drawCubeLine(face.getEdgeAt(2));
			//image.floodfill(averageOfPoints(points2D), Colours.BLUE);
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
		private function pointsTo2DPoints(points:Vector.<Vertex>):Vector.<Point> {
			var points2D:Vector.<Point> = new Vector.<Point>();
			for (var i:uint = 0; i < points.length; i++)
				points2D[i] = new Point(points[i].getX(), points[i].getY())
			return points2D;
		}
		
		// finds the arithmatic mean point of all 2Dpoints in array points
		private function averageOfPoints(points:Vector.<Point>):Point {
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