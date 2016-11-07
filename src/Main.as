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
		
		private var cubeTransform:TransformData = new TransformData(0, 0, -300, 50, 50, 50, 0, 0, 0);
		private var change:TransformData = new TransformData(0, 0, 0, 1, 1, 1, rads(5), rads(10), rads(10));
		private var projector:Projector = new PerspectiveProjector();
		
		private var cube:Shape = new Shape(new CubeData());
		private var timer:Timer = new Timer(1);
		
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