package geom.shapes {
	/* similar to .obj file format
	 * entire thing is 0 based
	 * this is centered around an origin of 0
	 * we are viewing from floor perspective; so y is up & down, x is left & right, z is forwards & backwards.
	 */
	public class CubeData extends ShapeData {
		public function CubeData() {
			// x y z
			points = [
				// top
				[ 1,  1,  1], //0
				[ 1,  1, -1],
				[-1,  1,  1],
				[-1,  1, -1],
				
				// bottom
				[ 1, -1,  1], //4
				[ 1, -1, -1],
				[-1, -1,  1],
				[-1, -1, -1]
				];
			
			// each line connects 2 points
			lines = [
				// top face
				[0, 1], //0
				[0, 2],
				[3, 1],
				[3, 2],
				[0, 3], // cross top
				
				// bottom face
				[4, 5], //5
				[4, 6],
				[7, 5],
				[7, 6],
				[4, 7], // cross bottom
				
				// mid-faces
				[0, 4], //10
				[1, 5],
				[2, 6],
				[3, 7],
				
				[0, 5], // cross front 14
				[1, 7], // cross left
				[3, 6], // cross back
				[2, 4] // cross right
				];
			
			// each face connects 3 lines
			faces = [
				// top
				[4, 0, 2],
				[4, 1, 3],
				
				// bottom
				[9, 5, 7],
				[9, 6, 8],
				
				// front
				[14, 0, 11],
				[14, 10, 5],
				
				// left
				[15, 11, 7],
				[15, 2, 13],
				
				// back
				[16, 8, 13],
				[16, 3, 12],
				
				// right
				[17, 1, 10],
				[17, 6, 12]
				];
		}
	}
}