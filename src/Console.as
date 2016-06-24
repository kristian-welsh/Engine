package {
	import drawing.Colours;
	import flash.display.Stage;
	import flash.text.TextField;
	public class Console {
		static private var text:TextField;
		
		static public function init(stage:Stage):void {
			text = new TextField();
			text.textColor = Colours.WHITE;
			printLine("Debug Init");
			stage.addChild(text);
		}
		
		static public function printLine(message:String):void {
			var lines:Array = text.text.split("\r");
			if (lines.length > 5) {
				for (var i:uint = 0; i < lines.length - 1; i++) {
					lines[i] = lines[i+1]
				}
				lines.length--;
				text.text = lines.join("\n");
			}
			text.appendText(message + "\n");
		}
	}
}