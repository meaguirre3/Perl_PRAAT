writeInfoLine: "FORMANTES"

form Make silence textgrid
    sentence Wav_file_in
    sentence Textgrid_in
    real time_step
    natural num_formants
    real forman_celling_Hz
    real window_length
    real pre_empasis_Hz
endform
sound = Read from file: wav_file_in$
soundName$ = selected$ (1)
name$ = selected$ ("Sound", 1)
writeInfoLine: name$
textgrid=Read from file: textgrid_in$
textgridName$ = selected$ (1)
writeInfoLine:textgridName$

# Extract the number of intervals in the phoneme tier
select  'textgridName$'
numberOfPhonemes = Get number of intervals: 1  
appendInfoLine: "There are ", numberOfPhonemes, " intervals."

# Create the Formant Object
select Sound 'name$'
formant= To Formant (burg)... time_step num_formants forman_celling_Hz window_length pre_empasis_Hz
Save as text file: name$+".FORMANTS"
writeInfoLine: name$+".FORMANTS"