#!/bin/bash
 
######################################
##                                  ##
##  vers:    1.0                    ##
##  author:  Dwoud                  ##
##                                  ##
##  useage： Update Python to 3.7   ##
##                                  ##
######################################
 
#定义颜色输出
Color_Text() {
  echo -e " \e[0;$2m$1\e[0m"
}
 
Echo_Red() {
  ")
}
 
Echo_Green() {
  ")
}
 
Echo_Yellow() {
  ")
}
 
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
        Echo_Red "该服务器无法连网，请配置服务器网络！"
        exit
    fi
 
}
 
# 升级 Python
PYTHON_UPDATE() {
 
    # 检查网络
    NETWORK_CHECK
 
    # 安装依赖
    Echo_Green '安装依赖：'
    yum -y install zlib-devel bzip2-devel wget openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make
 
    # 检查 Python 版本
    Echo_Green '当前版本 Python:'
    Echo_Yellow "==========================================================================="
    /usr/bin/python -V
    Echo_Yellow "==========================================================================="
 
    # 确认升级
    read -p "是否继续升级 Python [y/n]：" Chose_Number
    case ${Chose_Number} in
        [yY][eE][sS]|[yY])
            Echo_Yellow "你选择的是yes，升级继续进行..."
        ;;
        [nN][oO]|[nN])
            Echo_Yellow "你选择的是yes，升级即将终止..."
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
        Echo_Yellow "开始从网上下载 ${Python_Package}..."
        wget ${Python_Url}
         ];then
            Echo_Red "网上下载 ${Python_Package} 失败，请检查！"
            exit
        fi
        Echo_Yellow "${Python_Package} 下载成功，即将开始升级..."
    fi
 
    # 解压安装
    Echo_Yellow "开始解压 Python ..."
    tar -zxf ${Python_Package} && cd Python-${Python_Version}
 
     ];then
        Echo_Red "${Python_Package} 解压失败，请检查！"
        exit
    fi
 
    Echo_Yellow "开始配置 Python ..."
    ./configure --prefix=${Python_Install_Dir} --enable-shared CFLAGS=-fPIC
 
     ];then
        Echo_Red "${Python_Package} 解压失败，请检查！"
        exit
    fi
 
    Echo_Yellow "开始编译 Python ..."
 
     ];then
        Echo_Red "${Python_Package} 编译失败，请检查！"
        exit
    fi
 
    Echo_Yellow "开始安装 Python ..."
    make install
 
     ];then
        Echo_Red "${Python_Package} 安装失败，请检查！"
        exit
    fi
 
    # # 配置环境变量
    # Echo_Yellow "修改环境变量 ..."
    # echo "export PATH=\$PATH:${Python_Install_Dir}/bin" >>/etc/profile
 
    # 修改原有的 Python 为新的
    Echo_Yellow "替换旧版 Python ..."
    mv /usr/bin/python /tmp
    ln -s ${Python_Install_Dir}/bin/python3 /usr/bin/python
 
    # # 修改库文件
    # Echo_Yellow "修改 Python 库文件 ..."
    # ldd ${Python_Install_Dir}/bin/python3
    # cp ${Python_Install_Dir}/lib/libpython3.5m.so.1.0 /lib64/
 
    # 修改 yum 配置
    Echo_Yellow "修改 yum 文件 ..."
    sed -i "s#/usr/bin/python#/usr/bin/python2.7#g" /usr/bin/yum
 
    # 使配置生效
    source /etc/profile
 
    # 查看升级后版本
    Echo_Green '当前版本 Python（建议手动执行：source /etc/profile）:'
    Echo_Yellow "==========================================================================="
    /usr/bin/python -V
    Echo_Yellow "==========================================================================="
}
 
# 输出安装信息
Echo_Yellow "==========================================================================="
Echo_Green ''
Echo_Green '版本：1.0'
Echo_Green 'Dwoud'
Echo_Green '日期：20181102'
Echo_Green '备注：详情可以联系QQ：1406235107'
Echo_Green ''
Echo_Yellow "==========================================================================="
Echo_Green ''
Echo_Yellow '升级即将开始...'
Echo_Green ''
 
# 升级
PYTHON_UPDATE
