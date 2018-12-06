function maze = create_maze(maze_size, monsters)

	%create initial string array of "0"
	maze = string(zeros(maze_size));

	%place the player on the board (randomly assign position)
	maze(randi(maze_size*maze_size)) = "P";

	%place the exit on the board. Random. Don't overwrite player
	tempx = randi(maze_size);
	tempy = randi(maze_size);
	while maze(tempx, tempy) == "P"
		tempx = randi(maze_size);
		tempy = randi(maze_size);
	end
	maze(tempx, tempy) = "E";

	%if there are monsters, add monsters to the maze
	%randomly assign position(s). Don't overwrite player or exit
	for ii = 1:monsters
			while maze(tempx, tempy) == "P" | maze(tempx, tempy) == "E" | maze(tempx, tempy) == "M"
				tempx = randi(maze_size);
				tempy = randi(maze_size);
			end
			maze(tempx, tempy) = "M";
	end	
end