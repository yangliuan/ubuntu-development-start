#!/usr/bin/env php
<?php
$url = "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64";
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
// 不需要页面内容
curl_setopt($ch, CURLOPT_NOBODY, 1);
// 不直接输出
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
// 返回最后的Location
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
curl_exec($ch);
$info = curl_getinfo($ch,CURLINFO_EFFECTIVE_URL);
curl_close($ch);
echo $info;