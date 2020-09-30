function [input_image, wall_label] = wallFollowing(input_image, label, k, area_in)

[height, width] = size(input_image);


startDirect = 1;

wall = 0;


wall_label = randi(255);


hole = 0;

count =0;
quit_flag = 0;

for i = 1 : height
	for j = 1 : width
		if (input_image(i, j) == label) 
			input_image(i, j) = wall_label;

			startx = i;
            starty = j;
            my_locationx =0;
            my_locationy=0;
            
			my_direction = startDirect;

			while (my_locationx ~= startx && my_locationy ~= starty || my_direction ~= startDirect) 
		
                if(my_locationy == starty && quit_flag > 3 && my_locationx  < startx)
                            return
                end
               
                if k == 4 && count == 363 && area_in < 3500
                    return
                end
                
                
                if my_locationy == starty
                    quit_flag = quit_flag+1;
                end
                %imshow(uint8(input_image))
                
                
                count = count +1;
                if count>2
                    if startx == my_locationx-2 && starty == my_locationy
                        return
                    end
                end
                if (wall == 0)
					my_locationx = i;
                    my_locationy = j;
				end
				if (hole >= 4)
					hole = 0; 
					if (input_image(my_locationx - 1, my_locationy) == wall_label)
						my_locationx = my_locationx - 1;
                       
					elseif (input_image(my_locationx, my_locationy + 1) == wall_label)
						my_locationy = my_locationy + 1;
					elseif (input_image(my_locationx + 1, my_locationy) == wall_label)
						my_locationx = my_locationx + 1;
					elseif (input_image(my_locationx, my_locationy - 1) == wall_label)
						my_locationy = my_locationy - 1;
					end
				end
				input_image(my_locationx, my_locationy) = wall_label;
				if (my_direction == 1)
					if (input_image(my_locationx, my_locationy - 1) == label)
						hole = 0;

						my_direction = 4;
						my_locationy = my_locationy - 1;

						wall = wall + 1;
					elseif (input_image(my_locationx - 1, my_locationy) ~= label)
						hole = hole + 1;

						my_direction = 2;
					else 
						hole = 0;

						my_locationx = my_locationx - 1;

						wall = wall + 1;
					end
				elseif (my_direction == 2)
						if (input_image(my_locationx - 1, my_locationy) == label)
						hole = 0;

						my_direction = 1;
						my_locationx = my_locationx - 1;

						wall = wall + 1;
					elseif (input_image(my_locationx, my_locationy + 1) ~= label)
						hole = hole + 1;

						my_direction = 3;
                    else
                        if(my_locationy ==starty && count > 50)
                            return
                        end
						hole = 0;

						my_locationy = my_locationy + 1;

						wall = wall + 1;
					end
				elseif (my_direction == 3)
					if (input_image(my_locationx, my_locationy + 1) == label)
						hole = 0;

						my_direction = 2;
						my_locationy = my_locationy + 1;

						wall = wall + 1;
					elseif (input_image(my_locationx + 1, my_locationy) ~= label)

						hole = hole + 1;

						my_direction = 4;
                    else
                        
						hole = 0;

						my_locationx = my_locationx + 1;

						wall = wall + 1;
                        
					end
				elseif (my_direction == 4)
					if (input_image(my_locationx + 1, my_locationy) == label)
						hole = 0;

						my_direction = 3;
						my_locationx = my_locationx + 1;

						wall = wall + 1;
					elseif (input_image(my_locationx, my_locationy - 1) ~= label)
						hole = hole + 1;

						my_direction = 1;
					else 
						hole = 0;

						my_locationy = my_locationy - 1;

						wall = wall + 1;
					end
                end
                
                
            			end
		end
	end
end

end

