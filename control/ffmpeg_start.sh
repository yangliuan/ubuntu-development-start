#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                 FFmpeg Tools                                 #
################################################################################
"
echo "start search videos..."
directory="$HOME/Videos"
[ ! -d "${directory}" ] && { echo "No such directory: Videos" ; exit 1; }  
video_formats=("mp4" "avi" "mkv" "mov" "wmv" "flv" "3gp" "mpeg" "ogv" "vob" "dv" "yuv" "rm" "rmvb")

video_files=()
for format in "${video_formats[@]}"; do
  video_files+=($(find "$directory" -type f -name "*.$format" -exec realpath {} \; 2>/dev/null))
done
video_files=($(echo "${video_files[@]}" | tr ' ' '\n' | sort -u))

index=0

while true; do
  clear

  for ((i=0; i<${#video_files[@]}; i++)); do
    if [[ $i -eq $index ]]; then
      echo "> ${video_files[$i]}"
    else
      echo "  ${video_files[$i]}"
    fi
  done

  read -rsn1 key

  case "$key" in
    "A")
      ((index--))
      if [[ $index -lt 0 ]]; then
        index=$((${#video_files[@]} - 1))
      fi
      ;;
    "B")
      ((index++))
      if [[ $index -ge ${#video_files[@]} ]]; then
        index=0
      fi
      ;;
    "")
      selected_video=${video_files[$index]}
      break
      ;;
  esac
done

echo "Selected video file: ${selected_video}"
ffplay "$selected_video"