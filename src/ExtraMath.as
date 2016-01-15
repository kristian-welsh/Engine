package {
	public class ExtraMath {
		
		/**
		 * @param	input A number like 1000, 0.001, or 0.1 but not 123, 200, 0.011
		 * @return a number like 432000, 3.141, 3.3
		 */
		static public function round(input:Number, roundTo:Number):Number {
			return int(input * (1/roundTo))/(1/roundTo);
		}
	}
}