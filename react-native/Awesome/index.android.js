/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var Home=require('./component/Home.js');
var Easing = require('Easing');
//var ActivityView=require('react-native-activity-view');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image,
  ToastAndroid,
  TouchableOpacity,
  Animated,
} = React;
var AlertView=React.createClass({
	render(){
		return (
			<View style={{backgroundColor:'white',width:200,height:250}}>
			<Image source={require('image!mywallet')} style={{position:"absolute"}} />
			   <Text style={{top:10,left:10,right:10,color:'#779c2d',fontFamily:"华文彩云",fontSize:27}}>祝你生日快乐，快点打开有惊喜哟</Text>
			   <TouchableOpacity onPress={this.onPressAction.bind(this)}>
			   <View style={{marginTop:80,height:68,justifyContent: 'center',alignItems: 'center',}}>
			     <Text style={{top:10,left:10,right:10,color:'#dd00cd',fontFamily:"华文彩云",fontSize:27}}>点击拆开</Text>
			   </View>
			    </TouchableOpacity>
			</View>
			);
	},
	onPressAction:function(){
		this.props.onPress();
	},
});
var Awesome = React.createClass({
  getInitialState:function(){
  	return {
  		bounds:new Animated.Value(0),
  		openWallet:false,
  	};
  },
  componentWillMount:function(){
  	ToastAndroid.show('moment1', 2000)
  Animated.spring(this.state.bounds,{
  	     toValue: 1, 
  	     easing:Easing.out(Easing.ease),
  	     speed:15,                        // Bouncier spring--bounciness(speed)--tension(friction)--两组只能同时设置一组
         bounciness:13,
  	     duration:500 
  	}).start();
  },
  componentDidMount:function(){
  	
  	
  },
  //
  onPressAction:function(){
  	this.setState({
  		openWallet:true,
  	});
  },
  render: function() {//
  	ToastAndroid.show('moment2', 2000)
  	let homeView=(
  	    this.state.openWallet==false?
  		(<View style={{flex:1,backgroundColor:'#2e3331',opacity:0.85,justifyContent: 'center',alignItems: 'center',}}>
  	         <Animated.View style={{transform:[{scale:this.state.bounds}]}}>
  	            <AlertView onPress={this.onPressAction.bind(this)}/> 
  	         </Animated.View>
  	    </View>)
  	    :
  	    (<Home />)
  	    );
  	ToastAndroid.show('This is a birthday for excitedly moment', 2000)
  	return (//require('image!foreback')
  	    <View style={styles.container}>
  		<Image source={require('image!mobal')} style={{position:"absolute"}} resizeMode='stretch' />
  		   {homeView}
  		   
  		</View>
  		);
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    // justifyContent: 'center',
    // alignItems: 'center',
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

AppRegistry.registerComponent('Awesome', () => Awesome);
