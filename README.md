# InterestingScripts

## [一键安装Shadowsocks Server脚本](https://github.com/ahtcfg24/ProgramDemos/blob/master/shell/ssserver-install.sh)
* 适用系统：CentOS7
* 准备工作：一台安装了CentOS的虚拟机，复制脚本到虚拟机上，脚本授予755及以上权限
* 使用方法：./ssserver-install.sh 你想设置的密码 你想开启的端口
例如希望设置密码为：ABC123，开启端口：39
> ./ssserver-install.sh ABC123 39

* 其它说明：
1. 如果密码包含shell不能识别的字符需要在前面加上 \ 进行转义，不输入任何参数则使用默认密码abcd1234 默认端口38
2. 脚本执行成功后会自动安装python环境、安装shadowsock程序、以守护进程方式运行shadowsocks、开启防火墙指定端口，详情见脚本代码
