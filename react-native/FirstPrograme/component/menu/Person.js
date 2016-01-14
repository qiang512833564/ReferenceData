var React = require('react-native');
var TimerMixin = require('react-timer-mixin');
var {
	View,
	Text,
	StyleSheet,
	Animated,
	Image,
	Easing,
} = React;

var PersonView = React.createClass({
	mixins:[TimerMixin],
	getInitialState:function(){
		return {
			transformX:new Animated.Value(0),
		};
	},
	componentWillReceiveProps(nextProps){
	if(nextProps.isShowing === 0)
	{
		return;
	};	
		//alert('componentWillReceiveProps')；
		this.state.transformX.setValue(100);     // Start large设置动画开始值
    this.setTimeout(
      () => { 
      
      	 Animated.spring(                          // Base: spring, decay, timing
      this.state.transformX,                 // Animate `bounceValue`
      {
      	//fromValue:100,
      	//duration:10000,无效
      	easing:Easing.out(Easing.ease),//Easing.bezier(0.4, 0, 1, 1)第一个参数是速度
        toValue: 0,                         // Animate to smaller size
        //friction:5,  
        speed:20,                        // Bouncier spring--bounciness(speed)--tension(friction)--两组只能同时设置一组
        bounciness:8,
        delay:1000,
         //tension: 80,//速度
       // overshootClamping:true,//取出超出位置的动画
       // restDisplacementThreshold:10,
       // 
      }
    ).start();                                // Start the animation
      	 },
      500
    );
	},
	
	render:function(){
	var	container = {
		width:100,
		backgroundColor:'transparent',
		height:100,
		alignItems:'center',
		justifyContent:'center',
		transform:[{translateX:100}],
		marginTop:20,
		transform: [{translateX: this.state.transformX}],
	};
	
		return (
		<Animated.View style={container}> 
			      <Image style={{width:49,height:49}} source={require('image!menuPlayer')} />
	     </Animated.View>
	     );
	}
})
var styles = StyleSheet.create({
	
})
module.exports = PersonView;
