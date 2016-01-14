var React = require('react-native');
var Button = require('react-native-icon-button');
var TimerMixin = require('react-timer-mixin');
var AnimatedText = require('./AnimateText.js');
var ScrollComponent=require('./ScrollViewComponent');
//var ActivityView=require('react-native-activity-view');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
} = React;

var describedText = "小雪人生很奇妙，或许是缘分或许是什么的让二个完全没可能认识的人认识了，而当我第一次看到你就觉得你在的地方其他都是背景。虽然我认识你才一个月左右但是感觉好像认识了好久好久。而今天为你过生日我只想和你说一句话:“小雪你过来，我有场恋爱想和你谈谈。”"
var txtLocation = 0
var Home = React.createClass({
  getInitialState:function(){
  	return {
  		text:"",
  		showingAnimated:true
  	};
  },
  componentWillMount:function(){
  
  },
  componentDidMount(){
  	this.timer = setInterval(()=>{this.setState({text:describedText.substring(0,txtLocation)})},100);
    //虽然并没用初始化timer属性，但是这样子js会自动创建一个timer属性
    
  	
  },
  mixins:[TimerMixin],
  render: function() {
  	
  	txtLocation++;
  	if(txtLocation==describedText.length+1)
  	{
  		clearInterval(this.timer);
  		delete(this.animatedTexting);
  		//this.animatedTexting.hidden='true';
  		this.setTimeout(()=>{this.setState({showingAnimated:false});},2500);//注意这里，容易形成死循环，程序崩溃
  	}
  	var animatedTxt = (this.state.showingAnimated==false?(<ScrollComponent />) : (<AnimatedText text={this.state.text} ref={component=>this.animatedTexting=component} style={{overflow:"hidden",}}/>));
    return (
      <View style={styles.container} >
        {animatedTxt}
      </View>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    // justifyContent: 'center',
    // alignItems: 'center',
    backgroundColor: 'transparent',
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

module.exports=Home;