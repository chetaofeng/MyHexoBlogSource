---
title: Android res文件夹解析
tags:
  - android 
copyright: true
comments: true
toc: true
date: 2018-10-06 12:13:04
categories: 移动开发
password:
---
[toc]

https://blog.csdn.net/ws00801526/article/details/10449621

# 说明
AS中Gradle默认不创建asserts文件夹，但他的路径已经存在于main 文件夹下面了，也可通过sourceSets属性在gradle中配置工程结构
https://github.com/ShinChven/MigrateToGradle

# 自定义文件夹
android项目中的资源文件支持拓展:定义资源文件夹名-拓展属性,拓展属性包括以下内容

* 语言   -en -es
* 区域   -rCN
* 屏幕方向  -port  -land  -square
* 屏幕密度 -92dpi 
* 用户是否可以使用键盘  -keysexposed,-keyshidden
* 默认的文字输入方法  -nokeys,-qwerty
* 默认的非触摸导航方法  -notouch,-dpad
* 屏幕尺寸  -324x240,-640x480 较大尺寸必须首先声明
* 触摸屏类型  -notouch ,-finger,-stylus
* 版本号   -V4  ,-V7

注意事项:值之间-号连接,大小写敏感,同一类型只能有一个值 
 
# valuse资源文件
## 文件说明
~~~
strings.xml
			作用:定义字符串
			定义格式:<string name="xxx">字符串值</string>
			支持占用符  例子:  <string name="xxx">今天%1$s,温度%2$d</string>
			%1 %2---代表参数所在位置
			$s,$d代表参数,s,d为参数类型
			getString(R.string.xxx,"星期一",20) = 今天星期一,温度20
			使用方法:资源文件中   @string/xxx
			代码中   getString(R.string.xxx)
		arrays.xml
			作用:定义数组,可以是int,string,char
			定义格式:<type-array name="xxx">
			<item>数组元素值</item>
			</type-array>
			使用方法:资源文件中   不支持引用
			代码中   type s[] = getResource.getTypeArray(R.array.xxx)
		colors.xml
			作用:定义颜色
			定义格式:<color name="xxx">#color值</color>
			使用方法:资源文件中 @color/xxx
			代码中getResource.getColor(R.color.xxx) 或者
			getresource.getDrawable(R.color.xxx)
		dimens.xml
			作用:定义尺寸大小
			定义格式:<dimen name="xxx">值</dimen>
			使用方法:资源文件中 @dimen/xxx
			代码中  getResource.getDimension(R.dimen.xxx)
		styles.xml
			作用:定义试图样式
			定义格式:<style name="xxx"  parent="yyy">
            			<item name="xxx2">元素值</item>
            		</style>
~~~
## 适配API
AS的Project视图时，会有valuse与valuse-V(XX)文件夹；Android视图时，有时valuse资源文件下的xml文件会有多个，如多个strings.xml文件，其使用规则如下：
* values: 是缺省的文件夹且最后被匹配的，它包含在value是-X中没有包含的API水平。一般缺省都使用这个文件夹
* value-11: 针对API在11以上和13以上的，如果values-14存在的话。如果values-14不存在，则API 11以上都要使用该文件夹。另外API在11以下则无法使用该文件夹
* 开发中只需要在VXX中指定特殊的，其他的全放在values即可

# drawable文件夹
* 作用:存放各种图片类型,不能纯数字定义文件名,另可以新建.xml文件类型  通常自定义控件样式时会在此文件夹中新建个.xml格式文件作为背景图
* 使用方法:
~~~
getDrawable(R.drawable.xxx)
~~~

# layout文件夹
## 基本使用
* 作用:存放各种布局文件
* 使用方法:
~~~
setcontentView(R.layout.xxx) ;
View view = LayoutInflater.from(context).inflate(R.layout.xxx,null)
~~~

## 建立子文件夹
* AS中layout只能在project视图下有效，android目录下无效
* 'src/main/res/layout','src/main/res'为必写项，必须放到最后

在这个module的build.gradle文件下添加以下代码:
~~~
sourceSets {
    main {
        res.srcDirs =
                [
                    'src/main/res/layout/main', 
                    'src/main/res/layout/dialog',
                    ...
                //下面两个是固定兼容写法，必须放到最后
                    'src/main/res/layout',
                    'src/main/res'
                ]
    }
}
~~~

# xml文件夹
* 作用:存放各种xml文件,例如使用PreferenceFragment时需要在此xml文件夹中建立个preferenceFragment使用的.xml文件
* 使用方法:
~~~
XmlResoutceParser xml = getResources().getXml(R.xml.xxx)
~~~

# assets文件夹
* 创建：右键new-->Folder-->AssetsFolder
* assets目录是Android的一种特殊目录，用于放置APP所需的固定文件，且该文件被打包到APK中时，不会被编码到二进制文件
* assets目录不会被映射到R中，因此，资源无法通过R.id方式获取，必须要通过AssetManager进行操作与获取
* assets下可以有多级目录
* assets目录下资源不会被二进制编码
* 使用方法:
~~~
InputStream read =getAssets().open(R.assets.xxx)
OutputStream write = getAssets().open(R.assets.xxx)
~~~

# raw文件夹
需自行创建
* res/raw目录下的资源会被映射到R中，可以通过getResource()方法获取资源
* res/raw下不可以有多级目录
* res/raw不会被编码
* 使用方法:
~~~
InputStream read = getResources().openRawResource(R.raw.xxx)
OutputStream write = getResources().openRawResource(R.raw.xxx)
~~~

# anim文件夹
需自行创建
* 作用:存放各种自定义动画格式
* 使用方法
~~~
getResources().getAnimation(R.anim.xxx)
~~~

 