package {
	import drawing.Image;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import geom.projector.PerspectiveProjector;
	import geom.projector.Projector;
	import geom.shapes.CubeData;
	import geom.shapes.Shape;
	import geom.transform.TransformData;
	
	public class Main extends Sprite {
		static private const SIZE:uint = 1000;
		
		private var image:Image;
		
		private var cubeTransform:TransformData = new TransformData(0, 0, -200, 50, 50, 50, 0, 0, 0);
		private var change:TransformData = new TransformData(0, 0, 0, 1, 1, 1, rads(20), 0, 0);
		private var projector:Projector = new PerspectiveProjector();
		/*
		   private var cubeTransform:TransformData = new TransformData(300, 300, 0, 200, 200, 100, 0, 0, 0);
		   private var change:TransformData = new TransformData(5, 10, 0, 1, 1.05, 1, 0, 2, 0);
		 */ /*
		   private var cubeTransform:TransformData = new TransformData(300, 300, 0, 2000, 2000, 100, 0, 0, 0);
		   private var change:TransformData = new TransformData(10000, 10000, 0, 1, 1, 1, 0, 0, 1);
		 */
		private var cube:Shape = new Shape(new CubeData());
		private var timer:Timer = new Timer(100);
		
		public function Main() {
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			image = new Image(SIZE, SIZE, stage, projector);
			cube.transform(cubeTransform);
			timer.addEventListener(TimerEvent.TIMER, tick);
			timer.start();
		}
		
		private function tick(e:Event):void {
			cube.transform(change);
			image.drawBackground();
			image.draw(cube);
		}
	}
}