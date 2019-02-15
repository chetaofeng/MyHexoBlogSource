---
title: Retrofit
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

官网说明：http://square.github.io/retrofit/

推荐教程1：https://www.jianshu.com/p/86e5cddcc753

推荐教程2：https://www.jianshu.com/p/308f3c54abdd

大名鼎鼎的Retrofit库内置了对RxJava的支持

# 创建Retrofit实例
~~~
Retrofit retrofit = new Retrofit.Builder()
        .baseUrl("http://localhost:8080/")
        .build();
~~~

URL注意事件:
1. Base Ulr 必须以 /（斜线） 结束，不然会抛出一个IllegalArgumentException
2. @Url（@GET,@POST）: 不要在开始位置加 /
3. URL类似 https://www.baidu.com?key=value 用来作为baseUrl其实是可行的，因为这个URL隐含的路径就是 /（斜线，代表根目录） ，而后面的?key=value在拼装请求时会被丢掉所以写上也没用 

# 接口定义
~~~
public interface BlogService {
    @GET("blog/{id}")
    Call<ResponseBody> getBlog(@Path("id") int id);
}
~~~
注意，这里是interface不是class，所以我们是无法直接调用该方法，我们需要用Retrofit创建一个BlogService的代理对象
~~~
BlogService service = retrofit.create(BlogService.class);
~~~

# 接口调用
~~~
Call<ResponseBody> call = service.getBlog(2);
// 用法和OkHttp的call如出一辙,
// 不同的是如果是Android系统回调方法执行在主线程
call.enqueue(new Callback<ResponseBody>() {
    @Override
    public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
        try {
            System.out.println(response.body().string());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onFailure(Call<ResponseBody> call, Throwable t) {
        t.printStackTrace();
    }
}); 
~~~

# Converter
在默认情况下Retrofit只支持将HTTP的响应体转换换为ResponseBody,
即返回值都是 Call<ResponseBody>,而Converter就是Retrofit为我们提供用于将ResponseBody转换为我们想要的类型，如：
~~~
public interface BlogService {
  @GET("blog/{id}")
  Call<Result<Blog>> getBlog(@Path("id") int id);
}
~~~

# 引入Gson支持
~~~
compile 'com.squareup.retrofit2:converter-gson:2.0.2'
~~~
通过GsonConverterFactory为Retrofit添加Gson支持
~~~
Gson gson = new GsonBuilder()
      //配置你的Gson
      .setDateFormat("yyyy-MM-dd hh:mm:ss")
      .create();

Retrofit retrofit = new Retrofit.Builder()
      .baseUrl("http://localhost:4567/")
      //可以接收自定义的Gson，当然也可以不传
      .addConverterFactory(GsonConverterFactory.create(gson))
      .build();  
~~~
这样Retrofit就会使用Gson将ResponseBody转换我们想要的类型。

示例：
~~~
@POST("blog")
Call<Result<Blog>> createBlog(@Body Blog blog);
~~~
被@Body注解的的Blog将会被Gson转换成RequestBody发送到服务器。
~~~
BlogService service = retrofit.create(BlogService.class);
Blog blog = new Blog();
blog.content = "新建的Blog";
blog.title = "测试";
blog.author = "怪盗kidou";
Call<Result<Blog>> call = service.createBlog(blog);  
~~~

# RxJava与CallAdapter
Converter是对于Call<T>中T的转换，而CallAdapter则可以对Call转换，这样的话Call<T>中的Call也是可以被替换的，而返回值的类型就决定你后续的处理程序逻辑，同样Retrofit提供了多个CallAdapter，这里以RxJava的为例，用Observable代替Call：
~~~
引入RxJava支持:
compile 'com.squareup.retrofit2:adapter-rxjava2:2.3.0'
~~~
通过RxJavaCallAdapterFactory为Retrofit添加RxJava支持：
~~~
Retrofit retrofit = new Retrofit.Builder()
      .baseUrl("http://localhost:4567/")
      .addConverterFactory(GsonConverterFactory.create())
      .addCallAdapterFactory(RxJavaCallAdapterFactory.create())
      // 针对rxjava2.x
      .addCallAdapterFactory(RxJava2CallAdapterFactory.create()) 
      .build(); 
~~~
接口设计：
~~~
public interface BlogService {
  @POST("/blog")
  Observable<Result<List<Blog>>> getBlogs();
}
~~~
使用：
~~~
BlogService service = retrofit.create(BlogService.class);
service.getBlogs(1)
  .subscribeOn(Schedulers.io())
  .subscribe(new Subscriber<Result<List<Blog>>>() {
      @Override
      public void onCompleted() {
        System.out.println("onCompleted");
      }

      @Override
      public void onError(Throwable e) {
        System.err.println("onError");
      }

      @Override
      public void onNext(Result<List<Blog>> blogsResult) {
        System.out.println(blogsResult);
      }
  });
~~~
像上面的这种情况最后我们无法获取到返回的Header和响应码的，如果我们需要这两者，提供两种方案：

1. 用Observable<Response<T>> 代替 Observable<T> ,这里的Response指retrofit2.Response 
2. 用Observable<Result<T>> 代替 Observable<T>，这里的Result是指retrofit2.adapter.rxjava.Result,这个Result中包含了Response的实例 
~~~