#!/bin/bash

# --- 配置 ---
# 将 APK 文件所在的目录路径告诉脚本
APK_DIRECTORY="./tool_apks"

# --- 脚本正文 ---
echo ">> 正在等待模拟器连接..."

# 等待模拟器准备就绪。ADB 可能需要几秒钟才能识别到设备。
# 我们将循环等待，直到 adb devices 列出一个 "device"
until adb shell getprop sys.boot_completed | grep -m 1 "1"; do
    sleep 1
done

echo "✅ 模拟器已连接并启动完成！"
echo ">> 开始安装依赖应用..."

# 检查 APK 目录是否存在
if [ ! -d "$APK_DIRECTORY" ]; then
    echo "错误: 目录 '$APK_DIRECTORY' 未找到。"
    exit 1
fi

# 遍历目录中所有的 .apk 文件并安装它们
for apk_file in "$APK_DIRECTORY"/*.apk; do
    if [ -f "$apk_file" ]; then
        echo "   -> 正在安装: $apk_file"
        # 使用 adb install 命令进行安装
        # -r 选项表示如果已安装则重新安装
        # -g 选项表示自动授予所有运行时权限（开发时非常有用）
        adb install -r -g "$apk_file"
    fi
done

echo "✅ 所有依赖应用安装完成！"