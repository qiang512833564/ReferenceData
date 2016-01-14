var React = require("react-native");
var {
	View,
	Text,
	StyleSheet,
	PropTypes,
}=React;
var AnimatedText = React.createClass({
	propTypes:{
		text:PropTypes.string,
	},
	render:function(){
		var text = (typeof this.props.text === "undefined" ?"":this.props.text);
		return (
			<View style={styles.container}>
			  <Text style={{color:'#779c2d',fontFamily:"华文彩云",fontSize:27}}>{text}</Text>			
			</View>);
	}
});
var styles = StyleSheet.create({
	container:{
		backgroundColor:'red',
		marginTop:100,
		marginBottom:100,
		marginLeft:10,
		marginRight:10,
		flex:1,
		backgroundColor:'transparent',
		overflow:"hidden",
	    //hidden:false,
	},
});
module.exports=AnimatedText;