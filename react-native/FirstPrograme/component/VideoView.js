var React = require('react-native');
var TimerMixin = require('react-timer-mixin');
var {
	View,
	Text,
	StyleSheet,
	
} = React;


/*
 * 
 */
var AnimatedView = require('./Animated');
var animatedView = null;
var Video = React.createClass({
	mixins:[TimerMixin],
	
    componentWillMount:function(){
    	console.log('componentWillMount');
    	
    	animatedView = <AnimatedView />;
    	this.setInterval(()=>{
    		animatedView = <AnimatedView />;
    		//alert(animatedView);
    		this.forceUpdate() ;
    	},3500);
    },
	render(){

		return (<View style = {styles.container}>
			{animatedView}
			</View>);
	}
})
var styles = StyleSheet.create({
	container : {
		justifyContent:'center',
	    alignItems:'center',
		height:500,
		backgroundColor:'white',
	},
	
});
module.exports = Video;