---
title: easyui学习知识点小记
tags:
  - Java
  - easyui
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: Java
password: 
---

~~~
第二课
1.	注意js的引入顺序，先Jquery，后EasyUI
2.	引入样式的时候，通过不同主题引入不同的CSS,easyui.css中包括主题包下的所有css样式
3.	通过引入locale下的对应文件则可以实现本地化
4.	通过在js的引入里面指定charset设置引入文件的编码
5.	编码的调试注意这个顺序，当前文档的编码，当前页面内容的编码，引入文件的编码，页面解析文件的编码格式，其他的还可以考虑tomcat、数据库的编码格式
6.	可以通过js往浏览器的控制台打印东西，比alert的方式好，因为这样的话，可以打印出这个东西。如console.info(“你好”);在调试模式之下可以看到此信息。
7.	EasyLodaer功能：动态的加载所需要的EasyUI中的js文件和css文件。

第八课  
1.	Datagrid中有toolbar属性，但是文档中红没有提供，可以自己重写一个toolbar，方法是在页面写一个Div，给出他的id如toolBarId，然后在datagrid的options中设置toolbar：‘#toolBarId’即可。
2.	在数组中可以添加分割符，如[{},’-’,{}]，红色部分则可以转变成为分隔符
3.	如果为datatimebox的话，就要加上editable这个属性为false
4.	Jquery提供了将form表单序列化为字符串serialize或者数组serializeArray的方法，所以如果要将form表单元素的值序列化为元素的值，则需要自己拓展，如提供公共方法：如
SerializeObjexct =function (from){//注意此处为form对象，并非form的Id
		Var o= {};
		$.each(form.serializeArray(),function(index){
				If(o[this[‘name’]]){
	O[this[‘name’]]= O[this[‘name’]]+ “,”+O[this[‘value]];
}else{
O[this[‘name’]]= O[this[‘value]];

}
});
Return o;
}

