var React = require('react-native');

var {
	View,
	Text,
	StyleSheet,
	Animated,
	Image,
} = React;

var ExitView = React.createClass({
	render:function(){
		return (<View style={styles.container}>
			<Image style={{width:55,height:55}} source={require('image!menuClose')} />
			</View>);
	}
})
var styles = StyleSheet.create({
	container:{
		width:100,
		//backgroundColor:'blue',
		height:100,
		alignItems:'center',
		justifyContent:'center',
	},
})
module.exports = ExitView;