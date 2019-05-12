---
title: JOOQ入门
tags:
  - java
copyright: true
comments: true
toc: true
date: 2019-03-06 09:25:33
categories: Java
password:
---

# 简介
官网： http://www.jooq.org/
* JOOQ（Java Object Oriented Querying）即面向Java对象查询，是一个高效地合并了复杂SQL、类型安全、源码生成、ActiveRecord、存储过程以及高级数据类型的Java API的类库
* JOOQ 既吸取了传统ORM操作数据的简单性和安全性，又保留了原生sql的灵活性，它更像是介于 ORMS和JDBC的中间层

# mavan依赖
~~~
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>${mysql.version}</version>
</dependency>
<dependency>
    <groupId>org.jooq</groupId>
    <artifactId>jooq</artifactId>
    <version>${jooq.version}</version>
</dependency>
<dependency>
    <groupId>org.jooq</groupId>
    <artifactId>jooq-meta</artifactId>
    <version>${jooq.version}</version>
</dependency>
<dependency>
    <groupId>org.jooq</groupId>
    <artifactId>jooq-codegen</artifactId>
    <version>${jooq.version}</version>
</dependency>
~~~
SpringBoot依赖
~~~
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-jooq</artifactId>
</dependency>
~~~
代码生成依赖
JOOQ需要通过APT动态生成需要的Java类，所以需要配置Maven插件
~~~
<build>
    <plugins>
        <plugin>
            <groupId>org.jooq</groupId>
            <artifactId>jooq-codegen-maven</artifactId>
            <version>${jooq.version}</version>
            <executions>
                <execution>
                    <goals>
                        <goal>generate</goal>       //配置后mvn compile的时候执行apt
                    </goals>
                </execution>
            </executions>
            <dependencies>
                <dependency>
                    <groupId>mysql</groupId>
                    <artifactId>mysql-connector-java</artifactId>
                    <version>${mysql.version}</version>
                </dependency>
            </dependencies>
            <configuration>
                <jdbc>
                    <url>jdbc:mysql://localhost:3306/foo</url>
                    <user>root</user>
                    <password>root</password>
                </jdbc>
                <generator>
                    <database>
                        <includes>.*</includes>
                        <inputSchema>foo</inputSchema>
                    </database>

                    <target>
                        <packageName>jooq</packageName>
                        <directory>${basedir}/target/generated-sources/java</directory>
                    </target>
                </generator>
            </configuration>
        </plugin>
    </plugins>
</build>
~~~
显示执行: mvn jooq-codegen:generate
隐式执行: mvn compile

# 集成数据源
只需要重写getDSLContext 方法，以durid数据源为例：
~~~
private DSLContext getDSLContext() {
    DruidDataSource dataSource = new DruidDataSource();
    dataSource.setUrl("jdbc:mysql://localhost:3306/test");
    dataSource.setUsername("root");
    dataSource.setPassword("root");
    dataSource.setMaxActive(20);
    dataSource.setMaxWait(20_000);
    dataSource.setMinIdle(0);
    dataSource.setTestOnBorrow(true);
    dataSource.setTestWhileIdle(true);
    dataSource.setInitialSize(1);
    dataSource.setMinEvictableIdleTimeMillis(1000*60*10);
    dataSource.setTimeBetweenEvictionRunsMillis(60*1000);
    dataSource.setPoolPreparedStatements(true);
    dataSource.setMaxPoolPreparedStatementPerConnectionSize(20);
    dataSource.setValidConnectionChecker(new MySqlValidConnectionChecker());
    ConnectionProvider connectionProvider =  new DataSourceConnectionProvider(dataSource)
    Configuration configuration = new DefaultConfiguration()
      .set(connectionProvider)
      .set(SQLDialect.MYSQL);
    return DSL.using(configuration);
  }
~~~

# 事物支持
~~~
ConnectionProvider connectionProvider =  new DataSourceConnectionProvider(dataSource)
TransactionProvider transactionProvider = new DefaultTransactionProvider(connectionProvider, false);
Configuration configuration = new DefaultConfiguration()
      .set(connectionProvider)
      .set(transactionProvider)
      .set(SQLDialect.MYSQL);
return DSL.using(configuration);
~~~

参考：https://www.cnblogs.com/chinajava/p/5832378.html'


Spring自定义配置的IDE提示，需要使用APT技术，需要添加依赖spring-boot-configuration-processor