package geom.transform {
	import flash.geom.Point;
	import geom.math.PolarPoint;
	import geom.math.PolarVertex;
	import geom.math.Trig;
	import geom.math.Vertex;
	import org.flashdevelop.utils.FlashConnect;
	
	public class Transformations {
		
		static public function applyTransformToVerteces(points:Vector.<Vertex>, transformationData:TransformData):void {
			for (var i:uint = 0; i < points.length; i++)
				applyTransformToVertex(points[i], transformationData);
		}
		
		static public function applyTransformToVertex(vertex:Vertex, transformationData:TransformData):void {
			Transformations.rotate(vertex, transformationData.rotationX, transformationData.rotationY, transformationData.rotationZ);
			Transformations.scale(vertex, transformationData.scaleX, transformationData.scaleY, transformationData.scaleZ);
			Transformations.translate(vertex, transformationData.translateX, transformationData.translateY, transformationData.translateZ);
		}
		
		// angle is +- degrees, only z rotation implemented. xy does something but i don't know. also xy is currently using rotationX from TData.
		static public function rotate(vertex:Vertex, xRotation:Number, yRotation:Number, zRotation:Number):void {
			vertex.transform.rotate(xRotation, yRotation, zRotation);
		}
		
		static public function scale(vertex:Vertex, scaleX:Number, scaleY:Number, scaleZ:Number):void {
			vertex.transform.scale(scaleX, scaleY, scaleZ);
		}
		
		static public function translate(vertex:Vertex, translateX:Number, translateY:Number, translateZ:Number):void {
			vertex.transform.translate(translateX, translateY, translateZ);
		}
	}
}