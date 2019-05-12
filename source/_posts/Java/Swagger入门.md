---
title: Swagger入门
tags:
  - java 
copyright: true
comments: true
toc: true
date: 2019-03-10 21:25:33
categories: Java
password:
---


# 简介 
https://swagger.io/
Swagger 是一个规范和完整的框架，用于生成、描述、调用和可视化 RESTful 风格的 Web 服务

# 基本使用使用
1. 添加maven依赖
~~~
<!-- swagger RESTful API 文档 -->
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger2</artifactId>
    <version>2.2.2</version>
</dependency>
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger-ui</artifactId>
    <version>2.2.2</version>
</dependency>
~~~
2. 添加Swagger配置类
~~~
@Configuration
@EnableSwagger2
public class Swagger2Config {
    @Bean
    public Docket createRestApi() {

        ApiInfo apiInfo = new ApiInfoBuilder()
                .title("测试Swagger项目接口文档")
                .description("测试Swagger项目接口文档，符合RESTful API。")
                .version("1.0")
                .build();

        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo)   //api的标题、描述、版本等信息
                .select() // 选择那些路径和api会生成document
                .apis(RequestHandlerSelectors.basePackage("com.test.controller")) //以扫描包的方式
                .paths(PathSelectors.any())
                .build();
    }
}
~~~
3. 创建接口类
~~~
@Api(value = "用户模块")
@RestController
@RequestMapping("/user")
public class UserController {
    /**
     * 获取单个用户
     *
     * @param id
     * @return
     */
    @ApiOperation(value = "获取单个用户", notes = "传入id获取单个用户")
//    @ApiImplicitParam(name = "id", value = "用户id", required = true, paramType = "path", dataType = "Long") //注意：paramType需要指定为path,不然不能正常获取
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String user(@ApiParam(value = "用户Id", required = true) @PathVariable Long id) {
        return "user id :" + id;
    }

    /**
     * 获取用户列表
     *
     * @return
     */
    @ApiOperation(value = "获取用户列表", notes = "获取用户列表")
    @RequestMapping(value = "", method = RequestMethod.GET)
    public List list() {
        List list = new ArrayList();
        list.add("Sam1");
        list.add("Sam2");
        list.add("Sam3");
        return list;
    }

    /**
     * 新建用户
     *
     * @param user
     * @return
     */
    @ApiOperation(value = "新建用户", notes = "新建一个用户")
//    @ApiImplicitParams({
    //注意：paramType需要指定为body
//            @ApiImplicitParam(name = "user", value = "用户数据", required = true, paramType = "body", dataType = "User")
//    })
    @RequestMapping(value = "", method = RequestMethod.POST)
    public String create(@ApiParam(value = "用户数据", required = true) @RequestBody User user) {
        System.out.println("user : " + user.getName() + " " + user.getAge());
        return "success 新建user : " + user.getName() + " " + user.getAge();
    }


    /**
     * 删除用户
     *
     * @return
     */
    @ApiOperation(value = "删除用户", notes = "通过用户id删除用户")
    @ApiImplicitParam(name = "id", value = "用户id", required = true, paramType = "path", dataType = "Long")
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String delete(@PathVariable Long id) {
        System.out.println("删除用户：" + id);
        return "success 删除user" + id;
    }


    /**
     * 更新用户
     *
     * @return
     */
    @ApiOperation(value = "更新用户", notes = "更新已存在用户")
    @ApiImplicitParam(name = "user", value = "用户数据", required = true, paramType = "body", dataType = "User")
    @RequestMapping(value = "", method = RequestMethod.PUT)
    public String update(@RequestBody User user) {
        System.out.println("更新用户：" + user.getId() + " " + user.getName() + " " + user.getAge());
        return "success 更新user : " + user.getId() + " " + user.getName() + " " + user.getAge();
    }
}
~~~
4. 启动SpringBoot项目，访问 http://localhost:8080/swagger-ui.html 查看效果
![image](/pub-images/swagger2.png)

# Swagger2注解
~~~
@EnableSwagger2：表示开启Swagger2  
@ApiParam：单个参数描述 
@ApiProperty：用对象接收参数时，描述对象的一个字段 
@ApiIgnore：使用该注解忽略这个API
@ApiError ：发生错误返回的信息 

@Api：用在请求的类上，表示对类的说明
    tags="说明该类的作用，可以在UI界面上看到的注解"
    value="该参数没什么意义，在UI界面上也看到，所以不需要配置"
  
@ApiOperation：用在请求的方法上，说明方法的用途、作用
    value="说明方法的用途、作用"
    notes="方法的备注说明"
  
@ApiImplicitParams：用在请求的方法上，表示一组参数说明
    @ApiImplicitParam：用在@ApiImplicitParams注解中，指定一个请求参数的各个方面
        name：参数名
        value：参数的汉字说明、解释
        required：参数是否必须传
        paramType：参数放在哪个地方
            · header --> 请求参数的获取：@RequestHeader
            · query --> 请求参数的获取：@RequestParam
            · path（用于restful接口）--> 请求参数的获取：@PathVariable
            · body（不常用）
            · form（不常用）   
        dataType：参数类型，默认String，其它值dataType="Integer"      
        defaultValue：参数的默认值
  
@ApiResponses：用在请求的方法上，表示一组响应
    @ApiResponse：用在@ApiResponses中，一般用于表达一个错误的响应信息
        code：数字，例如400
        message：信息，例如"请求参数没填好"
        response：抛出异常的类
  
@ApiModel：用于响应类上，表示一个返回响应数据的信息
            （这种一般用在post创建的时候，使用@RequestBody这样的场景，
            请求参数无法使用@ApiImplicitParam注解进行描述的时候）
    @ApiModelProperty：用在属性上，描述响应类的属性 
~~~

参考文章：
* https://blog.csdn.net/qq_32506963/article/details/82911455
* http://www.cnblogs.com/jtlgb/p/8532433.html

