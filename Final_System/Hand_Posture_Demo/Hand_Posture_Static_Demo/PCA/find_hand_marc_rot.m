function result = find_hand_marc_rot(frame)


% function result = find_face2(frame)
%
% it takes as argument a depth frame. It is a hacky approach, that just looks for
% the nearest blob of a certain size.
[rows, cols] = size(frame);

count=1;
%projections = sum(frame, 2);
projections = sum(frame, 1);
% projections=fliplr(projections);
figure(4)
imagesc(projections)

% find top row of face
top_row = -1;
for i=cols:-1:1
    if (projections(i) > 0) 
        top_row = i;
        break;
    end
end
        
% find width of face
% max_width_row = -1;
% min_width_row = -1;
% max_width = -1;
% min_after_max = -1;
% for i=(top_row+5):rows/2 % % Upper part of the image only
%     width = projections(i);
%     if (width > max_width)
%         max_width = width;
%         min_after_max = max_width;
%         max_width_row = i;
%     end
%     if (width < min_after_max)
%         min_after_max = width;
%         min_width_row = i;
%         if (min_after_max < max_width * 0.7)
%             break;
%         end
%     end
% end

% find neck
%[min_width ,max_width_row] = max(projections(1:rows/2));
limit=length(projections)./2;
[min_width ,max_width_row] = max(projections(limit:end));
max_width=max(projections);
neck_row = -1;
for i=max_width_row:-1:2
    width = projections(i);
    width_ant=projections(i-1);
    if (width <= min_width/1.9)
        min_width = width;
        neck_row = i;
        break;
    elseif(width>width_ant)
        count=count+1;
        if(count==8)
        neck_row = i;
        break
        end
    else
        count=0;
    end
end
if(neck_row==-1)
    neck_row=2*max_width_row;
end
result = [top_row, neck_row];

% % find left column
% left_col = -1;
% for i = 1:rows
%     if (person(max_width_row, i) > 0)
%         left_col = i;
%         break;
%     end
% end
% 
% % find right column
% right_col = -1;
% for i = left_col:rows
%     if (person(max_width_row, i) == 0)
%         right_col = i;
%         break;
%     end
% end
% 
% result = [top_row, neck_row, left_col, right_col];
% % result to draw a rectangle in matlab with rectangle function
% result = [left_col      top_row      neck_row-top_row         right_col-left_col];