在调用的地方就可以通过一下方法调用
SerializeObjexct($(“#serchDiv”).form());    //在form外面套用一个serchDiv的div层
这个调用是在datagrid的load方法中使用，load方法的第二个参数实质上就是一个object，也就是上面我们序列化后的对象，而如果要查询所有的的话，就传递一个空的对象。
5.	Datagrid的load方法和reload方法区别：load方法会将当前页改回到第一页，而reload方法会记住当前的页码，这样在查询出来的结果可能分布到其他页，而当前页没有东西，需要自己手动打过去，所以不推荐。Reload方法的使用地点是刷新当前页，而load在刷新的时候是类似重新加载。
6.	注意对js添加命名空间的使用
第九课
1.	给Datarid添加数据点方式可以有dialog方式和行编辑方式，行编辑方式的话，需要给列添加编辑器，如在列的field上添加如下：
editor:{
type:’’,
options:{
	required:’true’
}
}
2.	datagrid的行添加时可以通过appendRow（追加在最后）和insertRow（插入到指定行）方法，指定其index为0即可。在添加行之后，记得通过beginEdit方法开启编辑状态。
3.	通过行编辑状态方式添加记录时候，多次点击添加按钮，会出现多条行编辑状态，这样的话在后台的操作中对于回滚、添加的要求较高；一般可以通过保存当前编辑行，限定只有一个行编辑状态即可。在点击添加的时候记录当前编辑行的索引
4.	添加记录的时候，可以在前台生成UUID后直接将参数传递到后台，这样前台界面上的体验好点。
5.	在editor中只有datebox，没有datatimebox，这样添加时间的时候就不合适，所以需要自己扩展这个editor，具体的代码如下：
![image](/pub-images/datagrid.png)
图中1区就是扩展的editor的名称；通过设置editable=false来限制自由输入。
图中2区是获得editor的值，通过调用特定的被扩展插件的方法设置。图中3区为设置editor的值；
图中4区为设置editor的大小，调用被扩展插件的reseize方法，或者自己计算皆可。
		图中5区为回收当前扩展了的editor的资源。因为当前的被扩展插件datatimebox的下拉框是一个panel，需要释放此资源，否则会影响效率。
	具体的原型来自API中提供的扩展模版，可以参考。
6.	在取消编辑的时候，调用datagrid的rejectEdit方法，记得同时取消所有选择，及调用datagrid的unSelectAll方法。
7.	双击编辑的时候，如果前面还有没有结束的编辑，需要先取消前面的编辑，然后开启当前编辑。
8.	注意在删除多条datagrid中的数据的时候，通过对js中数组的join(“,”);方法的使用。
9.	动态修改行编辑器：如添加密码的时候需要密码框，但是修改的时候就不需要这个框了，可以动态修改编辑器，具体方法可以通过扩展datagrid的方法。
第十课
1.	onAfterEdit中如何知道当前的操作是添加还是修改？可以通过datagrid的getChanges方法的第二个参数，包括inserted，updated等，具体参考文档，getChanges获得的是当前对象的修改过的属性。
2.	datagrid的accepteChanges和rejectChanges方法通过一个类似easyui的缓存list保存当前数据，如果我们在修改之后没有尽快和数据库操作的话，没有确认当前的修改状态，则就算界面上的操作看似已经保存，当我们选中的时候，还是可以回滚的，直到我们accepteChanges，这在数据保存成功之后必须做，否则应该回滚。
3.	在删除成功的时候，在界面success中调用load方法，同时记得一定要调用datagrid的unSelectAll方法
4.	清空本地的datagrid，这个使用loadData方法，区别与load方法，loadData方法会读取本地的缓存数据，并且清空旧的数据。
第十一课
1.	 Datagrid中的columns中的”[[”方式，是为了多级表头的操作
2.	如果在Datagrid中需要forzenColumns的话（其设置和columns是一模一样的），就设置fitColumns为false或者不设置。这样冻结列可以在第一个的设置参照，后面的拖动滚动条只查看感兴趣的列。而fitColumns只在列少的时候设置，这样会比较好看，否则一定要设置为false
3.	可以通过官网的demo和tuturation学习，对于datagrid的创建，亦可以通过table的形式，及html转换成datagrid，只要在平常的datagrid中添加class即可
4.	可以在html中不写js创建datagrid，对于toolbar可以通过在div中设置内容，在table的toolbar属性中通过“#toolbarId”的方式实现toolbar的效果，但是推荐js方式，比较灵活。
5.	用js的方式添加toolbar的话，就只能添加一行，但是可以同过html的形式创建成多行的toolbar，当然也可以通过扩展的形式创建。http://jeasyui.com/是官网地址
6.	可以给datagrid添加右键事件：onRowContextMenu，然后在html中添加一个class为easyui-menu且display为none的div，然后在事件中屏蔽浏览器的事件：通过e.preventDefault();然后显示此菜单即可，显示的时候设置位置为：
Left：e.pageX();
Top：e.pageY();
		其他的辅助操作包括，取消全部选择，选择当前点击右键的行。
此处的e.preventDefault()即阻止事件冒泡的使用。
第十二课
1.	datagrid的formatter的返回是一个字符串，可以在此整理数据，添加事件处理，如title提示（要确保nowrap为true），格式化时间等（这个是在前台操作的，也可以通过相应的json的jar包转换）。
2.	给行列添加样式使用rowStyler和styler，注意其书写顺序：rowStyler写在datagrid中，styler写在columns中
3.	如果要让datagrid的头居中，则可以添加
$(‘.datagrid-header div’).css(‘textAlign’,’center’);
第十三课
1.	Easyui的换肤功能首先要得到皮肤，可以通过官网上获得不同的主题包。通过在引入css的时候先判断一下cookies中的皮肤，如果此处加载用户选择的皮肤，如果更换的时候，需要更改当前link的href（可以给link添加ID的），同时修改cookies的值
2.	更换皮肤的时候，在修改href的地方，如果有iframe中添加样式的话，也记得要修改其href
第十四课
1.	在google浏览器中，不能读取本地的json文件
2.	Esayui生成树有三种方式：
a)	本地html加id或者样式的形式
b)	Html中给个<ul  id=”menu”>,然后在js中url中请求数据(这样就可以构建异步tree了)，可以是本地的json文件
c)	Js中给出变量data，data数组中的数据为tree需要的数据，这样先初始化tree，然后调用tree的load方法加载此数据；或者直接通过data方法赋给tree
3.	在异步书中不需要自己在expand中在此请求数据，因为easyui已经进行了封装，如果自己再在这添加请求的话，会请求两次
4.	异步tree中可以通过lines属性给tree添加框架线；cascadeCheck可以设置是否级联选中菜单项，当获得当前选择的菜单项的时候，这个没有区别，但是在界面选中的时候会有半选状态的样式。
5.	当要将树全部展开的时候，可以在onLoadSuccess中判断，具体如下：
 
这个可以再用来控制展开部分
当然如果确定要一次性展开的话，要在后台递归查询数据，然后将所有菜单数据一次性获得
第十五课
1.	当只想叶子节点出现复选框时，需要设置onlyLeafCheck和CheckBox属性为true
2.	可以对tree通过dbClick事件完成在双击菜单项的时候展开或者折叠菜单
3.	$.fn.tree.defaults.onLoadError=function(){Alert(“实现了”);}可以通过此方法设置默认的tree的操作信息。其他的组件同理。
~~~