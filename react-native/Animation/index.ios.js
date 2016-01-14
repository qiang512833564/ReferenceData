'use strict';
//http://facebook.github.io/react-native/docs/animated.html#content
var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
  LayoutAnimation,
  Animated
} = React;

var FadeInView = React.createClass ({
   
   getInitialState(){
   	return {
       fadeAnim: new Animated.Value(0), // init opacity 0 
       value:0,
     }
   },
   componentDidMount() {
   	 Animated.timing(          // Uses easing functions
       this.state.fadeAnim,    // The value to drive
       {toValue: 1},           // Configuration
     ).start(); 
                  // Don't forget start!
   },
   pressAction(){
     this.setState({
     	value:this.state.value+10,
     });
    // alert(this.state.value);
     this.state.fadeAnim.setValue(0);//这里设置动画的开始值
     Animated.timing(          // Uses easing functions
       this.state.fadeAnim,    // The value to drive
       {toValue: 1},           // Configuration
     ).start(); 
   },//interpolate只能用在Animated.view上，最为他的属性
   //切目前为止，interpolate只有动画有
   render() {
   	//console.log(this.state.fadeAnim);
     var {
     	fadeAnim,
     	value,
     }=this.state;
     //alert();
     return (
     	<View>
       <Animated.View          // Special animatable View
         style={{opacity: this.state.fadeAnim,transform:
         [{translateX:fadeAnim.interpolate({inputRange: [0, 1], outputRange: [0, 100]})}]}}
         
         > 
         <View style={{backgroundColor:'red',flex:1,width:100,height:100,}} />
         
       </Animated.View>
       <TouchableOpacity onPress={this.pressAction}>
       <View style={{backgroundColor:'blue',width:100,height:40}} />
       </TouchableOpacity>
       </View>
     );
   }
});

AppRegistry.registerComponent('AwesomeProject', () => FadeInView);
