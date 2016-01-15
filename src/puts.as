package {
	import org.flashdevelop.utils.FlashConnect;
	
	public function puts(message:Object):void {
		FlashConnect.trace(message);
	}
}