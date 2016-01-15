package geom.transform {
	import flash.geom.Point;
	import geom.math.PolarPoint;
	import geom.math.Trig;
	import geom.math.Vertex;
	
	public class Transformations {
		
		static public function applyTransformToVerteces(points:Vector.<Point>, transformationData:Object):Vector.<Point> {
			var finishedPoints:Vector.<Point> = new Vector.<Point>();
			for (var i:uint = 0; i < points.length; i++)
				finishedPoints.push(applyTransformToVertex(points[i], transformationData));
			return finishedPoints;
		}
		
		static public function applyTransformToVertex(vertex:Vertex, transformationData:Object):Point {
			var returnedPoint:Vertex = vertex.clone();
			returnedPoint = Transformations.rotate(returnedPoint, transformationData.rotationZ);
			returnedPoint = Transformations.scale(returnedPoint, transformationData.scaleX, transformationData.scaleY, transformationData.scaleZ);
			returnedPoint = Transformations.translate(returnedPoint, transformationData.translateX, transformationData.translateY, transformationData.translateZ);
			return returnedPoint;
		}
		
		// angle is +- degrees
		static public function rotate(point:Vertex, angle:Number):Vertex {
			var polarpoint:PolarPoint = Trig.cartesianToPolar(point);
			polarpoint.angle = polarpoint.angle + Trig.degToRad(angle);
			var newPoint:Point = polarpoint.toCartesian();
			newPoint.x = ExtraMath.round(newPoint.x, 0.0000001);
			newPoint.y = ExtraMath.round(newPoint.y, 0.0000001);
			return newPoint;
		}
		
		static public function scale(vertex:Vertex, scaleX:Number, scaleY:Number, scaleZ:Number):Vertex {
			return new Vertex(vertex.getX() * scaleX, vertex.getY() * scaleY, vertex.getZ() * scaleZ);
		}
		
		static public function translate(vertex:Vertex, translateX:Number, translateY:Number, translateZ:Number):Vertex {
			return new Vertex(vertex.getX() + translateX, vertex.getY() + translateY, vertex.getZ() + translateZ);
		}
	}
}