#!/usr/bin/env python3

import subprocess
import sys
import json
import os

from vosk import Model, KaldiRecognizer, SetLogLevel

SAMPLE_RATE = 16000

SetLogLevel(0)

model = Model("/home/dugi/dev-env/vosk-models/es/")
rec = KaldiRecognizer(model, SAMPLE_RATE)

# Create a temporary file to store ffmpeg output
temp_audio_file = "temp_audio.raw"
with open(temp_audio_file, "wb") as temp_file:

    # Capture audio and write it to the temporary file
    with subprocess.Popen(["ffmpeg", "-loglevel", "quiet", "-i",
                                sys.argv[1],
                                "-ar", str(SAMPLE_RATE) , "-ac", "1", "-f", "s16le", "-"],
                                stdout=temp_file, stderr=subprocess.PIPE) as process:

        process.communicate()  # Wait for ffmpeg to finish

# Process the transcription from the temporary file
with open(temp_audio_file, "rb") as audio_file:
    data = audio_file.read()
    if len(data) > 0:
        rec.AcceptWaveform(data)

result = json.loads(rec.FinalResult())
transcription = result['text']

# Remove the temporary file
os.remove(temp_audio_file)

print(transcription, end='')

# You can redirect the output to a text file as mentioned earlier:
# python voice-rec-file.py path/to/audio_file.wav > output.txt
