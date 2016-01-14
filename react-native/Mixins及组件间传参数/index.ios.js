/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * mixins:是为了组件 之间共享某个属性、或者方法
 */
'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Component,
  TouchableWithoutFeedback,
} = React;
//这段代码可以单独写在一个文件夹里面，但是在代码末尾也要加上module.exports = DefaultNameMixin;代码
//可以通过require('文件名称')来包含进来，只要包含了，可以在任何组件里使用
var DefaultNameMixin = {
	getDefaultProps:function(){
		return {name:'Skippy'};
	},
	setTimer:function(fun)
	{
		fun("txt.file");
	}
};
var test = function myConstructor(){
	this.name = "构造函数为myConstructor";
}
var MixinComponent = React.createClass({
	mixins:[new test()],//这样子也是可以使用的，因为加入的是一个构造函数对象
	//下面的这些方法-----是从上往下的顺序的，先加载，当接收到新参数时候，再询问是否更新，然后进行更新
	componentDidMount(){
		this.text="参数";//这样对外设置的参数，也是对外的参数---就像js的构造函数一样
		console.log('componentDidMount');
	},
	//x下面的这些方法，第一次加载组建的时候，是不会被调用的。仅仅是第二次都参数传进来的时候，才会被吊用的
	componentWillReceiveProps(nextProps) {
		
		console.log('接收到新参数');
		//this.forceUpdate();
	},
	shouldComponentUpdate(nextProps, nextState) 
	{
		console.log('shouldComponentUpdate');
		return true;//如果这里返回值是false，则组件不会更新UI
	},
	componentWillUpdate(nextProps, nextState) 
	{
		console.log('componentWillUpdate');
	},
	componentDidUpdate(prevProps, prevState) 
	{
		console.log('componentDidUpdate');
	},
	omponentWillUnmount(){
		console.log('omponentWillUnmount');
	},
	render:function(){
		return (<Text style={{opacity:this.props.opacity}}>"我仅仅只是个测试的"{this.text}{this.name}</Text>);
	}
});
//可以在
var InteractionBetweenComponents = React.createClass({
//在这里面用,逗号
  getInitialState:function(){
  	return {
  		opacity:0
  	};
  },
  mixins:[DefaultNameMixin],//这样以后，就被加入到this组件的props里面了
  //mixin仅仅只能是一个常规的对象，而不能是一个组件
  render: function() {
  	this.setTimer((text)=>alert(text));
  	this.props={name:"china"};//这样是可以改掉的，但是把props里面所有的属性都改掉了
  //	this.setProps({name:'china'});这样也不好使，报错：提示-仅仅使当组件被创建的时候，去设置props
  //在这里面用;分号
    return (
      <View style={styles.container}>
      <TouchableWithoutFeedback onPress={this.action.bind(this)}>
         <Text>Hello {this.props.name}</Text>
         </TouchableWithoutFeedback>
         <MixinComponent opacity={this.state.opacity} parameter="canshu" ref={component=>this.subComponent=component}/>
      </View>
      
    );
  },
  action(){
  	//alert('点击事件');
  	this.subComponent.props={text:"0"};//貌似也是不可以的
  	this.subComponent.text="新参数";//这个是有效de 
  	this.setState({
  		opacity:1
  	});
  	
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
//第一个InteractionBetweenComponents项目名称
//第二个是这里的类名
AppRegistry.registerComponent('InteractionBetweenComponents', () => InteractionBetweenComponents);
