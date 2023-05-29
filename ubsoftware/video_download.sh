#!/bin/bash
#https://github.com/BilibiliVideoDownload/BilibiliVideoDownload
Install_BilbiliDownloader() {
    pushd ${start_dir}/src > /dev/null
    src_url="https://github.com/BilibiliVideoDownload/BilibiliVideoDownload/releases/download/v${bilibili_video_downloader_ver}/BilibiliVideoDownload-${bilibili_video_downloader_ver}.AppImage" && Download_src
    [ ! -d "/opt/bilibilivideo-downloader" ] && mkdir /opt/bilibilivideo-downloader
    cp -rfv BilibiliVideoDownload-${bilibili_video_downloader_ver}.AppImage /opt/bilibilivideo-downloader/bvdownloader.AppImage
    cp -rfv ${start_dir}/icon/bvdownloader.png /opt/bilibilivideo-downloader
    chmod -Rv 755 /opt/bilibilivideo-downloader/bvdownloader.AppImage
    cp -rfv ${start_dir}/desktop/bilibilivideo-downloader.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /opt/bilibilivideo-downloader/ /usr/share/applications//bilibilivideo-downloader.desktop
    popd > /dev/null
}

Uninstall_BilbiliDownloader() {
    rm -rv /opt/bilibilivideo-downloader /usr/share/applications//bilibilivideo-downloader.desktop
}