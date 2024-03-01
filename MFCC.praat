writeInfoLine: "MFCC \n"
form Make silence textgrid
    sentence Wav_file_in
    natural num_coef
    real w_legth
    real step  
    real f_filter
    real distance
    real maximu
endform
writeInfoLine: wav_file_in$
sound = Read from file: wav_file_in$
soundName$ = selected$ (1)
name$ = selected$ ("Sound", 1)
To MFCC: num_coef, w_legth, step, f_filter, distance, maximu
Save as text file: name$+".MFCC"
writeInfoLine: name$+".MFCC"