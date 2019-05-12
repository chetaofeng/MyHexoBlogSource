---
title: SpringBoot入门
tags: 
  - Spring Boot
  - Spring
copyright: true
comments: true
toc: true
date: 2018-11-26 14:41:51
categories: Spring
password:
---

https://www.imooc.com/video/16358
https://www.imooc.com/learn/1058
https://www.imooc.com/video/16783

# 简介
* 官网：http://spring.io/，https://spring.io/projects/spring-boot
* 英文文档：https://docs.spring.io/spring-boot/docs/current/reference/
* Spring Framework是一种JavaEE的框架；Spring Boot是一种快速构建的Spring应用；Spring Cloud是构建SpringBoot的分布式应用
* Spring MVC 相当于一辆手动挡汽车，Spring Boot 相当于把汽车变成自动挡，然后还加装了无钥匙进入、自动启停等功能，让你开车更省心。但是车的主体功能不变，你还是要用到 Spring MVC

SpringBoot2.0: 编程语言Java 8+，Kotlin，底层框架：SpringFramework 5.0.X,支持Web Flux

Web Flux  
1. 支持函数编程，Java 8 Lambda
2. 响应式编程,Reactive Streams
3. 异步编程，Servlet3.1和Asyc NIO

SpringBoot优势：
* 组件自动装配：规约大于配置，专注核心业务
* 外部化部署：一次构建、按需调配，到处运行
* 嵌入式容器：内置容器、无需部署、独立运行
* SpringBoot Starter:简化依赖、按需装配、自我包含
* Production-Ready：一站式运维、生态无缝整合

# SpringBoot和Maven
~~~
 <parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>1.5.9.RELEASE</version>
    <relativePath/>
</parent>
~~~ 
* spring-boot-starter-parent 模块中包含了自动配置、日志和YAML，使构建spring项目变得简单
* spring-boot-starter-parent它用来提供相关的Maven默认依赖，使用它之后，常用的包依赖可以省去version标签
* Spring Boot提供的jar包的依赖可参考.m2/repository/org/springframework/boot/spring-boot-dependencies/下pom文件
~~~
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
</dependencies>
~~~
spring-boot-starter-web 模块，包括了Tomcat和Spring MVC的依赖
~~~
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
</dependency>
~~~
spring-boot-starter-test 测试模块，包括JUnit、Hamcrest、Mockito

