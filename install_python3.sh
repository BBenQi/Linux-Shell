#!/bin/bash
 
######################################
##                                  ##
##  vers:    1.0                    ##
##  author:  Dwoud                  ##
##                                  ##
##  useage： Update Python to 3.7   ##
##                                  ##
######################################
 

 
# Python 版本
Python_Version='3.7.1'
 
# Python 安装包
Python_Package="Python-${Python_Version}.tgz"
 
# Python 下载地址
Python_Url="http://mirrors.sohu.com/python/${Python_Version}/${Python_Package}"
 
# 包存放地址
Package_Dir=$(pwd)
 
# 安装目录
Python_Install_Dir="/usr/local/python-${Python_Version}"
 
# 网络检查
NETWORK_CHECK() {
 
    # 检查联网情况
 
     ];then
        echo "该服务器无法连网，请配置服务器网络！"
        exit
    fi
 
}
 
# 升级 Python
PYTHON_UPDATE() {
 
    # 检查网络
    NETWORK_CHECK
 
    # 安装依赖
    echo '安装依赖：'
    yum -y install zlib-devel bzip2-devel wget openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make
 
    # 检查 Python 版本
    echo '当前版本 Python:'
    echo "==========================================================================="
    /usr/bin/python -V
    echo "==========================================================================="
 
    # 确认升级
    read -p "是否继续升级 Python [y/n]：" Chose_Number
    case ${Chose_Number} in
        [yY][eE][sS]|[yY])
            echo "你选择的是yes，升级继续进行..."
        ;;
        [nN][oO]|[nN])
            echo "你选择的是yes，升级即将终止..."
            exit
        ;;
        *)
            Echo_Red "输入错误，即将退出升级..."
            exit
    esac
 
    # 检测包是否存在
    ls -l ${Package_Dir}/${Python_Package}
 
     ];then
        # 下载安装包
        echo "开始从网上下载 ${Python_Package}..."
        wget ${Python_Url}
         ];then
            Echo_Red "网上下载 ${Python_Package} 失败，请检查！"
            exit
        fi
        echo "${Python_Package} 下载成功，即将开始升级..."
    fi
 
    # 解压安装
    echo "开始解压 Python ..."
    tar -zxf ${Python_Package} && cd Python-${Python_Version}
 
     ];then
        Echo_Red "${Python_Package} 解压失败，请检查！"
        exit
    fi
 
    echo "开始配置 Python ..."
    ./configure --prefix=${Python_Install_Dir} --enable-shared CFLAGS=-fPIC
 
     ];then
        Echo_Red "${Python_Package} 解压失败，请检查！"
        exit
    fi
 
    echo "开始编译 Python ..."
 
     ];then
        Echo_Red "${Python_Package} 编译失败，请检查！"
        exit
    fi
 
    echo "开始安装 Python ..."
    make install
 
     ];then
        Echo_Red "${Python_Package} 安装失败，请检查！"
        exit
    fi
 
    # # 配置环境变量
    # echo "修改环境变量 ..."
    # echo "export PATH=\$PATH:${Python_Install_Dir}/bin" >>/etc/profile
 
    # 修改原有的 Python 为新的
    echo "替换旧版 Python ..."
    mv /usr/bin/python /tmp
    ln -s ${Python_Install_Dir}/bin/python3 /usr/bin/python
 
    # # 修改库文件
    # echo "修改 Python 库文件 ..."
    # ldd ${Python_Install_Dir}/bin/python3
    # cp ${Python_Install_Dir}/lib/libpython3.5m.so.1.0 /lib64/
 
    # 修改 yum 配置
    echo "修改 yum 文件 ..."
    sed -i "s#/usr/bin/python#/usr/bin/python2.7#g" /usr/bin/yum
 
    # 使配置生效
    source /etc/profile
 
    # 查看升级后版本
    echo '当前版本 Python（建议手动执行：source /etc/profile）:'
    echo "==========================================================================="
    /usr/bin/python -V
    echo "==========================================================================="
}
 
# 输出安装信息
echo "==========================================================================="
echo ''
echo '版本：1.0'
echo 'Dwoud'
echo '日期：20181102'
echo '备注：详情可以联系QQ：1406235107'
echo ''
echo "==========================================================================="
echo ''
echo '升级即将开始...'
echo ''
 
# 升级
PYTHON_UPDATE
