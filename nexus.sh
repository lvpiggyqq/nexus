#!/bin/bash

# 检测是否安装了Rust和Cargo
if ! command -v rustc &> /dev/null || ! command -v cargo &> /dev/null; then
    echo "未找到Rust或Cargo。正在安装Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -1
    source "$HOME/.cargo/env"
else
    echo "Rust和Cargo已经安装。"
fi

# 安装protobuf编译器
echo "正在安装protobuf编译器..."
sudo apt update
sudo apt install -y protobuf-compiler
sudo apt install -y libssl-dev
sudo apt install -y pkg-config

# 请求用户输入Prover ID并保存
echo "请输入Prover ID："
read PROVER_ID
mkdir -p ~/.nexus
echo "$PROVER_ID" > ~/.nexus/prover-id

# 安装Nexus CLI（后台运行）
echo "正在安装Nexus CLI..."
nohup curl https://cli.nexus.xyz/ | sh > nexus_install.log 2>&1 &

echo "Nexus CLI 正在后台安装。您可以通过查看 nexus_install.log 文件检查安装进度。"