* 在spring-boot中，模块的依赖都是以starter的方式进行，以 spring-boot-starter-方式命名，指明了具体的模块
* 使用starter的依赖方式，可以把相应需要依赖的包一起依赖到项目中，而不像传统的Spring 需要各自依赖包
* 更多starter作用，请参考：Spring Boot的启动器Starter详解(https://my.oschina.net/u/3235888/blog/887854)
* SpringBoot启动原理（推荐必读）：https://www.cnblogs.com/zheting/p/6707035.html

# 项目构建
方式一：在线构建 http://start.spring.io 
方式二：IDEA中IndexController构建spring-boot项目

# SpringBoot的属性配置
## 默认配置
* 如果需要修改starter模块中的默认配置，只需要在application.properties 中添加修改相应的配置
* spring boot启动的时候会读取application.properties默认配置
* 在spring boot中配置除了支持 application.properties，还支持application.yml的配置方式
* 详细SpringBoot配置可参考： https://docs.spring.io/spring-boot/docs/current/reference/html/common-application-properties.html

## 自定义属性配置
~~~
com.student.id=6228
com.student.name=lily 
com.student.desc=${name} id is ${random.int} 
~~~
* 定义属性对应类需要添加@Component注解，让spring在启动的时候扫描到该类，并添加到spring容器中
* 在application.properties内可以直接通过${}引用其他属性的值；通过${random}获取随机数
* 如果不使用默认名称的配置文件，如改名为test.properties这份默认配置，则通过在bean添加@Configuration和@PropertySource("classpath:test.properties")来设置
1. 使用spring支持的@Value()加载
~~~
@Component 
public class Student {
    @Value("${com.student.id}")
    private int id;
    @Value("${com.student.name}")
    private String name;  
    @Value("${com.student.desc}")
    private String desc;  
}
~~~
2. 使用@ConfigurationProperties(prefix="") 设置前缀，属性上不需要添加注解
~~~
@Component
@ConfigurationProperties(prefix = "com.student")
public class Student {
    private int id;
    private String name;  
    private String desc;
}
~~~
使用：
~~~
@Autowired
private Student student;
~~~
## 属性配置优先级
application.properties和application.yml文件可以放在一下四个位置：
* 外置，在相对于应用程序运行目录的/congfig子目录里。
* 外置，在应用程序运行的目录里
* 内置，在config包内
* 内置，在Classpath根目录

相同优先级位置同时有application.properties和application.yml，那么application.yml里面的属性就会覆盖application.properties里的属性

## 多环境配置
在application.properties/在application.yml同目录下新建不同环境下的配置文件，格式：application-{profile}.properties，如：
~~~
application-dev.properties      //开发环境的配置文件
application-test.properties     //测试环境的配置文件
application-prod.properties     //生产环境的配置文件
~~~
在application.properties/在application.yml中设置spring.profiles.active的值为{profile}（dev／test／prod）来启用不同的配置属性

# 静态资源处理
## 默认静态资源映射
Spring Boot对静态资源映射提供了默认路径配置， 其内内容均为静态资源，可直接访问，提供的静态资源映射如下:
![image](/pub-images/静态资源优先级.png)
~~~
//优先级由高到低
classpath:/META-INF/resources
classpath:/resources
classpath:/static
classpath:/public
~~~
可以通过修改spring.mvc.static-path-pattern来修改默认的映射，例如我改成/test/**,那运行的时候访问http://lcoalhost:8080/test/index.html


## 自定义静态资源映射
如访问static下资源，如：http://localhost:8080/static/test.jpg，则可通过如下方式
方式1：在application.properties中添加配置：spring.mvc.static-path-pattern=/static/** 则只能通过/static/来访问静态资源
方式2：代码实现
~~~
@Configuration
public class WebMvcConfig extends WebMvcConfigurerAdapter {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        //将所有/static/** 访问都映射到classpath:/static/ 目录下
        registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/");
    }
}
~~~

# 模板引擎
* Spring Boot 推荐使用Thymeleaf、FreeMarker、Velocity、Groovy、Mustache等模板引擎，不建议使用JSP
* 默认 src/main/resources/templates 目录为以上模板引擎的配置路径
使用流程：
1. pom中对应模版starter引入
2. 编写controller
3. 在templates下编写模版

# 热部署
热部署:监听Class文件的变动，只把发生修改的Class重新加载，而不需要重启应用
1. 使用spring-boot-maven-plugin
* 把项目打包成一个可执行的超级JAR（uber-JAR）,包括把应用程序的所有依赖打入JAR文件内，并为JAR添加一个描述文件，其中的内容能让你用java -jar来运行应用程序。
* 搜索public static void main()方法来标记为可运行类
* 详细讲解参考：https://blog.csdn.net/taiyangdao/article/details/75303181
* 官网：https://docs.spring.io/spring-boot/docs/current/reference/html/build-tool-plugins-maven-plugin.html
2. 使用spring-boot-devtools 

# ControllerAdvice
可以用于定义@ExceptionHandler、@InitBinder、@ModelAttribute，并应用到所有@RequestMapping中，通常用于拦截异常并统一处理
https://www.cnblogs.com/magicalSam/p/7198420.html

# SpringBoot项目运行模式
1. main方法方式
2. 用命令 mvn spring-boot:run”在命令行启动该应用,可通过IDEA的Maven插件中Plugins-》spring-boot找到
3. Jar／War方式 :运行“mvn package”进行打包时，会打包成一个可以直接运行的 JAR 文件，使用“java -jar”命令就可以直接运行，war包形式，需要有webapp->WEB-INF->web.xml，java -jar [war名称.war]

# 默认日志框架配置
* SLF4J——Simple Logging Facade For Java，它是一个针对于各类Java日志框架的统一Facade抽象
* SLF4J定义了统一的日志抽象接口，而真正的日志实现则是在运行时决定的——它提供了各类日志框架的binding
* Logback是log4j框架的作者开发的新一代日志框架，它效率更高、能够适应诸多的运行环境，同时天然支持SLF4J。
* Spring Boot在所有内部日志中使用Commons Logging，但是默认配置也提供了对常用日志的支持
* 默认情况下，Spring Boot会用Logback来记录日志，并用INFO级别输出到控制台
* spring-boot-starter-logging为logback的starter，一般会包含在其他starter中如spring-boot-starter，不需要显式引入
* 日志级别从低到高分为TRACE < DEBUG < INFO < WARN < ERROR < FATAL
* 可以按如下规则组织配置文件名：Logback：logback-spring.xml, logback-spring.groovy, logback.xml, logback.groovy

参考文章：https://www.cnblogs.com/zheting/p/6707041.html

# 自定义 Filter

# JPA数据库操作
http://www.ityouknow.com/springboot/2016/08/20/spring-boo-jpa.html
~~~
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
 <dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
</dependency>
~~~
* Jpa 是利用 Hibernate 生成各种自动化的 sql，如果只是简单的增删改查，基本上不用手写了，Spring 内部已经帮大家封装实现了
* Spring Data Jpa 还有很多功能，比如封装好的分页，可以自己定义 SQL，主从分离等等

# mybatis
http://www.ityouknow.com/springboot/2016/11/06/spring-boo-mybatis.html



# Redis
~~~
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>
<dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-pool2</artifactId>
</dependency>
~~~

# Spring Factories机制
* Java SPI(Service Provider Interface)机制:为某个接口寻找服务实现的机制
1. 当服务的提供者，提供了服务接口的一种实现之后，在jar包的META-INF/services/目录里同时创建一个以服务接口命名的文件,该文件里就是实现该服务接口的具体实现类
2. 当外部程序装配这个模块的时候，就能通过该jar包META-INF/services/里的配置文件找到具体的实现类名，并装载实例化，完成模块的注入
* Spring Boot中的SPI机制:Spring Factories(Spring Boot中一种非常解耦的扩展机制)
1. 在META-INF/spring.factories文件中配置接口的实现类名称
2. 当外部程序装配这个模块的时候，就能通过该jar包META-INF/services/里的配置文件找到具体的实现类名，并装载实例化，完成模块的注入。这种自定义的SPI机制是Spring Boot Starter实现的基础。

# 自定义starter
* starter可以理解为一个可拔插式的插件
* starter的artifactId的命名规则
1. 官方Starter通常命名为spring-boot-starter-{name}如 spring-boot-starter-web
2. 非官方Starter命名应遵循{name}-spring-boot-starter的格式, 如mybatis-spring-boot-starter

Starter的工作原理:
1. Spring Boot在启动时扫描项目所依赖的JAR包，寻找包含spring.factories文件的JAR包，
2. 读取spring.factories文件获取配置的自动配置类AutoConfiguration，
3. 将自动配置类下满足条件(@ConditionalOnXxx)的@Bean放入到Spring容器中(Spring Context)
4. 这样使用者就可以直接用来注入，因为该类已经在容器中了 

自定义starter步骤：
1. maven引入：
~~~
dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-autoconfigure</artifactId>
</dependency>
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-configuration-processor</artifactId>
  <optional>true</optional>
</dependency>
~~~
* spring-boot-configuration-processor：spring默认使用yml中的配置，但有时候要用传统的xml或properties配置，则需要依赖他，这样就可以在你的配置类开头加上@PropertySource("classpath:your.properties")，其余用法与加载yml的配置一样
* spring-boot-autoconfigure: http://ifeve.com/spring-boot-autoconfigure/
2. 定义自己的Properties类,如PersonProperties.java：
~~~
@ConfigurationProperties(prefix = "spring.person")
@Data
public class PersonProperties {
    private String name;
    private int age; 
}    
~~~
3. 核心服务类,如PersonService.java：
~~~
public class PersonService {
    private PersonProperties properties;
    public PersonService() {}
    public PersonService(PersonProperties properties) {
        this.properties = properties;
    }
    public void sayHello(){
        System.out.println("大家好，我叫: " + properties.getName() + ", 今年" + properties.getAge() + "岁");
    }
}
~~~
4. 自动配置类:一般每个starter都至少会有一个自动配置类，一般命名规则使用XxxAutoConfiguration,如：PersonServiceAutoConfiguration
~~~
@Configuration
@EnableConfigurationProperties(PersonProperties.class)
@ConditionalOnClass(PersonService.class)
@ConditionalOnProperty(prefix = "spring.person", value = "enabled", matchIfMissing = true)
public class PersonServiceAutoConfiguration {
    @Autowired
    private PersonProperties properties;

    @Bean
    @ConditionalOnMissingBean(PersonService.class)  // 当容器中没有指定Bean的情况下，自动配置PersonService类
    public PersonService personService(){
        PersonService personService = new PersonService(properties);
        return personService;
    }
}
~~~
所用注解说明：
~~~
@ConditionalOnClass：当类路径classpath下有指定的类的情况下进行自动配置
@ConditionalOnMissingBean:当容器(Spring Context)中没有指定Bean的情况下进行自动配置
@ConditionalOnProperty(prefix = “example.service”, value = “enabled”, matchIfMissing = true)，当配置文件中example.service.enabled=true时进行自动配置，如果没有设置此值就默认使用matchIfMissing对应的值
@ConditionalOnMissingBean，当Spring Context中不存在该Bean时。
@ConditionalOnBean:当容器(Spring Context)中有指定的Bean的条件下
@ConditionalOnMissingClass:当类路径下没有指定的类的条件下

@ConditionalOnExpression:基于SpEL表达式作为判断条件

@ConditionalOnJava:基于JVM版本作为判断条件
@ConditionalOnJndi:在JNDI存在的条件下查找指定的位置
@ConditionalOnNotWebApplication:当前项目不是Web项目的条件下
@ConditionalOnWebApplication:当前项目是Web项目的条件下
@ConditionalOnResource:类路径下是否有指定的资源
@ConditionalOnSingleCandidate:当指定的Bean在容器中只有一个，或者在有多个Bean的情况下，用来指定首选的Bean 

@ConfigurationProperties: 主要用来把properties配置文件转化为对应的XxxProperties来使用的,并不会把该类放入到IOC容器中，想放入容器可通过@Component来标注或@EnableConfigurationProperties(XxxProperties.class)
@EnableConfigurationProperties(XxxProperties.class) 注解的作用是@ConfigurationProperties注解生效
~~~
5. src/main/resources/META-INF/spring.factories
注意：META-INF是自己手动创建的目录，spring.factories也是手动创建的文件,在该文件中配置自己的自动配置类
~~~
org.springframework.boot.autoconfigure.EnableAutoConfiguration=com.my.PersonServiceAutoConfiguration
~~~
6. 打包mvn clean install,生成starter的jar包
7. 使用starter 
* 创建新项目，引入starter
* 配置application.properties，如：
~~~
spring.person.name=jack
spring.person.age=28
~~~
* 调用
~~~
@Autowired
private PersonService personService;

@Test
public void testHelloWorld() {
    personService.sayHello();
}
~~~

# 其他SpringBoot学习资料
* http://www.ityouknow.com/springboot/2015/12/30/springboot-collect.html


拦截器功能：
重写WebMvcConfigurerAdapter中的addInterceptors方法把自定义的拦截器类添加进来即可简单的判断是否登录的使用

注解：
@SpringBootApplication是Sprnig Boot项目的核心注解，主要目的是开启自动配置
@RestController 这个注解相当于同时添加@Controller和@ResponseBody注解，用这个注解的类里面的方法都以json格式输出
@Component：让spring在启动的时候扫描到该类，并添加到spring容器中
@Bean：任何一个标注了@Bean的方法，其返回值将作为一个bean定义注册到Spring的IoC容器，方法名将默认成该bean定义的id
@ControllerAdvice 注解，可以用于定义@ExceptionHandler、@InitBinder、@ModelAttribute，并应用到所有@RequestMapping中

@Configuration：任何一个标注了@Configuration的Java类定义都是一个JavaConfig配置类
@ComponentScan：
* 自动扫描并加载符合条件的组件（比如@Component和@Repository等）或者bean定义，最终将这些bean定义加载到IoC容器中
* 可以通过basePackages等属性来细粒度的定制@ComponentScan自动扫描的范围，如果不指定，则默认Spring框架实现会从声明@ComponentScan所在类的package进行扫描
* 所以SpringBoot的启动类最好是放在root package下，因为默认不指定basePackages
@EnableAutoConfiguration：借助@Import的支持，收集和注册特定场景相关的bean定义
@EnableScheduling是通过@Import将Spring调度框架相关的bean定义都加载到IoC容器

