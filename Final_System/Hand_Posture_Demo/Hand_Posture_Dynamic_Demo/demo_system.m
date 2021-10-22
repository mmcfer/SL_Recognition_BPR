function demo_system(vid,sign)

%demo_system('Sample00418.zip','basta')

%%%%%%%%%   Hand Posture SubSystem %%%%%%%%%%%%%%%%%%%%%%%%%%%%


        % Hand Posture Extraction
        [hand_posture]=extract_hand_posture(vid,sign);

        right_hand=hand_posture.Posture{1, 1}.hand_posture_depth_right;
        left_hand=hand_posture.Posture{1, 1}.hand_posture_depth_left;

        %Shape Context  and Histogram  Extraction
        
        load('centroides_shape_context')
        
            [hist_descrip_right,hist_error_right]=shape_context_histo_centr_per_gesture_sum(right_hand,centroids_shape_cont_right);
            [hist_descrip_left,hist_error_left]=shape_context_histo_centr_per_gesture_sum(left_hand,centroids_shape_cont_left);

        %Concatenation
           both_hist = [ hist_descrip_right hist_descrip_left];


           for i=1:size(both_hist,1)

             both_hist(i,:)=both_hist(i,:)/(sum(both_hist(i,:)));

           end

            load('modelSVM')

        %SVM Prediction 
          % [predicted_labels_postures] = predict( 1, sparse(both_hist), model );
      [predicted_label, accuracy, prob_estimates] = predict( 1, sparse(both_hist), model );

      
      


   
    