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
wget https://github.com/protocolbuffers/protobuf/releases/download/v21.4/protoc-21.4-linux-x86_64.zip
unzip protoc-21.4-linux-x86_64.zip -d $HOME/protoc
export PATH=$HOME/protoc/bin:$PATH
protoc --version

# 请求用户输入Prover ID并保存
echo "请输入Prover ID："
read PROVER_ID
mkdir -p ~/.nexus
echo "$PROVER_ID" > ~/.nexus/prover-id

# 安装Nexus CLI
echo "正在安装Nexus CLI..."
curl https://cli.nexus.xyz/ | sh
