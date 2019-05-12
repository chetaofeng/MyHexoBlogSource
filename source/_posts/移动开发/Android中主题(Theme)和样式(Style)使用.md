---
title: Android中主题(Theme)和样式(Style)使用
tags:
  - android 
copyright: true
comments: true
toc: true
categories: 移动开发
password:
---

# Theme和Style说明
* Theme是全局的设计风格。style是局部的设计风格
* Theme是一套UI控件和Activity的样式。可以给Application 和 activity 设置主题。来设置显示界面的样式
* style是针对view来说的，比如 TextView，EditText这些，而Theme必须针对整个activity或者 整个application，你必须在AndroidManifest.xml中 的<application>或者<activity>中定义
* Style的xml文件要求：
~~~
1. 他的根节点必须 是<resources>
2. 给<style> 增加一个全局唯一的名字，也可以选择增加一个parent父类属性
3. 使用时只要在写我们的view时，加入style标签就可以了
    <TextView
        style="@style/CodeFont"
        android:text="@string/hello" />
~~~

# Theme设置
## Theme设置
~~~
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.jude.test.education" >

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        <!--这里设置的是整个APP的主题，所有activiy和view都会默认为这个主题-->
        android:theme="@style/AppTheme" >
        <activity
            android:name=".MainActivity"
            android:label="@string/app_name"
            <!--这里设置的是这个Activity的主题，Activity所有view都会默认为这个主题-->
            android:theme="@style/AppTheme"
            >
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>
~~~
## Theme继承并重写
在value->style里定义主题。可以继承并重写属性
~~~
<!-- 兼容主题 深色主题 activity背景默认黑色，字体默认白色-->
<style name="AppTheme" parent="Theme.AppCompat">
</style>

<!-- 兼容主题 浅色主题 activity背景默认白色 字体默认黑色 -->
<style name="AppTheme2" parent="Theme.AppCompat.Light">
</style>

<!-- 兼容主题 深色主题 无Actionbar-->
<style name="AppTheme3" parent="Theme.AppCompat.NoActionBar">
</style>

<!-- 兼容主题 浅色主题 无Actionbar-->
<style name="AppTheme4" parent="Theme.AppCompat.Light.NoActionBar">
</style>
~~~

## 代码中设置Activity主题
* Activity 是 ContextThemeWrapper的子类。而ContextThemeWrapper一个很重要的属性就是Theme
* 实例化一个View必须要 new View(Context context) 。因为View需要把Attributes交给Context的Theme来确定一堆属性(在一个叫TypedArray的容器里)

## Theme设置注意事项
* 如果使用 android.support.v7.app.ActionBarActivity 就必须要用兼容主题Theme.AppCompat。
~~~
ActionBarActivity 的存在就是为了兼容低API。让他们用上高API的东西。比如Toolbar
~~~
* Holo主题是Android4.0开始谷歌极力推行的Android Design的主题
~~~
<style name="AppTheme5" parent="android:Theme.Holo">
</style>
~~~
* Android5.0谷歌又推出了Material Design来取代Android Design
~~~
 <style name="AppTheme5" parent="android:Theme.Material">
</style>
~~~

# Theme来源
在Android Studio中书写主题时都会有自动提示

1. 来自Android系统自带的。自带的主题要加上“android:”，如：android:Theme.Black
2. 来自兼容包的(比如v7兼容包)。使用v7兼容包中的主题不需要前缀，直接：Theme.AppCompat
3. 自己写一个主题

# Theme种类
* 所有能应用于应用程序主题都是以“Theme.”开头
* 在v7中有很多以“Base”开头的主题，是一些父主题，不建议直接使用
~~~
系统自带主题：
API 1:
android:Theme 根主题
android:Theme.Black 背景黑色
android:Theme.Light 背景白色
android:Theme.Wallpaper 以桌面墙纸为背景
android:Theme.Translucent 透明背景
android:Theme.Panel 平板风格
android:Theme.Dialog 对话框风格

API 11:
android:Theme.Holo Holo根主题
android:Theme.Holo.Black Holo黑主题
android:Theme.Holo.Light Holo白主题

API 14:
Theme.DeviceDefault 设备默认根主题
Theme.DeviceDefault.Black 设备默认黑主题
Theme.DeviceDefault.Light 设备默认白主题

API 21: (网上常说的 Android Material Design 就是要用这种主题)
Theme.Material Material根主题
Theme.Material.Light Material白主题

================================================================
兼容包v7中带的主题：
Theme.AppCompat 兼容主题的根主题
Theme.AppCompat.Black 兼容主题的黑色主题
Theme.AppCompat.Light 兼容主题的白色主题

...
~~~

# Theme风格种类
~~~
Black 黑色风格
Light 光明风格
Dark 黑暗风格
DayNight 白昼风格
Wallpaper 墙纸为背景
Translucent 透明背景
Panel 平板风格
Dialog 对话框风格
NoTitleBar 没有TitleBar
NoActionBar 没有ActionBar
Fullscreen 全屏风格
MinWidth 对话框或者ActionBar的宽度根据内容变化，而不是充满全屏
WhenLarge 对话框充满全屏
TranslucentDecor 半透明风格
NoDisplay 不显示，也就是隐藏了
WithActionBar 在旧版主题上显示ActionBar
~~~

# 每个主题中定义item分类
https://yq.aliyun.com/articles/72108

颜色、字体、按钮、list、window、Dialog、AlertDialog、Panel、滚动条、文字选中（Text Selection）、Widget样式、Preference样式、search控件样式、ActionBar样式、其他样式
 