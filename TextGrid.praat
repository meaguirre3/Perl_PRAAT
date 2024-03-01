writeInfoLine: "textgrid \n"
form Make silence textgrid
    sentence Wav_file_in
    real pitch
    real step
    real silence_threshold
    real min
    real max
    sentence Slilabel
    sentence Sounding
endform
writeInfoLine: wav_file_in$
sound = Read from file: wav_file_in$
soundName$ = selected$ (1)
name$ = selected$ ("Sound", 1)
To TextGrid (silences): pitch, step, silence_threshold, min, max, slilabel$, sounding$
Save as text file: name$+".TextGrid"
writeInfoLine: name$+".TextGrid"