
'use strict';
//方法里：function(){return ();},return后面跟得是()小括号
//结构体、对象赋值的时候，一般都是加在{结构体}中括号里面
//结构体，赋值啥的用逗号，其余一个语句基本都是用分号；
//<Text>{字符串要在大括号里面}</Text>
//flex貌似不能和width，height同时使用,flex也不能和 padding 一起使用
var React = require('react-native');
var Carousel = require('./MessageView');
var {
	View, 
	Text,
  StyleSheet,   
  ListView,
  Image,
  TouchableHighlight
}= React;

var RefreshableListView = require('react-native-refreshable-listview');
var delay = require('react-native-refreshable-listview/lib/delay');
var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;
// make an array containing a sequence of numbers from 0..n
var makeSequence = (n) => Array.apply(null, {length: n}).map((v, i) => i);
var messageList = React.createClass({
	
  
  //从本地加载json数据
  
  componentWillMount:function(){
  	fetch('http://localhost:8081/rest/messages.json')
  	  .then(res=>res.json())
  	  .then(res=>this.updateDataSource(res));
  },
  updateDataSource: function(data){
    this.setState({
      dataSource: this.state.dataSource.cloneWithRows(data)
    })
  },
  getInitialState:function(){
  	var ds = new ListView.DataSource({
        rowHasChanged: (r1, r2) => r1 !== r2});
  	// var rows = makeSequence(100).map((n) => ({text: 'not refreshed '+n}))
    return {dataSource: ds}
  },
  
   openChat: function (user){
    this.props.navigator.push({
      title: `${user.firstName} ${user.lastName}`,//'大头',设置导航栏上面的title
      component: Carousel,//push展示的组件
      passProps: { user }//传递的参数
    });
  },
  renderRow:function(person){//cell的高度，会自动根据最大的子控件高度来计算
  	return (
 
      <TouchableHighlight onPress={this.openChat.bind(this,person.user)}>
  		<View style={styles.row}>
  		    <Image 
  		    style={styles.headImage}
  		    source={{uri:person.user.picture}}
  		    />
  		    <View style={styles.textContainer}>
  		    <Text style={styles.name}>
  		       {person.user.firstName} {person.user.lastName}
  		    </Text>
  		    </View>
  		</View>
  	 </TouchableHighlight>
  	);
  },
reloadItems() {
    return delay(1000).then(() => {
      var rows = makeSequence(100).map((n) => ({
		"user": {
			"firstName": "Laurie",
			"lastName": "Hunt",
			"picture": "https://randomuser.me/api/portraits/women/9.jpg",
			"userID": 1
		},
		"lastMessage": {
			"contents": "Hey there!",
			"timestamp": 1431300318000
		}
	}))
      this.updateDataSource(rows);
    })
  },
  
	render:function(){
		return (
			
			<View style={styles.listStyle}>
   			  <RefreshableListView
        dataSource={this.state.dataSource}
        renderRow={this.renderRow}
        loadData={this.reloadItems}
        refreshDescription="下拉刷新"
      />
			</View>
			
		);
	}
});
var messagesTab = React.createClass({
  
  render: function() {
    return (
      <React.NavigatorIOS
        style={ styles.container }
        initialRoute={
          {
            title: 'Messages',
            component: messageList
          }
        }
        />
    );
  }
});
var styles = React.StyleSheet.create(
{
  container: {  
    flex: 1  ,
    backgroundColor: '#fff'
  }, 
  row:{
  	flexDirection: 'row',
  	alignItems: 'center',//排布居中，
  	backgroundColor: 'white',//这个会影响cell被选中的颜色
  	borderBottomColor: 'rgba( 0, 0, 0, 0.1 )',
    borderBottomWidth: 1,
    padding: 10
  },//默认是竖直方向的，这里改为横方向上的。即：子视图的排布是水平方向的
  textContainer: {
    flex: 1,
    //backgroundColor:'blue'
    // padding = 10
  },
  listStyle:{
  	flex:1,
  	//backgroundColor:'red',
  	paddingBottom:40
  },
  headImage:{
  	//flex:1
  	//paddingTop = 10,
  	// paddingLeft = 10,
  	// paddingBottom = 10,
  	borderRadius:30,
  	width:60,
  	height:60
  }, 
  name:{
  	paddingBottom:40,
  	paddingLeft:20
  },
  
}
);
module.exports = messagesTab;


