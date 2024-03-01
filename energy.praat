writeInfoLine: "ENERGY "
writeInfoLine: "FORMANTES"

form Make silence textgrid
    sentence Wav_file_in
    sentence Textgrid_in
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
appendInfoLine: "NUMERO DE INTERVALOS ", numberOfPhonemes

# Create the output file and write the first line.
outputPath$ = name$+".energy"
writeInfoLine: outputPath$
writeFileLine:"'outputPath$'","phoneme,intervalo,inte_start,inte_end,energia"

for thisInterval from 1 to numberOfPhonemes
    #appendInfoLine: thisInterval

    # Get the label of the interval
    select 'textgridName$'
    thisPhoneme$ = Get label of interval: 1, thisInterval
    #appendInfoLine: thisPhoneme$
    

        thisPhonemeStartTime = Get start point: 1, thisInterval
        thisPhonemeEndTime   = Get end point:   1, thisInterval
        select Sound 'name$'
        energia =  Get energy... thisPhonemeStartTime thisPhonemeEndTime
        appendInfoLine:thisPhoneme$, "hola", thisInterval ,energia
        appendFileLine: "'outputPath$'", 
                    ...thisPhoneme$, ",",
                    ...thisInterval, ",",
                    ...thisPhonemeStartTime, ",",
                    ...thisPhonemeEndTime, ",",
                    ...energia


endfor