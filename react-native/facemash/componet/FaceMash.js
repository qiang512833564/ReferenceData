
'use strict';
 
var React = require('react-native');//用require()函数引入React库
 
var {
  StyleSheet,
  Text,
  View,
  Image,
  ActivityIndicatorIOS,
  TouchableHighlight
  } = React;
 
var facemashTab = React.createClass({
  getInitialState:function(){
  	return{
  		//初始化常量
  		list:[],
  		currentIndex:0
  	};
  },
  //从本地加载json数据
  componentWillMount:function(){
  	fetch('http://localhost:8081/rest/mash.json')
  	  .then(res=>res.json())
  	  .then(res=>this.setState({list:res}))
  	  .catch(err => console.log(err));
  },
  onPersonPress: function() {
    
    	if (this.state.currentIndex+1 == this.state.list.length)
    	{
    		this.setState({currentIndex:0});//this.setState()调用的时候，会刷新显示
    	}else
    	{
    		this.setState({currentIndex: this.state.currentIndex + 1});
    	}
      
   
  },
  render: function() {
  	
  	var contents;
  	if (!this.state.list.length) {//组件可以通过this.state保持内部状态数据。当一个组件的状态数据的变化，展现的标记将被重新调用render()更新
      contents = (
        <View style={ styles.loading }>
          <Text style={ styles.loadingText }>Loading</Text>
          <ActivityIndicatorIOS />
        </View>
      )
    } else {
    	var {list, currentIndex }= this.state;
    	var record = list[currentIndex];
    	var people = record.users.map(person => <Person person={ person } onPress={ this.onPersonPress } />);
    	//<Person person={ person } onPress={ this.onPersonPress } />)传递的参数之间，不需要加，分隔，只需要加空格就行
    	//var people = record.users.map(per=> <Person person={ per } onPress={this.onPersonPress}/>);//person=>表示字典匹配,<Person/>表示初始化一个Person对象，person={ person }表示传入参数（名字为person），在Person的初始化组件（React.createClass）可以通过this.props.person去调用
                      //users是字典record中的key，map表示遍历或者修改子节点（在这里是遍历数组）
                      //per表示map(per)遍历到得元素
                      //=>操作符常用于数组操作中，一个对应关系（->一般是类方法的调用）
                      //貌似这里会调用两次，因为map()数组有两个元素
                      //map(里面可以是一个元素，也可以是一个function(){但是方法里面必须要有return语句返回一个对象})
                      //arr.map()返回的结果是整个数组，但是唯一不同的是，该数组里面的元素都是被map()重新设置过的
      contents = (
        <View style={ styles.content }>
           {people}
        </View>
      )
    }
    return (
    	/*
    	 这里返回的视图，是需要在界面上显示的
    	 { contents }直接加载自定义的视图content=();
    	 */
      <View style={ styles.container }>
        <View style={ styles.header }>
            <Text style={ styles.headerText }>FaceMash</Text>
        </View>
        <View style={ styles.content }>
          <Text>
            FaceMash tab!
          </Text>
        </View>
        { contents }
      </View>
    );
  }
});
/*
 展示外部的图片
不同于我们的 tab 图标，我们用来展示的每一个用户的图片都来自一个外部的源. 这不是问题，事实上展示它们要比展示静态资源更加简单.
我们只是向 Image 组件传递一个对象，而不是向它传入一个需要的图片. 这个对象会有一个属性—— url，它会指向我们想要加载的图片.
当我们将用户信息作为一个叫做person的属性进行传递时，我们可以通过 this.props.person.picture 访问到图片的 URL。
 */
var Person = React.createClass({//创建一个组件类，并作出定义，组件实现render（）方法，该方法返回一个子级
  render: function() {//React组件通过render()方法，接受输入的参数并返回展示的对象
    var person = this.props.person;//this.props接受输入数据，自父级向下级传递
    return (
    	//组件不需要来实例化View对象
    	<TouchableHighlight onPress={ this.props.onPress }>
      <View style={ styles.person }>
     
           <Image style={ styles.personImage } source={{ uri : person.picture}} />
           
           <View>
           <Text style={ styles.personName }>Person!</Text>
           </View>
      </View>
      </TouchableHighlight>
      
    )
  }
});
var styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff'
  },
  loading: {
    flex: 1,
    backgroundColor: '#fff',
    justifyContent: 'center',
    alignItems: 'center'
  },
  /*
   不允许有负值
   内边距：
   padding : 四边统一内边距
   paddingTop
   paddingBottom
   paddingLeft
   paddingRight
   
   外边距：
   margin属性来设置四个方向的外边距
   marginTop
   marginBottom
   marginRight
   marginLeft
   
   其实说白了padding就是内容与边框的空隙.而margin 则是模块与模块的空隙.
   */
  loadingText: {
    fontSize: 14,
    marginBottom: 20
  },
  content: {
    padding: 9
  },
  header: {
    height: 50,
    backgroundColor: '#760004',
    paddingTop: 20,
    alignItems: 'center'
  },
  headerText: {
    color: '#fff',
    fontSize: 20,
    fontWeight: 'bold',
    alignItems: 'center'
  },
  person:{
  	flex:1,
  	margin:10,
  	borderRadius:8,
  	overflow:'hidden',//超过的隐藏，相当于lay.maskToBounds = yes
  	//backgroundColor:'black',
  	borderWidth:1,
  	borderColor:'rgba( 0, 0, 0, 0.1 )'
  },
  personName:{
  	padding: 10,//相对于上一个视图来说的
  	color:'red'
  },
  personImage:{
  	flex:1,
  	height:200
  }
});
 
module.exports = facemashTab;
