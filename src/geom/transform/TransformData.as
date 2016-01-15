package geom.transform {
	
	public class TransformData {
		public var translateX:Number;
		public var translateY:Number;
		public var scaleX:Number;
		public var scaleY:Number;
		public var rotationZ:Number;
		
		public function TransformData(translateX:Number = 0, translateY:Number = 0, scaleX:Number = 1, scaleY:Number = 1, rotationZ:Number = 0) {
			this.scaleY = scaleY;
			this.scaleX = scaleX;
			this.translateX = translateX;
			this.translateY = translateY;
			this.rotationZ = rotationZ;
		}
	}
}