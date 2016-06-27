package geom.transform {
	import geom.transform.TransformData;
	import math.Matrix;
	
	public class Transform {
		private var parent:Transform;
		private var initialPos:Matrix;
		public var s:Array = [1, 1, 1];
		public var r:Array = [0, 0, 0];
		public var t:Array = [0, 0, 0];
		
		public function Transform(x:Number = 0, y:Number = 0, z:Number = 0, parent:Transform = null) {
			initialPos = new Matrix([
				[x],
				[y],
				[z],
				[1]]);
			this.parent = parent;
		}
		
		public function scale(x:Number, y:Number, z:Number):void {
			s[0] *= x;
			s[1] *= y;
			s[2] *= z;
		}
		
		public function rotate(x:Number, y:Number, z:Number):void {
			r[0] += x;
			r[1] += y;
			r[2] += z;
		}
		
		public function translate(x:Number, y:Number, z:Number):void {
			t[0] += x;
			t[1] += y;
			t[2] += z;
		}
		
		public function applyTransform(data:TransformData):void {
			rotate(data.rotateX, data.rotateY, data.rotateZ);
			scale(data.scaleX, data.scaleY, data.scaleZ);
			translate(data.translateX, data.translateY, data.translateZ);
		}
		
		public function calcPos():Matrix {
			var pos:Matrix;
			
			var ps:Array;
			var pr:Array;
			var pt:Array;
			if(parent) {
				ps = [parent.s[0], parent.s[1], parent.s[2]];
				pr = [parent.r[0], parent.r[1], parent.r[2]];
				pt = [parent.t[0], parent.t[1], parent.t[2]];
			} else {
				ps = [1,1,1];
				pr = [0,0,0];
				pt = [0,0,0];
			}
			pos = new Matrix([
				[s[0]*ps[0], 0, 0, 0],
				[0, s[1]*ps[1], 0, 0],
				[0, 0, s[2]*ps[2], 0],
				[0, 0, 0, 1]]).dot(initialPos);
			pos = new Matrix([
				[Math.cos(r[2]+pr[2]), -Math.sin(r[2]+pr[2]), 0, 0],
				[Math.sin(r[2]+pr[2]),  Math.cos(r[2]+pr[2]), 0, 0],
				[0                   ,  0                   , 1, 0],
				[0                   ,  0                   , 0, 1]]).dot(pos);
			pos = new Matrix([
				[ Math.cos(r[1]+pr[1]), 0, Math.sin(r[1]+pr[1]), 0],
				[ 0                   , 1, 0                   , 0],
				[-Math.sin(r[1]+pr[1]), 0, Math.cos(r[1]+pr[1]), 0],
				[ 0                   , 0, 0                   , 1]]).dot(pos);
			pos = new Matrix([
				[1, 0                   ,  0                   , 0],
				[0, Math.cos(r[0]+pr[0]), -Math.sin(r[0]+pr[0]), 0],
				[0, Math.sin(r[0]+pr[0]),  Math.cos(r[0]+pr[0]), 0],
				[0, 0                   ,  0                   , 1]]).dot(pos);
			pos = new Matrix([
				[1, 0, 0, t[0]+pt[0]],
				[0, 1, 0, t[1]+pt[1]],
				[0, 0, 1, t[2]+pt[2]],
				[0, 0, 0, 1]]).dot(pos);
			return pos;
		}
	
	}
}