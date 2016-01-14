'use strict';

var React = require('react-native');
var Types = require("./Types");
var {
  StyleSheet,
  Text,
  View,
  NavigatorIOS,
  TouchableHighlight
  } = React;

var messageView = React.createClass({
  /*
   * 常用的通知 React 数据变化的方法是调用 setState(data, callback)。
   * 这个方法会合并（merge） data 到 this.state，并重新渲染组件。
   * 渲染完成后，调用可选的 callback 回调。大部分情况下不需要提供 callback，因为 React 会负责把界面更新到最新状态。
   * 
   * 大部分组件的工作应该是从 props 里取数据并渲染出来。
   * 但是，有时需要对用户输入、服务器请求或者时间变化等作出响应，这时才需要使用 State。
   * this.state 应该仅包括能表示用户界面状态所需的最少数据
   * State 应该包括那些可能被组件的事件处理器改变并触发用户界面更新的数据
   */
  getInitialState:function()
  {
  	return {
  		backgroundColor:'yellow'
  	};
  },
  onTouchPress:function (info){
  	console.log('Press!');
    	this.setState({backgroundColor:"red"});
    	//this.scrollView().setSate = {all:[]};readonly
        //this.scrollView().prinftLog();也是不可以的
       // this.scrollView().props = {vaule:'缺省值'};也是readonly
        //console.log(this.scrollView().myValue);
        console.log(JSON.stringify(this.scrollView().props));//this.scrollView().props
        //Types.mylog();
  },
  /*
   * return(对象)，return{结构体}
   */
  scrollView(){
  	return (<Types  value={100} myValue={800}/>);//对象的props在这里可以设置,这里设置了也会改变getDefaultProps方法里面的
  },
  render: function(){
    var user = this.props.user;
    //this.props.navigator.hidden = 0 ;
    
    return (
      <TouchableHighlight onPress={this.onTouchPress.bind(this,'info')}>
      <View style={ {flex: 1,paddingTop: 64, backgroundColor:this.state.backgroundColor}}>
        <Text>Chat with { user.firstName } { user.lastName }</Text>
        {this.scrollView()}
      </View>
      
      </TouchableHighlight>
      
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 64
  },
});

module.exports = messageView;