# 更新日志

[README](README.md)

## V 0.5.2

+ 输出程序设置图标
+ 搜索框增加关键字建议下拉框
  + 关键字建议点击跳转浏览器搜索
  + 关键字建议随主题修改颜色
+ 监听按键设置界面优化
  + 拖动条更换为官方组件
  + 拖动条增加对齐效果
  + 拖动条增加步长
  + 时间下限设置为1s
  + 颜色修改仅保留文字输入
  + 增加预览颜色框点击修改颜色
  + 修改布局
+ 更新github主页链接
+ 修复特殊情况下右键移动位置异常bug
+ 修改点击空白处逻辑

## V 0.5.1

+ 折叠浮窗增加右键移动功能并保存当前位置
+ 增加搜索框
  + 打开默认浏览器使用bing搜索
  + 鼠标悬浮展开输入框
  + 点击空白处折叠输入框
  + 随主题修改颜色
+ 主题设置页面封装成单独qml
+ 侧边栏优化
  + 增加鼠标进入展开和离开收缩功能
  + 侧边栏移动到屏幕左侧
  + 侧边栏添加背景颜色并加深高亮

## V 0.4.1

+ 修改缓存工具逻辑，提高扩展性
+ 优化qml中存储缓存的逻辑
+ 监听按键设置缓存名字修改
+ 删除设置页面
+ 增添全屏桌面
  + 展开和收缩窗口
  + 将设置页面内容移植到全屏桌面中
  + 移除半透明和模糊效果
  + 删除侧边栏背景颜色
  + 主题缓存于qml中操作
  + 布局修改
  + 将一些自定义组件更换为QT官方组件
  + 将页面和侧边栏封装
  + 点击空白处关闭页面

## V 0.3.1

+ 增加皮肤设置页面
  + 设置背景渐变颜色
  + 当前选择高亮
  + 皮肤跟随主题修改
  + 增加缓存功能

## V 0.2.3

+ 修复窗口隐藏后再显示丢失模糊效果的BUG
+ 修改窗口样式及布局
  + 主窗口只保留qucikwidget组件
  + 修改qss背景渐变
  + quickwidget优化透明背景
  + 窗口移除圆角
+ 侧边栏修改
  + 左侧侧边栏修改至顶部
  + 侧边栏添加关闭按钮
  + 侧边栏布局修改
  + 侧边栏添加主题切换
+ 优化网络调试助手
  + 增加异常日志的输出
  + 输入框统一为透明
+ 优化本地缓存工具

## V 0.2.2

+ 添加本地缓存功能
  + 缓存默认值备份
  + 设置页面的数据缓存（颜色、时间、位置）
  + 网络助手的IP地址和端口存储
+ 网络调试助手优化
  + 历史记录加上清空按钮

## V 0.2.1

+ 图标资源文件更替
+ 窗口毛玻璃效果
+ 设置任务栏标题
+ 双击托盘图标显示窗口
+ 创建主界面并包含其余封装界面
+ 主界面添加侧边栏和界面切换
+ 添加B站主页和Github主页跳转按钮
+ 增加网络调试助手页面
  + 切换服务器和客户端类型
  + 修改IP和端口
  + 发送消息和接受消息

## V 0.1.3

+ 监听按键设置界面优化
  + 设置界面数值初始化
  + 背景、按键、文字样式独立设置
  + 加入设置停留时长
  + 加入重置功能
  + 加入显示位置设置

## V 0.1.2

+ 增加监听和显示双符号按键
+ 将0-9设置为双符号按键
+ 监听界面优化
  + 定时显示监听到的多个按键
  + 根据显示个数动态修改界面
+ 实现设置监听按键的界面
  + 创建和销毁显示监听窗口
  + 实时修改监听界面的颜色
  + 添加预览效果
+ qss单独存放文件

## V 0.1.1

+ 实现全局监听按键和部分按键编码的识别
+ 实现QML界面的动态创建和删除
+ 主界面的无边框窗口初始化
+ 系统托盘初始化
