---
title: "Singleton设计模式实现方案（基于java）"
date: "2014-05-29T19:48:03+08:00"
categories:
tags:
---

                                            
先看两种常用的实现方案：


实现方案1------懒汉式


```java
public class Singleton{
    private static Singleton instance = null;

    private Singleton(){
    }

    public static Singleton getInstance(){
        /*这里体现了延迟加载，马上要使用这个实例了，还不知道它是否已存在，所以要先判断一下,
        如果没有，就创建一个。也就是说该方案“懒”到直到第一次要用这个实例时才开始创建它。*/
	if(instance == null)
            instance = new Singleton();

	return instance;
    }
}

```

实现方案2-----饿汉式


```java
public class Singleton{
    private static Singleton instance = new Singleton();

    private Singleton(){
    }
    
    public static Singleton getInstance(){
        return instance;
    }
}
```






时间和空间


        比较两种写法，懒汉式的实现体现了缓存的思想，是典型的以时间换空间的方案，也就是说每次获取实例都会进行判断，看是否需要创建实例，浪费判断时间。当然，如果一直没有使用的话，那就不会创建实例，则节约内存空间；而饿汉式与前者相反，是在用空间换时间。



关于线程安全


       从线程安全性上讲，不加同步的懒汉式是线程不安全的，即当两个或多个线程同时执行时，可能会并发的创建出两个或多个实例；而饿汉式则是线程安全的，因为虚拟机保证只会装载一次，在装载类的时候不会发生并发。

       如何实现懒汉式的线程安全呢？只需对getInstance做如下修改：


```java
        public static synchronized Singleton getInstance(){……}
```




      但这样会整个访问的速度，而且每次都要判断。是否有更好的方式来实现？



双重检查加锁



        所谓双重检查加锁机制，是指：并不是每次进入getInstance方法都要同步，而是在进入方法后，先检查实例是否存在，如不存在，才进入同步块，这是第一重检查；进入同步块后，再次检查实例是否存在，如不存在，就在同步的情况下创建一个实例，这是第二重检查。这样以来就只需要一次同步了，可减少在多次同步情况下进行判断所浪费的时间。

        而双重检查加锁机制的实现要用到一个关键字volatile，它的意思是：被volatile修饰的变量的值，将不会被本地线程缓存，所有对该变量的读写都是直接操作共享内存，从而确保多个线程能正确地处理该变量（注：据说，java 1.4及其之前的版本，很多JVM对于volatile的实现有问题，因此，双重检查加锁机制只能用在java 1.5及其以后的版本上）。

        懒汉式修改后的代码：



```java
public class Singleton{
    private volatile static Singleton instance = null;

    private Singleton(){
    }

    public static Singleton getInstance(){
        if(instance == null){
	     synchronized(Singleton.class){
	         if(instance == null)
	              instance = new Singleton();
	    }
        }
	return instance;
    }
}
```



更好的实现方式

        显然，这两种常见的单例实现方式都存在一些小小的缺陷，那么有没有一种方案，既能够实现延迟加载，又能轻易实现线程安全，而且还能不必使用判断而节约时间呢？

        这就是Lazy initialization holder class 模式：使用内部类，即可轻而易举地实现鱼和熊掌的兼得。代码如下：




```java
public class Singleton{
    private static class SingletonHolder{
         private static Singleton instance = new Singleton();
    } 

    private Singleton(){
    }
    
    public static Singleton getInstance(){
        return SingletonHolder.instance;
    }
}
```






        由此可见，对于某些问题，有时候，提出一个新的解决方案，要比在原有方案的基础上不断地打补丁来得更为简单和高效。不过，要想出这种精巧的主意，没有一定的知识经验的积累和创新思维的能力也是不行的。






