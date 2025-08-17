#!/bin/bash

# Extract audio streams from all videos in the current directory.

# Supported video file extensions (add more if needed)
VIDEO_EXTENSIONS="mp4 mkv mov avi webm"

# Loop through video files
for ext in $VIDEO_EXTENSIONS; do
  for video in *.$ext; do
    [ -e "$video" ] || continue  # skip if no files match
    echo "------------------------------------------"
    echo "[Processing \"$video\"...]"

    # Use ffprobe to detect the audio codec
    codec=$(ffprobe -v error -select_streams a:0 \
        -show_entries stream=codec_name \
        -of default=noprint_wrappers=1:nokey=1 "$video")

    # Determine output extension based on codec
    case "$codec" in
      aac)   ext_out="m4a" ;;
      mp3)   ext_out="mp3" ;;
      vorbis)ext_out="ogg" ;;
      opus)  ext_out="opus" ;;
      flac)  ext_out="flac" ;;
      alac)  ext_out="m4a" ;;
      *)     ext_out="audio" ;;  # fallback
    esac

    # Remove original extension and build output filename
    base="${video%.*}"
    output="${base}.${ext_out}"

    # Extract audio without re-encoding
    echo "==> Extracting audio codec: $codec -> $output"
    ffmpeg -i "$video" -vn -acodec copy "$output"
    echo "Done. Created \"$output\""
  done
done
