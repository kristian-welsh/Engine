package geom.transform {
	
	public class TransformData {
		public var translateX:Number;
		public var translateY:Number;
		public var translateZ:Number;
		public var scaleX:Number;
		public var scaleY:Number;
		public var scaleZ:Number;
		public var rotateX:Number;
		public var rotateY:Number;
		public var rotateZ:Number;
		
		// probably getting a bit unweildly.
		public function TransformData(translateX:Number = 0, translateY:Number = 0, translateZ:Number = 0,
				scaleX:Number = 1, scaleY:Number = 1, scaleZ:Number = 1,
				rotationX:Number = 0, rotationY:Number = 0, rotationZ:Number = 0) {
			this.translateX = translateX;
			this.translateY = translateY;
			this.translateZ = translateZ;
			this.scaleX = scaleX;
			this.scaleY = scaleY;
			this.scaleZ = scaleZ;
			this.rotateX = rotationX;
			this.rotateY = rotationY;
			this.rotateZ = rotationZ;
		}
	}
}