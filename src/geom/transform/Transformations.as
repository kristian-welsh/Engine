package geom.transform {
	import flash.geom.Point;
	import geom.math.PolarPoint;
	import geom.math.PolarVertex;
	import geom.math.Trig;
	import geom.math.Vertex;
	import org.flashdevelop.utils.FlashConnect;
	
	public class Transformations {
		
		static public function applyTransformToVerteces(points:Vector.<Vertex>, transformationData:TransformData):Vector.<Vertex> {
			var finishedPoints:Vector.<Vertex> = new Vector.<Vertex>();
			for (var i:uint = 0; i < points.length; i++)
				finishedPoints.push(applyTransformToVertex(points[i], transformationData));
			return finishedPoints;
		}
		
		static public function applyTransformToVertex(vertex:Vertex, transformationData:TransformData):Vertex {
			var returnedPoint:Vertex = vertex.clone();
			returnedPoint = Transformations.rotate(returnedPoint, transformationData.rotationX, transformationData.rotationY, transformationData.rotationZ);
			returnedPoint = Transformations.scale(returnedPoint, transformationData.scaleX, transformationData.scaleY, transformationData.scaleZ);
			returnedPoint = Transformations.translate(returnedPoint, transformationData.translateX, transformationData.translateY, transformationData.translateZ);
			return returnedPoint;
		}
		
		// angle is +- degrees, only z rotation implemented. xy does something but i don't know. also xy is currently using rotationX from TData.
		static public function rotate(vertex:Vertex, xRotation:Number, yRotation:Number, zRotation:Number):Vertex {
			var returnMe:Vertex = vertex.clone();
			returnMe.transform.rotate(xRotation, yRotation, zRotation);
			return returnMe;
		}
		
		static public function scale(vertex:Vertex, scaleX:Number, scaleY:Number, scaleZ:Number):Vertex {
			var returnMe:Vertex = vertex.clone();
			returnMe.transform.scale(scaleX, scaleY, scaleZ);
			return returnMe;
		}
		
		static public function translate(vertex:Vertex, translateX:Number, translateY:Number, translateZ:Number):Vertex {
			var returnMe:Vertex = vertex.clone();
			returnMe.transform.translate(translateX, translateY, translateZ);
			return returnMe;
		}
	}
}