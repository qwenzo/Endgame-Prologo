import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class Main {

	public static void GenGrid(String grid){
		String[] gridArray = grid.split(";");
		String gridSize = gridArray[0];
		String ironmanCoordinates = gridArray[1];
		String thanosCoordiantes = gridArray[2];
		String stoneCoordinates = gridArray[3];

		String[] ironmanArray = ironmanCoordinates.split(",");
		String[] thanosArray = thanosCoordiantes.split(",");
		String[] stoneArray = stoneCoordinates.split(",");
		String[] gridsizeArray = gridSize.split(",");

		String ironmanFact = "ironman(loc(" + ironmanArray[0] + ","+  ironmanArray[1] +"), [],  s0).";
		String thanosFact = "thanos(loc(" + thanosArray[0] + ","+  thanosArray[1] +")).";
		String stone1Fact = "stone(loc(" + stoneArray[0] + ","+  stoneArray[1] +")).";
		String stone2Fact = "stone(loc(" + stoneArray[2] + ","+  stoneArray[3] +")).";
		String stone3Fact = "stone(loc(" + stoneArray[4] + ","+  stoneArray[5] +")).";
		String stone4Fact = "stone(loc(" + stoneArray[6] + ","+  stoneArray[7] +")).";
		String gridsizeFact = "grid_size(" + gridsizeArray[0] + ","+  gridsizeArray[1] +").";
		String locationsFact = "locations([loc(" + stoneArray[0] + "," + stoneArray[1] + "), loc("+ stoneArray[2] + "," + stoneArray[3] + "), loc(" + stoneArray[4] + "," 
				+ stoneArray[5] + "), loc(" + stoneArray[6] + "," + stoneArray[7] + ")]).";


		String content = ironmanFact + "\n" + thanosFact + "\n" + stone1Fact + "\n" + stone2Fact + "\n" + stone3Fact + "\n" + stone4Fact + "\n" + gridsizeFact + "\n" + locationsFact;
		PrintWriter writer = null;
		try {
			int count = 1;
			String path = "";
			while(true) {
				path = "KB" + count + ".pl";
				if(!Files.isReadable(Paths.get(path)))
					break;
				count++;
			}
			writer = new PrintWriter(path, "UTF-8");
			writer.println(content);
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	public static void main(String[] args) {
		GenGrid("5,5;1,2;3,4;1,1,2,1,2,2,3,3");

		GenGrid("5,5;1,1;3,3;3,1,2,3,4,2,4,4");
	}
}