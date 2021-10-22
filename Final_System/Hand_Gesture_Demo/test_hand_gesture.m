function [score,predicted_labels_gestures] = test_marc_demo(superHMM,gesture,centroidsNORM)
% superHMM--- struct
% gesture --- '____.mat'
% centroidsNORM --- matrix 
name={'basta' 'buonissimo' 'cheduepalle' 'chevuoi' 'combinato' 'cosatifarei' 'daccordo' 'fame' 'freganiente' 'furbo' 'messidaccordo' 'noncenepiu' 'ok' 'perfetto' 'prendere' 'seipazzo' 'sonostufo' 'tantotempo' 'vattene' 'vieniqui' 'Nothing'};
count=0;
count2=0;
count3=0;
count4=0;
count5=0;
count6=0;
count7=0;
count8=0;
count9=0;
count10=0;
count11=0;
count12=0;
count13=0;
count14=0;
count15=0;
count16=0;
count17=0;
count18=0;
count19=0;
count20=0;
count21=0;

%[observationsmatrix,observations] = get_observations_testSD(gesture,centroidsNORM);
[observationsmatrix,observations] = get_observations_test(gesture,centroidsNORM);

for dt =1:length(observations)
    
 loglike0(dt) = dhmm_logprob(observations{dt},superHMM.hmm_M_basta.prior, superHMM.hmm_M_basta.transmat,superHMM.hmm_M_basta.obsmat);
 loglike1(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_buonissimo.prior, superHMM.hmm_M_buonissimo.transmat, superHMM.hmm_M_buonissimo.obsmat);
 loglike2(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_cheduepalle.prior, superHMM.hmm_M_cheduepalle.transmat, superHMM.hmm_M_cheduepalle.obsmat);
 loglike3(dt)= dhmm_logprob(observations{dt}, superHMM.hmm_M_chevuoi.prior, superHMM.hmm_M_chevuoi.transmat, superHMM.hmm_M_chevuoi.obsmat);
 loglike4(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_combinato.prior, superHMM.hmm_M_combinato.transmat, superHMM.hmm_M_combinato.obsmat);
 loglike5(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_cosatifarei.prior, superHMM.hmm_M_cosatifarei.transmat, superHMM.hmm_M_cosatifarei.obsmat);
 loglike6(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_daccordo.prior, superHMM.hmm_M_daccordo.transmat, superHMM.hmm_M_daccordo.obsmat);
 loglike7(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_fame.prior, superHMM.hmm_M_fame.transmat,superHMM.hmm_M_fame.obsmat);
 loglike8(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_freganiente.prior, superHMM.hmm_M_freganiente.transmat, superHMM.hmm_M_freganiente.obsmat);
 loglike9(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_furbo.prior, superHMM.hmm_M_furbo.transmat, superHMM.hmm_M_furbo.obsmat);
 loglike10(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_messidaccordo.prior, superHMM.hmm_M_messidaccordo.transmat, superHMM.hmm_M_messidaccordo.obsmat);
 loglike11(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_noncenepiu.prior, superHMM.hmm_M_noncenepiu.transmat, superHMM.hmm_M_noncenepiu.obsmat);
 loglike12(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_ok.prior, superHMM.hmm_M_ok.transmat, superHMM.hmm_M_ok.obsmat);
 loglike13(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_perfetto.prior, superHMM.hmm_M_perfetto.transmat, superHMM.hmm_M_perfetto.obsmat);
 loglike14(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_prendere.prior, superHMM.hmm_M_prendere.transmat, superHMM.hmm_M_prendere.obsmat);
 loglike15(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_seipazzo.prior, superHMM.hmm_M_seipazzo.transmat, superHMM.hmm_M_seipazzo.obsmat);
 loglike16(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_sonostufo.prior, superHMM.hmm_M_sonostufo.transmat, superHMM.hmm_M_sonostufo.obsmat);
 loglike17(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_tantotempo.prior, superHMM.hmm_M_tantotempo.transmat, superHMM.hmm_M_tantotempo.obsmat);
 loglike18(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_vattene.prior, superHMM.hmm_M_vattene.transmat, superHMM.hmm_M_vattene.obsmat);
 loglike19(dt) = dhmm_logprob(observations{dt}, superHMM.hmm_M_vieniqui.prior, superHMM.hmm_M_vieniqui.transmat, superHMM.hmm_M_vieniqui.obsmat);
 end
 
 resultmatrix=[loglike0;loglike1;loglike2;loglike3;loglike4;loglike5;loglike6;loglike7;loglike8;loglike9;loglike10;loglike11;loglike12;loglike13;...
     loglike14;loglike15;loglike16;loglike17;loglike18;loglike19;];
 
 gesture=gesture(1:length(gesture)-4);
 count=0;
 sc=scoreresult_marc(resultmatrix);
 s=1;
 score{s,1}=name{sc(s)};
 
 predicted_labels_gestures=resultmatrix;
%  if(strcmp(score{s,1},gesture))
%      count=count+1;
%  end
 