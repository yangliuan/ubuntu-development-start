#!/bin/bash
# ffmpeg -version
# sleep 5

# 视频格式扩展名数组
video_formats=("mp4" "avi" "mkv" "mov" "wmv" "flv" "3gp" "mpeg" "ogv" "vob" "dv" "yuv" "rm" "rmvb")

# 搜索视频文件并将第一个结果保存到变量中
video_file=""
for format in "${video_formats[@]}"; do
    video_file=$(find /home -type f -iname "*.$format" -print -quit)
    if [ -n "$video_file" ]; then
        break
    fi
done

# 检查是否找到视频文件
if [ -z "$video_file" ]; then
    echo "未找到视频文件"
    exit 1
fi

# 使用ffplay播放视频文件
ffplay "$video_file"

sleep 10