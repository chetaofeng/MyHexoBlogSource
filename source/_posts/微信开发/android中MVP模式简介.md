---
title: android中MVP模式简介
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

https://github.com/googlesamples

https://github.com/googlesamples/android-architecture

# 简介
* MVP作为MVC的演化版本，那么类似的MVP所对应的意义：M-Model-模型、V-View-视图、P-Presenter-表示器
* Android本身就采用的是MVC（Model View Controllor）模式、其中Model指的是数据逻辑和实体模型；View指的是布局文件、Controllor指的是Activity
* 从MVC和MVP两者结合来看，Controlller/Presenter在MVC/MVP中都起着逻辑控制处理的角色，起着控制各业务流程的作用
* MVP与MVC最不同的一点是M与V是不直接关联的也是就Model与View不存在直接关系，这两者之间间隔着的是Presenter层，其负责调控 View与Model之间的间接交互
* 在 Android中很重要的一点就是对UI的操作基本上需要异步进行也就是在MainThread中才能操作UI，所以对View与Model的切断分离是 合理的
* Presenter与View、Model的交互使用接口定义交互操作可以进一步达到松耦合也可以通过接口更加方便地进行单元测试

# 具体使用
参考：
1. https://www.jianshu.com/p/1f91cfd68d48
2. https://github.com/LJYcoder/DevRing
3. http://www.jcodecraeer.com/a/anzhuokaifa/2017/1020/8625.html?1508484926
4. https://www.jianshu.com/p/364f14c76874

需要写四个部分：Model层，View层，Presenter层，接口

## 接口
负责“连接”MVP三层，以便方法调用、数据流动。同时也便于进行单元测试。

### IView
View层接口，定义View层需实现的方法，P层通过该接口回调通知View层
~~~
public interface IMovieView {
    //成功获取到电影数据
    void getMovieSuccess(List<MovieRes> list, int type);
    //获取电影数据失败
    void getMovieFail(int status, String desc, int type);
}
~~~

### IModel/IService
Model层接口，定义Model层需实现的方法，P层通过该接口调用M层获取/处理数据的方法;有些项目把这块也拆分未Service层，叫法不同而已
~~~
public interface IMovieMoel{
    //请求正在上映的电影数据
    Observable getPlayingMovie(int start, int count);
    ...
}
~~~

## Model层／Service
实现IModel／IService接口中的方法，负责数据的获取/处理
~~~
public class MovieModel implements IMovieMoel{

    @Override
    public Observable getPlayingMovie(int start,int count) {
        //提供数据源
        return DevRing.httpManager().getService(MovieApiService.class).getPlayingMovie(start, count);
    }
    ...
}
~~~

## Presenter层
* Presenter处理业务逻辑，调用M层获取数据，调用V层传递展示数据
* Presenter持有一个IView接口，是为了能够通过View接口通知Activity进行更新界面等操作 
~~~
public class MoviePresenter {
    private IMovieView mIView;
    private IMovieModel mIModel;

    public MoviePresenter(IMovieView iMovieView, IMovieMoel iMovieMoel) {
        mIView = iMovieView;
        mIModel = iMovieModel;
    }

    /**
     * 获取正在上映的电影
     *
     * @param start 请求电影的起始位置
     * @param count 获取的电影数量
     * @param type  类型：初始化数据INIT、刷新数据REFRESH、加载更多数据LOADMORE
     */
    public void getPlayingMovie(int start, int count, final int type) {
        DevRing.httpManager().commonRequest( mIModel.getPlayingMovie(start, count),
         new CommonObserver<HttpResult<List<MovieRes>>>() {
            @Override
            public void onResult(HttpResult<List<MovieRes>> result) {
                if (mIView != null) {
                    mIView.getMovieSuccess(result.getSubjects(), type);
                }
            }

            @Override
            public void onError(int errType, String errMessage) {
                if (mIView != null) {
                    mIView.getMovieFail(errType, errMessage, type);
                }
            }
        }, RxLifecycleUtil.bindUntilDestroy(mIView)); 
    }

    ...

     /**
     * 释放引用，防止内存泄露
     */
    public void destroy() {
        mIView = null;
    }
}
~~~

## View层
实现IView接口中的方法，对获取到的数据进行展示。对应日常的Activity／Fragement类，实现Iview接口
~~~
public class MovieActivity extends Activity implements IMovieView {
    //获取电影数据成功的网络请求回调
    @Override
    public void getMovieSuccess(List<MovieRes> list, int type) {
        //成功，对数据进行展示
        ....
    }

    //获取电影数据失败的网络请求回调
    @Override
    public void getMovieFail(int status, String desc, int type) {
        //失败，界面上做出相应提示
        ...
    }

    ...
}
~~~
或者匿名类对象关联：
~~~
@Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ...
        mBookPresenter.onCreate();
        mBookPresenter.attachView(mBookView);
    }

private BookView mBookView = new BookView() {
    @Override
    public void onSuccess(Book mBook) {
        text.setText(mBook.toString());
    }

    @Override
    public void onError(String result) {
        Toast.makeText(MainActivity.this,result, Toast.LENGTH_SHORT).show();
    }
};
~~~

## 调用
1. 在View层初始化时，调用Presenter层方法即可
~~~
@Override
protected void onCreate(Bundle saveInstanceState) {
      ...
      mPresenter = new MoviePresenter(this, new MovieModel());
      mPresenter.getPlayingMovie(start, mCount, type);
}
~~~
2. 如果Presenter层持有了View层的引用，那么记得在V层销毁时，把Presenter层中对View层的引用置null，避免View层回收失败导致内存泄漏
~~~
@Override
public void onDestroy() {
     super.onDestroy();
     if (mPresenter != null) {
          mPresenter.destroy();
          mPresenter = null;
     }
 }
~~~

 