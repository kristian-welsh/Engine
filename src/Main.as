package {
	import drawing.Image;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import geom.math.Edge;
	import geom.math.Tri;
	import geom.math.Vertex;
	import geom.shapes.Cube;
	import geom.shapes.CubeInfo;
	import geom.transform.Transformations;
	import geom.transform.TransformData;
	
	public class Main extends Sprite {
		static private const SIZE:uint = 1000;
		
		private var image:Image;
		private var cubeTransform:TransformData;
		private var cubeInfo:CubeInfo = new CubeInfo();
		private var cube:Cube = new Cube(cubeInfo);
		private var timer:Timer = new Timer(100);
		private var rot:Number = 0;
		
		public function Main() {
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			image = new Image(SIZE, SIZE, stage);
			Console.init(stage);
			timer.addEventListener(TimerEvent.TIMER, tick);
			timer.start();
		}
		
		private function tick(e:Event):void {
			cubeTransform = new TransformData(300, 300, 0, 100, 100, 100, rot, rot / 16, 0);
			Console.printLine("rot: " + rot % 360);
			rot += 0.25;
			image.drawBackground();
			drawCubeFaces();
		}
		
		private function drawCubeFaces():void {
			for (var i:uint = 0; i < cubeInfo.faces.length; i++)
				drawCubeFace(i);
		}
		
		// currently draws all tri lines
		private function drawCubeFace(cubeFace:uint):void {
			var points:Vector.<Vertex> = new Vector.<Vertex>();
			var face:Tri = cube.getFaceAt(cubeFace);
			
			points = Transformations.applyTransformToVerteces(face.getVerteces(), cubeTransform);
			
			drawCubeLine(face.getEdgeAt(0));
			drawCubeLine(face.getEdgeAt(1));
			drawCubeLine(face.getEdgeAt(2));
		}
		
		private function drawCubeLine(cubeLine:Edge):void {
			// get 2D projected points to draw line between
			var startVertex:Vertex = Transformations.applyTransformToVertex(cubeLine.getStart(), cubeTransform);
			var endVertex:Vertex = Transformations.applyTransformToVertex(cubeLine.getEnd(), cubeTransform);
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
	}
}