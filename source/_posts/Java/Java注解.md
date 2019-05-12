---
title: Java注解
tags: 
  - java
copyright: true
comments: true
toc: true
date: 2019-03-24 18:41:51
categories: java
password:
--- 

https://www.imooc.com/learn/456

# Java中的常见注解
## JDK自带注解
1. @Override
2. @Deprecated
3. @SuppressWarnings("deprecation")

## 常见第三方注解
Spring（@Autowired,@Service,@Repository...）,Mybatis(@InsetProvider,@UpdateProvide...)...

## 自定义注解
Description.java
~~~
import java.lang.annotation.*;

@Target({ElementType.METHOD,ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
@Documented
public @interface Description {
    String desc();
    int age() default 18;
}
~~~
* @interface表示是定义注解
* 成员必须以无参无异常方式声明；可通过defalut给出默认值
* 成员的类型是受限制的，只能是基本类型、String、Class、Annotaion、Enumeration
* 如果注解只有一个成员，成员名称必须为value(),在使用时可忽略成员名和赋值号
* 注解类可以没有成员，没有成员的注解称为标识注解

元注解：注解的注解
* @Target：表示注解的作用域，如ElementType.METHOD-方法，ElementType.TYPE-类，接口
* @Retention：生命周期，如：SOURCE（只在源码显示）、CLASS（编译时记录到class中，运行时忽略）、RUNTIME（运行时存在，可通过反射读取）
* @Inherited：表示允许子注解继承,此继承表示子类如果没有自定义此注解的话会继承父类的注解信息（类注解信息）
* @Documented：表示生成Javadoc时包含注解的信息

使用自定义注解的语法：
~~~
@注解名(成员名1=成员值1，成员名2=成员值2,...)
==========================================
@Description(desc="annotation test",age=20)
public String test(){
    return "test my annotation"
}
~~~

# 注解的分类
按照运行机制
* 源码注解：注解只在源码存在，编译成.class文件就没有了
* 编译时注解：注解在源码和.class文件中都存在，上面JDK自带注解就属于这一类
* 运行时注解：在运行阶段还起作用，设置会影响程序的运行逻辑，如@Autowired

# 解析注解
通过反射获取类、函数或成员上的运行时注解信息，从而实现动态控制程序运行的逻辑
~~~
package com.anno.test.demo;

@Description(desc="TestAnno class annotaion desc",age=10)
public class TestAnno {
    @Description(desc="TestAnno class method annotaion desc",age=1)
    public String test(){
        return "Hello";
    }
}
~~~
解析
~~~
try {
    //1 使用类加载器加载类
    Class clazz = Class.forName("com.anno.test.demo.TestAnno");
    //2 找到类上面的注解
    boolean isExistAnno = clazz.isAnnotationPresent(Description.class);
    if(isExistAnno){
        //2.1 拿到注解实例
        Description description = (Description) clazz.getAnnotation(Description.class);
        //2.2 获取注解值
        System.out.println(description.desc()+"   "+ description.age());
    }

    //3 找到方法上的注解
    Method[] methods = clazz.getMethods();
    for (Method method:methods) {
        boolean isMethodExistAnno = method.isAnnotationPresent(Description.class);
        if(isMethodExistAnno){
            //3.1 拿到注解实例
            Description description = (Description) method.getAnnotation(Description.class);
            //3.2 获取注解值
            System.out.println(description.desc()+"   "+ description.age());
        }
    }
    
    //4 另一中方式获取方法上的注解
    for(Method method :methods){
        Annotation[] ans = method.getAnnotations();
        for(Annotation an:ans){
            if(an instanceof Description){
                Description description = (Description)an;
                System.out.println(description.desc()+"   "+ description.age());
            }
        }
    }
} catch (ClassNotFoundException e) {
    e.printStackTrace();
}
~~~

# 项目实战
Hibernate注解生成sql的模仿：
* 表注解
~~~
package com.anno.test.demo;
import java.lang.annotation.*;
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
@Documented
public @interface Table {
    String value();
}
~~~
* 字段注解
~~~
package com.anno.test.demo;
import java.lang.annotation.*;
@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
@Documented
public @interface Column {
   String value();
}
~~~
* 实体类
~~~
package com.anno.test.demo;
import lombok.Data;
@Data
@Table("User")
public class UserFilter {
    @Column("id")
    private long id;
    @Column("name")
    private String name;
    @Column("email")
    private String email;
}
~~~
* 调用
~~~
public static void testAnno()  throws Exception {
    UserFilter filter1 = new UserFilter();
    filter1.setId(100);

    UserFilter filter2 = new UserFilter();
    filter2.setName("jack");

    UserFilter filter3 = new UserFilter();
    filter3.setEmail("abc@163.com,111@qq.com");

    String sql1 = query(filter1);
    String sql2 = query(filter2);
    String sql3 = query(filter3);

    System.out.println(sql1);   //select * from User where 1=1  and id=100
    System.out.println(sql2);   //select * from User where 1=1  and id=0 and name='jack'
    System.out.println(sql3);   //select * from User where 1=1  and id=0 and email in('abc@163.com','111@qq.com')
}

 public static String query(UserFilter filter) throws Exception {
    StringBuffer sb = new StringBuffer();
    //1 获取UserFilter类类型
    Class clazz = Class.forName("com.anno.test.demo.UserFilter");
    //2 获取table的名称
    boolean isExistTableAnno = clazz.isAnnotationPresent(Table.class);
    if(isExistTableAnno){
        Table table = (Table)clazz.getAnnotation(Table.class);
        String tableName = table.value();
        sb.append("select * from ").append(tableName).append(" where 1=1 ");
    }
    //3 遍历所有字段
    Field[] fields = clazz.getDeclaredFields();
    for(Field field:fields){
        //获取字段名称及值
        boolean isExistColumnAnno = field.isAnnotationPresent(Column.class);
        if(isExistColumnAnno){
            Column column = field.getAnnotation(Column.class);
            String columnName = column.value();
            //拼装get属性方法
            String fieldName = field.getName();
            String getMethodName = "get"+fieldName.substring(0,1).toUpperCase() + fieldName.substring(1);
            Method getMethod = clazz.getMethod(getMethodName);
            Object fieldValueObj = getMethod.invoke(filter);
            if(fieldValueObj == null || (fieldValueObj instanceof Long && (Long)fieldValueObj==0))
                continue;
            sb.append(" and ").append(columnName);
            if(fieldValueObj instanceof String) {
                if(((String) fieldValueObj).contains(",")){
                    String[] values = ((String) fieldValueObj).split(",");
                    sb.append(" in(");
                    for(String v:values){
                        sb.append("'").append(v).append("'").append(",");
                    }
                    sb.deleteCharAt(sb.length()-1);
                    sb.append(")");
                }else{
                    sb.append("='").append(fieldValueObj).append("'");
                }
            }else if(fieldValueObj instanceof Long){
                sb.append("=").append(fieldValueObj);
            }
        }
    }
    return  sb.toString();
}
~~~
测试代码路径：https://gitee.com/chetaofeng/myannotation.git