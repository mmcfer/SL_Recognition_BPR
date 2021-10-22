function demo_PCA(folder1,folder2)
    
%demo_PCA('TestSet\Static1\RGB','TestSet\Static1\Depth');
%demo_PCA('TestSet\Static2\RGB','TestSet\Static2\Depth');
%demo_PCA('TestSet\Static3\RGB','TestSet\Static3\Depth');
%demo_PCA('TestSet\Static4\RGB','TestSet\Static4\Depth');
%demo_PCA('TestSet\Static5\RGB','TestSet\Static5\Depth');
%demo_PCA('TestSet\Static6\RGB','TestSet\Static6\Depth');
%demo_PCA('TestSet\Static7\RGB','TestSet\Static7\Depth');
%demo_PCA('TestSet\Static8\RGB','TestSet\Static8\Depth');


close all
hand=extract_data_hand_depth_no_binary_close('TestSet\Static1\RGB','TestSet\Static1\Depth');

