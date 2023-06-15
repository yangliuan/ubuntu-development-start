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
(Enter) use ffplay play video
(0) best compression and conversion to mp4
(1) extract mp3 and mp4(without auido)
(2) extract cover image
(3) decode the video into the original frame sequence image
(4) add image(fix) watermark
(5) remove image(fix) watermark
(6) remove the orignal sound of video
(7) add background music (keep original sound)
(8) horizontal flip
(9) frame reversal by filter
(a) frame reversal by frame image
(b) generating multi-resolution videos
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
      selected_video=${video_files[$index]}
      currently_directory=$(dirname "$selected_video")  # 提取路径部分
      file_name=$(basename "$selected_video")  # 提取文件名（包含扩展名）
      file_name_without_ext="${file_name%.*}"  # 去除扩展名
      out_file_name="${file_name_without_ext}.mp4"  # 构建新的文件名
      out_file_path="$currently_directory/add_background_music_$out_file_name"  # 构建完整的新路径
      audio_directory="$HOME/Music"
      #搜索audio_directory目录中的mp3格式文件放保存到数组中，循环打印出来，要包含数组下标
      #通过read读取输入的数组下标，匹配到音频文件完整路径并将音频完整路径保存到变量中
      audio_files=($(find "$audio_directory" -name "*.mp3"))  # 搜索音频文件并保存到数组中
      for i in "${!audio_files[@]}"; do  # 循环打印数组元素及其下标
          echo "[$i] ${audio_files[$i]}"
      done
      while :; do echo
        read -p "请输入音频选项对应的数字：" audio_index  # 读取输入的数组下标
        if ! [[ "$audio_index" =~ ^[0-9]+$ ]]; then  # 使用正则表达式匹配数字
          echo "警告：输入必须为数字！"
        else
          break
        fi
      done
      selected_audio=${audio_files[$audio_index]}  # 匹配选中的音频文件
      echo "您选择的音频文件为: $selected_audio"  # 输出选中的音频文件路径
      ffmpeg -i "$selected_audio" -i "$selected_video" -threads 2 -filter_complex amix=inputs=2:duration=first:dropout_transition=0 "$out_file_path"
      break;
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
    "a")
      selected_video=${video_files[$index]}
      currently_directory=$(dirname "$selected_video")  # 提取路径部分
      file_name=$(basename "$selected_video")  # 提取文件名（包含扩展名）
      file_name_without_ext="${file_name%.*}"  # 去除扩展名
      out_file_name="${file_name_without_ext}.mp4"  # 构建新的文件名
      out_file_path="$currently_directory/reversed_frames2_$out_file_name"  # 构建完整的新路径
      #反转音频时间顺序，并提取为mp3
      ffmpeg -i $selected_video -af areverse -f mp3 $currently_directory/reversed_audio_$file_name_without_ext.mp3
      input_dir="$currently_directory/frames"
      output_dir="$currently_directory/reversed_frames"
      mkdir -p $input_dir $output_dir
      ffmpeg -i $selected_video -qscale:v 2 $input_dir/%05d.jpg
      files=$(ls "$input_dir")
      reversed_files=()
      index=1
      for file in $files; do
          reversed_files[$index]=$file
          ((index++))
      done
      reversed_files=("${reversed_files[@]}")
      reversed_files=($(echo "${reversed_files[@]}" | tr ' ' '\n' | sort -r))
      index=1
      for file in "${reversed_files[@]}"; do
          cp "$input_dir/$file" "$output_dir/$(printf "%05d" $index).jpg"
          ((index++))
      done
      ffmpeg -f image2 -i $output_dir/%05d.jpg "$currently_directory/reversed_video_$out_file_name"
      ffmpeg -i $currently_directory/reversed_audio_$file_name_without_ext.mp3 -i "$currently_directory/reversed_video_$out_file_name" $out_file_path
      ;;
    "b")
      selected_video=${video_files[$index]}
      currently_directory=$(dirname "$selected_video")  # 提取路径部分
      file_name=$(basename "$selected_video")  # 提取文件名（包含扩展名）
      file_name_without_ext="${file_name%.*}"  # 去除扩展名
      out_file_name="${file_name_without_ext}.mp4"  # 构建新的文件名
      # 获取原始视频分辨率信息
      resolution=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$selected_video")
      width=$(echo $resolution | cut -d'x' -f1)
      height=$(echo $resolution | cut -d'x' -f2)
      # 定义目标分辨率列表
      target_resolutions=("3840x2160" "2560x1440" "1920x1080" "1280x720" "854x480" "640x360")
      # 根据目标分辨率生成对应的目标视频
      for res in "${target_resolutions[@]}"
      do
      target_width=$(echo $res | cut -d'x' -f1)
      target_height=$(echo $res | cut -d'x' -f2)
      # 如果目标分辨率大于原始分辨率，则跳过生成该目标视频
      if (( target_width > width || target_height > height )); then
        continue
      fi
      # 构建输出文件名，包含目标分辨率信息
      target_file_name="${file_name_without_ext}_${target_width}x${target_height}.mp4"
      # 使用ffmpeg生成目标视频
      ffmpeg -i "$selected_video" -vf "scale=$target_width:$target_height" -c:a copy "$currently_directory/$target_file_name"
      done
      echo "All target videos have been generated successfully!"
      ;;
  esac
done

