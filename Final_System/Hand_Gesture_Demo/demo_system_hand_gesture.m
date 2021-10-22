function [score,predicted_labels_gestures] = demo_system_hand_gesture(vid,sign)


%%%%%%%%%   Hand Gesture SubSystem %%%%%%%%%%%%%%%%%%%%%%%%%%%

        [handles,extract_gesture	]=extract_hand_gesture_RBPD2(vid,sign);

        load('GoodSuperHMM95_states_opt')

        superHMM=GoodSuperHMM95;


        [score,predicted_labels_gestures] = test_hand_gesture(superHMM,extract_gesture,centroidsZ)
        
        
        






   
    