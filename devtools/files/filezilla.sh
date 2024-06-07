#!/bin/bash
Install_FileZilla_old() {
    pushd ${ubdevenv_dir}/src/devtools > /dev/null
    echo "Download filezilla ftp client ..."
    src_url="http://mirror.yangliuan.cn/FileZilla_${filezilla_ver}_x86_64-linux-gnu.tar.bz2" && Download_src
    tar -jxvf FileZilla_${filezilla_ver}_x86_64-linux-gnu.tar.bz2
    mv -fv FileZilla3 /opt/filezilla3
    cp -rfv ${ubdevenv_dir}/desktop/filezilla3.desktop /usr/share/applications/
    chown -Rv ${run_user}:${run_group} /usr/share/applications/filezilla3.desktop
    chown -Rv ${run_user}:${run_group} /opt/filezilla3
    chmod -Rv 755 /opt/filezilla3
    #rm -rfv FileZilla_${filezilla_ver}_x86_64-linux-gnu.tar.bz2
    popd > /dev/null
}

Install_FileZilla() {
    pushd ${ubdevenv_dir}/src/devtools > /dev/null
    # Define the URL to fetch
    URL="https://filezilla-project.org/download.php?type=client"
    # Fetch the content of the page with appropriate headers
    PAGE_CONTENT=$(curl -s $URL \
    -H "authority: filezilla-project.org" \
    -H "method: GET" \
    -H "path: /download.php?type=client" \
    -H "scheme: https" \
    -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "Accept-Language: zh-CN,zh;q=0.9,en;q=0.8" \
    -H "Cache-Control: max-age=0" \
    -H "Dnt: 1" \
    -H "Priority: u=0, i" \
    -H "Referer: https://filezilla-project.org/" \
    -H "Sec-Ch-Ua: \"Google Chrome\";v=\"125\", \"Chromium\";v=\"125\", \"Not.A/Brand\";v=\"24\"" \
    -H "Sec-Ch-Ua-Mobile: ?0" \
    -H "Sec-Ch-Ua-Platform: \"Linux\"" \
    -H "Sec-Fetch-Dest: document" \
    -H "Sec-Fetch-Mode: navigate" \
    -H "Sec-Fetch-Site: same-origin" \
    -H "Sec-Fetch-User: ?1" \
    -H "Upgrade-Insecure-Requests: 1" \
    -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36" | tr -d '\0')

    # Extract the download link using grep and sed
    DOWNLOAD_URL=$(echo "$PAGE_CONTENT" | grep -oP '(?<=<a id="quickdownloadbuttonlink" href=")[^"]+')

    # Check if the download link was found
    if [ -n "$DOWNLOAD_URL" ]; then
        echo "Download URL: $DOWNLOAD_URL"
    else
        echo "Download link not found."
    fi

    popd > /dev/null
}

Uninstall_FileZilla() {
    rm -rfv /opt/filezilla3
    rm -rfv /usr/share/applications/filezilla3.desktop
}