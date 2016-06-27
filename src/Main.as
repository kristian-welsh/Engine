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
	import geom.projector.OrthographicProjector;
	import geom.projector.Projector;
	import geom.shapes.CubeData;
	import geom.shapes.Shape;
	import geom.transform.TransformData;
	
	public class Main extends Sprite {
		static private const SIZE:uint = 1000;
		
		private var image:Image;
		private var cubeTransform:TransformData = new TransformData(300, 300, 0, 100, 100, 100, 0, 0, 0);
		private var change:TransformData = new TransformData(5, 10, 0, 1, 1.05, 1, 0, 2, 0);
		private var cube:Shape = new Shape(new CubeData());
		private var timer:Timer = new Timer(100);
		private var projector:Projector = new OrthographicProjector();
		
		public function Main() {
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			image = new Image(SIZE, SIZE, stage);
			Console.init(stage);
			cube.transform(cubeTransform);
			timer.addEventListener(TimerEvent.TIMER, tick);
			timer.start();
		}
		
		private function tick(e:Event):void {
			cube.transform(change);
			image.drawBackground();
			draw();
		}
		
		private function draw():void {
			for (var i:uint = 0; i < cube.numFaces(); i++)
				drawFace(i);
		}
		
		private function drawFace(cubeFace:uint):void {
			var points:Vector.<Vertex> = new Vector.<Vertex>();
			var face:Tri = cube.getFaceAt(cubeFace);
			
			drawEdge(face.getEdgeAt(0));
			drawEdge(face.getEdgeAt(1));
			drawEdge(face.getEdgeAt(2));
		}
		
		private function drawEdge(edge:Edge):void {
			var startPoint:Point = projector.cast(edge.getStart());
			var endPoint:Point = projector.cast(edge.getEnd());
			image.drawLine(startPoint, endPoint);
		}
	}
}