writeInfoLine: "ENERGY "

form Make silence textgrid
    sentence Wav_file_in
    real frame_size
    real frame_step
endform

sound = Read from file: wav_file_in$
soundName$ = selected$ (1)
name$ = selected$ ("Sound", 1)
writeInfoLine: name$
selectObject:  soundName$
final = Get end time
#writeInfoLine: final

# Create the output file and write the first line.
outputPath$ = name$+".energy"
writeInfoLine: outputPath$
writeFileLine:"'outputPath$'","tiempo,energia"

paso_idx = 0
 while paso_idx + frame_size < final

    #writeInfoLine:paso_idx
    #paso_idx2 = paso_idx + frame_size
    energia =  Get energy... paso_idx (paso_idx + frame_size)
    appendFileLine: "'outputPath$'", 
                    ...paso_idx, ",",
                    ...energia

    paso_idx = paso_idx + frame_step

endwhile


