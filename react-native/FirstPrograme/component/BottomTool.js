var React = require('react-native');
var MyButton = require('./MyButton');
var Dimensions = require('Dimensions');
var { width, height, scale } = Dimensions.get('window');//应该是获取屏幕的宽，高，比例
var {
	View,
	Text,
	StyleSheet,
	TouchableOpacity,
	Image,
} = React;

var Tool = React.createClass({
	_onPressButton(){
	    	// alert('action');
	    },
	render:function(){
		var width = 0;
		/*
		 * <View style={{width:40,
		backgroundColor:'red',
		height:40,}}/>
		 */
		
		return (<View style={styles.container}>
			      <TouchableOpacity onPress={this._onPressButton}>
			      <Image style={styles.button} source={require('image!pause')}>
			      </Image>
			      </TouchableOpacity>
			      
			      <TouchableOpacity onPress={this._onPressButton}>
			      <Image style={styles.button} source={require('image!heart1')}>
			      </Image>
			      </TouchableOpacity>
			      
			      <TouchableOpacity onPress={this._onPressButton}>
			      <Image style={styles.button} source={require('image!delete')}>
			      </Image>
			      </TouchableOpacity>
			      
			      <TouchableOpacity onPress={this._onPressButton}>
			      <Image style={styles.button} source={require('image!next')}>
			      </Image>
			      </TouchableOpacity>
			    </View>
			);
	}//<MyButton width={40} height={40}/>
})
var styles = StyleSheet.create({
	container:{
		flex:1,
		//backgroundColor:'red',
		flexDirection:'row',
	},
	button:{
		 //flex:1,
		//backgroundColor:'blue',
		//alignItems:'center',
		width:40,
		height:40,
	    margin:(width-4*40)/8.0,
	},
});
module.exports = Tool;
