#!/bin/bash
clear
if ! command -v ffmpeg > /dev/null; then
  echo "FFmpeg is not installed"
  exit 1
fi

echo "start search videos..."
directory="$HOME/Videos"
[ ! -d "${directory}" ] && { echo "No such directory: Videos" ; exit 1; }  
video_formats=("mp4" "avi" "mkv" "mov" "wmv" "flv" "3gp" "mpeg" "ogv" "vob" "dv" "yuv" "rm" "rmvb")

video_files=()
for format in "${video_formats[@]}"; do
  video_files+=($(find "$directory" -type f -name "*.$format" -exec realpath {} \; 2>/dev/null))
done

if [ ${#video_files[@]} -eq 0 ]; then
  echo "Not found video files."
  sleep 3
  exit 1
fi

video_files=($(echo "${video_files[@]}" | tr ' ' '\n' | sort -u))
index=0

while true; do
  clear
  printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                 FFmpeg Tools                                 #
################################################################################
Press key:
(Enter) use ffplay play video. ffplay keyboard: q exit the currently playing video; [ space ] pause/play video; ← rewind the video; → fast forward videos; ↑ adjust the volume level; ↓ adjust the volume level
(0) best compression and conversion to mp4
(1) extract mp3 and mp4(without auido)
(2) extract cover image
(3) decode the video into the original frame sequence image
(4) add image(fix) watermark
(5) remove image(fix) watermark
(6) remove the orignal sound of video
(7) add sound (keep original sound)
(8) horizontal flip
(9) frame reversal by filter
(10) frame reversal by frame image
"

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
      ffplay "$selected_video"
      break;
      ;;
    "0")
      selected_video=${video_files[$index]}
      currently_directory=$(dirname "$selected_video")  # 提取路径部分
      file_name=$(basename "$selected_video")  # 提取文件名（包含扩展名）
      file_name_without_ext="${file_name%.*}"  # 去除扩展名
      out_file_name="${file_name_without_ext}.mp4"  # 构建新的文件名
      out_file_path="$currently_directory/compress_$out_file_name"  # 构建完整的新路径
      ffmpeg -i "$selected_video" -c:v libx264 -preset medium -crf 28 -c:a copy "$out_file_path"
      ;;
    "1")
      selected_video=${video_files[$index]}
      currently_directory=$(dirname "$selected_video")
      file_name=$(basename "$selected_video")  # 提取文件名（包含扩展名）
      file_name_without_ext="${file_name%.*}"  # 去除扩展名  
      # 构建输出文件路径和文件名
      output_file_audio="$currently_directory/audio_stream_$file_name_without_ext.mp3"
      output_file_video="$currently_directory/video_stream_$file_name_without_ext.mp4"
      ffmpeg -i "$selected_video" -f mp3 "$output_file_audio"
      ffmpeg -i "$selected_video" -vcodec copy -an "$output_file_video"
      ;;
    "2")
      selected_video=${video_files[$index]}
      # 获取文件名和扩展名
      filename=$(basename "$selected_video")
      extension="${filename##*.}"
      # 构建输出文件路径和文件名
      output_file=${selected_video/${extension}/jpg}
      ffmpeg -i "$selected_video" -vframes 1 -q:v 2 "$output_file"
      ;;
    "3")
      selected_video=${video_files[$index]}
      currently_directory=$(dirname "$selected_video")  # 提取路径部分
      file_name=$(basename "$selected_video")  # 提取文件名（包含扩展名）
      file_name_without_ext="${file_name%.*}"  # 去除扩展名  
      frame_img_dir=$currently_directory/$file_name_without_ext
      [ ! -d "$frame_img_dir" ] && mkdir -p $frame_img_dir
      ffmpeg -i $selected_video -qscale:v 2 $frame_img_dir/%05d.jpg
      ;;
    "4")
      watermark_img='/home/yangliuan/Pictures/Wallpapers/ubuntu-logo.png'
      selected_video=${video_files[$index]}
      currently_directory=$(dirname "$selected_video")  # 提取路径部分
      file_name=$(basename "$selected_video")  # 提取文件名（包含扩展名）
      file_name_without_ext="${file_name%.*}"  # 去除扩展名
      out_file_name="${file_name_without_ext}.mp4"  # 构建新的文件名
      out_file_path="$currently_directory/watermark_$out_file_name"  # 构建完整的新路径
      ffmpeg -i $selected_video -vf "movie=${watermark_img} [watermark]; [in][watermark] overlay=50:50 [out]" -y $out_file_path
      ;;
    "5")
      selected_video=${video_files[$index]}
      currently_directory=$(dirname "$selected_video")  # 提取路径部分
      file_name=$(basename "$selected_video")  # 提取文件名（包含扩展名）
      file_name_without_ext="${file_name%.*}"  # 去除扩展名
      out_file_name="${file_name_without_ext}.mp4"  # 构建新的文件名
      out_file_path="$currently_directory/remove_watermark_$out_file_name"  # 构建完整的新路径
      ffmpeg -i $selected_video -vf "delogo=x=50:y=50:w=499:h=410" -c:a copy $out_file_path
      ;;
    "6")
      selected_video=${video_files[$index]}
      currently_directory=$(dirname "$selected_video")  # 提取路径部分
      file_name=$(basename "$selected_video")  # 提取文件名（包含扩展名）
      file_name_without_ext="${file_name%.*}"  # 去除扩展名
      out_file_name="${file_name_without_ext}.mp4"  # 构建新的文件名
      out_file_path="$currently_directory/remove_sound_$out_file_name"  # 构建完整的新路径
      ffmpeg -i $selected_video -an $out_file_path -y
      ;;
    "7")
      ;;
    "8")
      selected_video=${video_files[$index]}
      currently_directory=$(dirname "$selected_video")  # 提取路径部分
      file_name=$(basename "$selected_video")  # 提取文件名（包含扩展名）
      file_name_without_ext="${file_name%.*}"  # 去除扩展名
      out_file_name="${file_name_without_ext}.mp4"  # 构建新的文件名
      out_file_path="$currently_directory/flip_horizontal_$out_file_name"  # 构建完整的新路径
      ffmpeg -i $selected_video -vf "hflip" $out_file_path
      ;;
    "9")
      selected_video=${video_files[$index]}
      currently_directory=$(dirname "$selected_video")  # 提取路径部分
      file_name=$(basename "$selected_video")  # 提取文件名（包含扩展名）
      file_name_without_ext="${file_name%.*}"  # 去除扩展名
      out_file_name="${file_name_without_ext}.mp4"  # 构建新的文件名
      out_file_path="$currently_directory/reversed_frames_$out_file_name"  # 构建完整的新路径
      ffmpeg -i $selected_video -vf reverse -af areverse  $out_file_path
      ;;
    "10")
      selected_video=${video_files[$index]}
      currently_directory=$(dirname "$selected_video")  # 提取路径部分
      file_name=$(basename "$selected_video")  # 提取文件名（包含扩展名）
      file_name_without_ext="${file_name%.*}"  # 去除扩展名
      out_file_name="${file_name_without_ext}.mp4"  # 构建新的文件名
      out_file_path="$currently_directory/reversed_frames2_$out_file_name"  # 构建完整的新路径
      ffmpeg -i $selected_video -vf reverse -af areverse  $out_file_path
      ;;
  esac
done

