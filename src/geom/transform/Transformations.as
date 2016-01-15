package geom.transform {
	import flash.geom.Point;
	import geom.math.PolarPoint;
	import geom.math.Trig;
	
	public class Transformations {
		
		static public function transform2DPoints(points:Array, transformationData:Object):Array {
			var finishedPoints:Array = [];
			for (var i:uint = 0; i < points.length; i++)
				finishedPoints.push(transform2DPoint(points[i], transformationData));
			return finishedPoints;
		}
		
		static public function transform2DPoint(point:Point, transformationData:Object):Point {
			var returnedPoint:Point = point.clone();
			returnedPoint = Transformations.rotate(returnedPoint, transformationData.rotationZ);
			returnedPoint = Transformations.scale(returnedPoint, transformationData.scaleX, transformationData.scaleY);
			returnedPoint = Transformations.translate(returnedPoint, transformationData.translateX, transformationData.translateY);
			return returnedPoint;
		}
		
		// angle is +- degrees
		static public function rotate(point:Point, angle:Number):Point {
			var polarpoint:PolarPoint = Trig.cartesianToPolar(point);
			polarpoint.angle = polarpoint.angle + Trig.degToRad(angle);
			var newPoint:Point = polarpoint.toCartesian();
			newPoint.x = ExtraMath.round(newPoint.x, 0.0000001);
			newPoint.y = ExtraMath.round(newPoint.y, 0.0000001);
			return newPoint;
		}
		
		static public function scale(point:Point, scaleX:Number, scaleY:Number):Point {
			return new Point(point.x * scaleX, point.y * scaleY);
		}
		
		static public function translate(point:Point, translateX:Number, translateY:Number):Point {
			return new Point(point.x + translateX, point.y + translateY);
		}
	}
}