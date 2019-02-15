---
title: Cordova入门
tags: 
  - Cordova  
copyright: true
comments: true
toc: true
date: 2018-10-02 22:10:23
categories: 移动开发
password:
---

~~~
* 官网网站：http://cordova.apache.org/
* 中文文档：http://cordova.axuer.com/docs/zh-cn/latest/guide/overview/index.html
* 英文文档：http://cordova.apache.org/docs/en/latest/
~~~

# 概述
> Apache Cordova是一个开源的移动开发框架。允许你用标准的web技术-HTML5,CSS3和JavaScript做跨平台开发。 应用在每个平台的具体执行被封装了起来，并依靠符合标准的API绑定去访问每个设备的功能，比如说：传感器、数据、网络状态等

# 架构
![image](http://note.youdao.com/yws/api/personal/file/WEB7dabb8e22b881e78ccd35c9157eed9d4?method=download&shareKey=eb7b4d2c01ba8878b4a483c1becf19e1)
* WebView：Cordova启用的WebView可以给应用提供完整用户访问界面。在一些平台中，他也可以作为一个组件给大的、混合应用，这些应用混合和Webview和原生的应用组件
* Web App：这是你应用程序代码存在的地方。应用的实现是通过web页面，默认的本地文件名称是是index.html，这个本地文件应用CSS,JavaScript,图片，媒体文件和其他运行需要的资源。应用执行在原生应用包装的WebView中，这个原生应用是你分发到app stores中的；这个容器中包含一个非常重要文件- config.xml 文件他提供App的重要的信息和特定的参数用来影响App的工作
* 插件：提供了Cordova和原生组件相互通信的接口并绑定到了标准的设备API上。这使你能够通过JavaScript调用原生代码.
> 注意:当你创建一个Cordova项目它不存在任何插件。这是新的默认行为。任何你需要的组件，哪怕是核心组件，你也必须明确添加。
* 开发工作流:Cordova提供两个基本的工作流用来创建移动App.
1. 跨平台(CLI)的工作流:如果你想你的App运行在尽可能多的移动操作系统，那么就使用这个工作流，你只需要很少的特定平台开发。这个工作流围绕这'cordova'CLI(命令行)。CLI把公用的web资源复制到每个移动平台的子目录，根据每个平台做必要的配置变化，运行构建脚本生成2进制文件。一般都是使用这种方式。
2. 平台为中心的工作流:如果你专注于构建单独平台的App或者需要需要在底层修改它那么就使用这个工作流吧。

# 创建第一个App
## 安装Cordova CLI
* 下载和安装Node.js。安装完成后你可以在命令行中使用node 和 npm 
* mac上xcode开发环境已OK
* mac上Android开发环境已OK，且Android的全局变量已配置，如：ANDROID_HOME
~~~
export ANDROID_HOME=/Users/Neel/Documents/Softwares/adt-bundle-mac-x86_64-20140321/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
~~~
* sudo npm install -g cordova  //-g标志是告诉 npm 我们全局安装 cordova
* 命令行输入cordova,检验是否安装成功
~~~
CLI命令概要

Help：显示可用CLI命令的信息。
Create：创建Cordova项目并关联项目文件夹和文件。
Plateform：管理Cordova项目使用的移动平台。
Plugin：管理Cordova插件的安装和卸载。
Prepare：从Cordova项目的www文件夹复制web应用内容到项目移动平台项目文件夹中。
Compile：把web应用打包成Cordova应用。
Build：先执行Prepare命令然后打包web应用。
Emulate：在一个或多个移动设备平台的设备模拟器中运行Cordova应用。
Run：在一个或多个移动设备中运行Cordova应用。
Serve：启动一个服务器加载web内容以便于用浏览器访问
~~~

## 创建App
* 方法一：cordova create hello com.example.hello HelloWorld
* 方法二：webstorm创建
1. webstorm添加cordova支持：Settings → Plugins
2. webstorm创建项目

## 添加平台
1. 检查你当前平台设置状况:cordova platform ls，运行add或者remove平台的命令将会影响项目 platforms的内容，在这个目录中每个指定平台都有一个子目录
2. 添加Android平台支持：cordova platform add android --save
3. 添加IOS平台支持：cordova platform add ios --save
4. 添加浏览器支持：cordova platform add browser --save
5. npm install ios-sim -g //如果ios环境，可能需要添加这个

## 构建及测试
* 安装构建先决条件检查：cordova requirements
* 构建App：cordova build，构建所有平台；cordova build ios，构建特定平台
* 测试：模拟器-cordova emulate android；或者可将手机插入电脑，在手机上直接测试-cordova run android
* 说明：构建和测试也可通过webstorm直接进行
 
## 添加插件
> App要接触设备级别的特性，就需要你添加插件了.个插件 通过JavascriptAPI暴露原生SDK功能。插件通常由npm分发(http://cordova.axuer.com/plugins/),一些关键的API由Apache Cordova开源项目提供并且这些插件是作为[核心插件API]的.

* 搜索插件：cordova plugin search camera
* 查看当前安装的插件:cordova plugin ls
* 添加插件：cordova plugin add cordova-plugin-camera  //plugin要添加camera插件，我们需要指定camera的npm包名
* 添加插件：cordova plugin add https://git-wip-us.apache.org/repos/asf/cordova-plugin-camera.git

## 使用 merges自定义每个平台
> 顶级merges目录提供了特定平台部署特定资源的地方。每个特定平台在merges中的子目录反映了www 源代码树中的结构， 允许你重写和添加文件。

> 存放各个平台特殊的文件，会和www进行合并编译，相同的文件merges下的文件优先。

比如： 
~~~
merges/ 
|-- ios/ 
| `-- app.js 
|-- android/ 
| `-- android.js 
www/ 
`-- app.js
~~~
编译成iOS应用的话，包含merges/ios/app.js；而Android应用的话，包含www/app.js、merges/android/android.js 

## hooks目录
> 存放自定义cordova命令的脚本文件。每个project命令都可以定义before和after的Hook，比如：before_build、after_build。  
Hook可以采用任何编程语言来写，Cordova CLI采用的是Node.js，所以一般都是用它来写

## 更新Cordova和项目
* 要查找最新的cordova版本:npm info cordova version
* 查看当前版本:cordova -v
* 更新到最新版本:sudo npm update -g cordova
* 安装指定版本:sudo npm install -g cordova@3.1.0-0.2.0
* 更新目标项目的平台:cordova platform update android --save

# 平台开发
* 查看所有支持的模拟器：cordova run --list

## Android
* 要想知道你的Cordova项目中安装的Cordova Android包的版本，你可以在项目目录中运行cordova platform ls
* 平台搭建过程
1. 安装Java Development Kit (JDK) 7或者最新的
2. 安装Android SDK
3. 添加SDK包：
~~~
Android API级别查看：http://developer.android.com/guide/topics/manifest/uses-sdk-element.html#ApiLevels
~~~
打开Android SDK Manager (例如，在终端上运行`android)，并确保下面已经安装:

- - 目标Android版本的Android Platform SDK
- -  Android SDK build-tools，版本19.1.0或者之上
- - Android Support Repository (在"Extras"查找)
4. 设置环境变量
- - 设置JAVA_HOME环境变量，指定为JDK安装路径
- - 设置ANDROID_HOME环境变量，指定为Android SDK安装路径
- - 添加Android SDK的tools和platform-tools目录到你的PATH
5. Android Studio调试
> Cordova的Android项目可以被Android IDEAndroid Studio打开;

> 如果你想使用Android Studio内置的Android调试/分析工具或者你要开发Android插件这是十分有用的

在Android Studio中打开Cordova的Android项目:
* 启动 Android Studio.
* 选择 Import Project (Eclipse ADT, Gradle, etc).
* 选择你项目中的Android platform目录(<your-project>/platforms/android)
* 对于Gradle Sync问题你可以简单的回答 Yes.

==注意==：当在Android studio里打开你的项目，建议你不要编辑你的代码在IDE中。这会在 platforms目录中编辑你的代码(而不是 www),并且变化将会被重写。而是编辑www目录并通过运行cordova build来拷贝过来你的变化。
6. Cordova和Android的生命周期 

Cordova事件	| 粗略的Android等效	|含义
---|---|------
deviceready	|onCreate()	|应用程序开始(不是从背景)
pause|	onPause()	|应用程序移动到背景
resume|	onResume()|	应用程序返回到前景

关于生命周期：
> 在Android设备中，操作系统可以选择在后台杀死活动来释放资源，如果当前设备运行程序的内存过低。由于这个原因，你的应用程序知道生命周期被触发并维持任何确保用户在离开应用程序用户上下文不丢失的状态，是必须的。

> 应该通过bindEvents 方法来注册应用程序回调来回应生命周期事件来保存状态。保存什么息和怎么保存信息由你决定，但是你要确保保存足够的信息，来精确的恢复到用户离开的地方
~~~
// 这个状态代表了应用程序的状态并且会在onResume()和onPause()中保存和恢复
var appState = {
    takingPicture: true,
    imageUri: ""
};

var APP_STORAGE_KEY = "exampleAppState";

var app = {
    initialize: function() {
        this.bindEvents();
    },
    bindEvents: function() {
        // 这里我们注册我们关心的生命周期事件回调
        document.addEventListener('deviceready', this.onDeviceReady, false);
        document.addEventListener('pause', this.onPause, false);
        document.addEventListener('resume', this.onResume, false);
    },
    onDeviceReady: function() {
        document.getElementById("take-picture-button").addEventListener("click", function() {
            //由于camera插件方法启动了一个外部活动
            //这里有一次机会我们的应用程序被kill掉在回调被成功或者失败调用之前
            // 在onPause()和onResume()那里我们保存和恢复状态，来处理这个事情
            appState.takingPicture = true;

            navigator.camera.getPicture(cameraSuccessCallback, cameraFailureCallback,
                {
                    sourceType: Camera.PictureSourceType.CAMERA,
                    destinationType: Camera.DestinationType.FILE_URI,
                    targetWidth: 250,
                    targetHeight: 250
                }
            );
        });
    },
    onPause: function() {
        // 这里我们检测我们是否在获取图片，如果在，我们希望保存我们的状态以便onResume()
        // 恢复的时候使用，如果我们获得了图片URI我们也要存储
        if(appState.takingPicture || appState.imageUri) {
            window.localStorage.setItem(APP_STORAGE_KEY, JSON.stringify(appState));
        }
    },
    onResume: function(event) {
        // 这里我们检差存储的状态，如果需要恢复他。由你跟踪任何添加的插件结果的来源
        //  (也就是说你代码的哪一步被调用)，还有什么参数提供给插件如果相关
        var storedState = window.localStorage.getItem(APP_STORAGE_KEY);

        if(storedState) {
            appState = JSON.parse(storedState);
        }

        // 检查如果我们需要恢复我们的图片
        if(!appState.takingPicture && appState.imageUri) {
            document.getElementById("get-picture-result").src = appState.imageUri;
        }
        // 现在我们可以检测如果插件结果在事件对象里面
        // 这里需要cordova-android 5.1.0+
        else if(appState.takingPicture && event.pendingResult) {
            // 检测插件调用是否成功并调用相应的回调。对于camera插件，"OK"
            //意味着成功其他意味着错误
            if(event.pendingResult.pluginStatus === "OK") {
                // camera放置同样的结果在resume对象，因为成功回调传递给了getPicture(),
                // 因此我们可以传递同样的回调，返回一些其他东西。查询文档，了解怎么解释你使用
                // 插件的结果字段
                cameraSuccessCallback(event.pendingResult.result);
            } else {
                cameraFailureCallback(event.pendingResult.result);
            }
        }
    }
}

// 这里是回调我们传入getPicture()
function cameraSuccessCallback(imageUri) {
    appState.takingPicture = false;
    appState.imageUri = imageUri;
    document.getElementById("get-picture-result").src = imageUri;
}

function cameraFailureCallback(error) {
    appState.takingPicture = false;
    console.log(error);
}

app.initialize();
~~~

# 自定义图标(Icon)
> 对启动画面(splash screen)的支持已经被移动到Cordova自己的插件中了，http://cordova.axuer.com/docs/zh-cn/latest/reference/cordova-plugin-splashscreen/

> 当工作在CLI工作流中，你可以通过<icon>元素(config.xml)定义你的app图标。如果没用指定图标将使用ApacheCordova的logo.

属性 |	描述
-----|-----
src	|必要 图片文件位置，相对于项目根路径
platform|	可选 目标平台
width|	可选 图片的像素宽度
height|	可选 图片的像素高度
density|	可选 
Android |指定图标密度
target|	可选 
Windows |图片文件和所有多渲染目标(MRT)伙伴的目标文件名
~~~
<icon src="res/icon.png" />     //用来定义用于所有平台的唯一默认图标
~~~

Android
~~~
<platform name="android">
        <!--
            ldpi    : 36x36 px
            mdpi    : 48x48 px
            hdpi    : 72x72 px
            xhdpi   : 96x96 px
            xxhdpi  : 144x144 px
            xxxhdpi : 192x192 px
        -->
        <icon src="res/android/ldpi.png" density="ldpi" />
        <icon src="res/android/mdpi.png" density="mdpi" />
        <icon src="res/android/hdpi.png" density="hdpi" />
        <icon src="res/android/xhdpi.png" density="xhdpi" />
        <icon src="res/android/xxhdpi.png" density="xxhdpi" />
        <icon src="res/android/xxxhdpi.png" density="xxxhdpi" />
    </platform>
~~~
IOS
~~~
<platform name="ios">
        <!-- iOS 8.0+ -->
        <!-- iPhone 6 Plus  -->
        <icon src="res/ios/icon-60@3x.png" width="180" height="180" />
        <!-- iOS 7.0+ -->
        <!-- iPhone / iPod Touch  -->
        <icon src="res/ios/icon-60.png" width="60" height="60" />
        <icon src="res/ios/icon-60@2x.png" width="120" height="120" />
        <!-- iPad -->
        <icon src="res/ios/icon-76.png" width="76" height="76" />
        <icon src="res/ios/icon-76@2x.png" width="152" height="152" />
        <!-- iOS 6.1 -->
        <!-- Spotlight Icon -->
        <icon src="res/ios/icon-40.png" width="40" height="40" />
        <icon src="res/ios/icon-40@2x.png" width="80" height="80" />
        <!-- iPhone / iPod Touch -->
        <icon src="res/ios/icon.png" width="57" height="57" />
        <icon src="res/ios/icon@2x.png" width="114" height="114" />
        <!-- iPad -->
        <icon src="res/ios/icon-72.png" width="72" height="72" />
        <icon src="res/ios/icon-72@2x.png" width="144" height="144" />
        <!-- iPhone Spotlight and Settings Icon -->
        <icon src="res/ios/icon-small.png" width="29" height="29" />
        <icon src="res/ios/icon-small@2x.png" width="58" height="58" />
        <!-- iPad Spotlight and Settings Icon -->
        <icon src="res/ios/icon-50.png" width="50" height="50" />
        <icon src="res/ios/icon-50@2x.png" width="100" height="100" />
    </platform>
~~~

# 存储数据
## LocalStorage
> LocalStorage提供了简单和同步的键值对存储方式，而且在各个Cordova平台，底层的WebView实现都支持它。

> LocalStorage可以通过window.localStorage访问到。以下的代码片段展示了返回的storage对象的最重要的几个方法。
~~~
var storage = window.localStorage;
var value = storage.getItem(key); // 传递键的名字获取对应的值。
storage.setItem(key, value) // 传递键的名字和对应的值去添加或者更新这个键值对。
storage.removeItem(key) // 传递键的名字去从LocalStorage里删除这个键值对。
~~~

## SQLite 插件
* cordova-sqlite-storage - 包含sqlite3实现的核心版本，它支持iOS, Android和Windows平台。
* cordova-sqlite-ext - 包含Android和iOS的正则支持等额外特性的扩展版本。
* cordova-sqlite-evfree - 与cordova-sqlite-ext类似，但提供了高级的内存管理。GPL版本低于v3或者有商业许可的话可用。

# 安全管理建议
* 使用app内置浏览器打开外链：因为app内置浏览器会使用原生浏览器的安全特性，而且不会让你的Cordova环境被外部访问到
* 校验所有的用户输入，服务端同样需要验证输入，特别是在传递数据到后台服务之前。
* 不要缓存敏感信息
* 不要使用eval()除非你知道你自己正在做什么

# 白名单
> 外部域是应用无法控制的，而域名白名单则是一种控制访问外部域的安全模型。Cordova提供了一项可配置的安全策略来定义哪些外部站点可以访问。默认情况下，新的app被配置成可以访问任何站点。然而在发布到生产环境前，你应该制定一份白名单，限制应用可以访问的域名和子域名。

## 对于Android
可以使用cordova-plugin-whitelist实现，虽然实现白名单插件是可能的，但还是不推荐这样做，除非你的app有非常明确的安全策略需要

## 对于其他平台
依赖于使用app的config.xml文件里的<access>标签，它是用来声明可以访问的特定域名的。

# 事件
Cordova给我们提供了很多的事件，可以在应用程序中使用。应用程序代码中可以添加这些事件的监听。事件相关定义都在www/js/index.js中

支持的平台/
事件|	android|ios|备注
-----|----|---|---|---|---|----
deviceready|||Cordova设备API准备好并可以访问的信号			
pause	|||当原生平台把应用程序放入后台这个pause事件会触发，通常是用户切换到了不同的应用程序		
resume	|||当原生平台将应用程序从后台运行拉出resume事件就会触发
backbutton	||X|当用户按下返回按钮事件触发 		
menubutton	||X|当用户按下菜单按钮事件触发
searchbutton||X|当用户按下搜索按钮事件触发
startcallbutton|X|X|当用户按下通话按钮事件触发
endcallbutton	|X|X|当用户按下挂断通话按钮事件触发		
volumedownbutton||X|当用户按下降低声音按钮事件触发
volumeupbutton	||X|当用户按下增加声音按钮事件触发

# 参考
## config.xml
http://cordova.axuer.com/docs/zh-cn/latest/config_ref/index.html

# 问题解决：
https://forum.ionicframework.com/t/ionic-3-ionic-serve-error-cannot-read-property-filter-of-undefined/85682/11


http://ionicframework.com/docs/components/#overview

http://www.runoob.com/ionic/ionic-tutorial.html

https://creator.ionic.io/app/dashboard/projects

~~~
ionic run ios --device
ionic run ios --emulator
ionic run ios --target="iPhone-5s"
ionic run ios --target="iPhone-6"
ionic run ios --target="iPhone-6s"
ionic run ios --emulator --target="iPhone-6s" -l  


http://localhost:8100/ 

ios-sim showdevicetypes

cordova run ios --target "iPad-Pro" --emulator

xcrun simctl list devices
~~~

ios-sim命令行工具。

ios-sim 是一个可以在命令控制iOS模拟器的工具。利用这个命令，我们可以启动一个模拟器，安装app，启动app，查询iOS SDK。它可以使我们像自动化测试一样不用打开Xcode。

~~~
Usage: ios-sim <command></command> <options> [--args ...]
 
    Commands:
      showsdks                        List the available iOS SDK versions
      showdevicetypes                 List the available device types
      launch <application path>       Launch the application at the specified path on the iOS Simulator
      start                           Launch iOS Simulator without an app
      install <application path>      Install the application at the specified path on the iOS Simulator without launching the app
 
    Options:
      --version                       Print the version of ios-sim
      --help                          Show this help text
      --exit                          Exit after startup
      --log <log file path>           The path where log of the app running in the Simulator will be redirected to
      --devicetypeid <device type>    The id of the device type that should be simulated (Xcode6+). Use 'showdevicetypes' to list devices.
                                      e.g "com.apple.CoreSimulator.SimDeviceType.Resizable-iPhone6, 8.0"
 
    Removed in version 4.x:
      --stdout <stdout file path>     The path where stdout of the simulator will be redirected to (defaults to stdout of ios-sim)
      --stderr <stderr file path>     The path where stderr of the simulator will be redirected to (defaults to stderr of ios-sim)
      --sdk <sdkversion>              The iOS SDK version to run the application on (defaults to the latest)
      --family <device family>        The device type that should be simulated (defaults to `iphone')
      --retina                        Start a retina device
      --tall                          In combination with --retina flag, start the tall version of the retina device (e.g. iPhone 5 (4-inch))
      --64bit                         In combination with --retina flag and the --tall flag, start the 64bit version of the tall retina device (e.g. iPhone 5S (4-inch 64bit))
 
    Unimplemented in this version:
      --verbose                       Set the output level to verbose
      --timeout <seconds>             The timeout time to wait for a response from the Simulator. Default value: 30 seconds
      --args <...>                    All following arguments will be passed on to the application
      --env <environment file path>   A plist file containing environment key-value pairs that should be set
      --setenv NAME=VALUE             Set an environment variable</environment file path></seconds></device family></sdkversion></stderr file path></stdout file path></device type></log file path></application path></application path></options>
~~~
ios-sim launch /Users/YDZ/Desktop/app.app --devicetypeid iPhone-6s
其中，/Users/YDZ/Desktop/app.app这个是设计师收到app之后的路径。--devicetypeid参数后面是给定一个模拟器的版本。

只需要把上面的命令发给设计师，无脑粘贴到命令行，装好app的模拟器就会自动启动，打开app了。
 
大公司的话可以应该有两个账号，一个上appstore的开发账户，这个严格保密。还有一个打线下包的企业账号，这样就能达到需求了 






