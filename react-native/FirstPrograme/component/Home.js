var React = require('react-native');
var {
	View,
	Text,
	StyleSheet,
	Image,
	TouchableOpacity,
	TouchableWithoutFeedback,
} = React;

var title = null;
var Dimensions = require('Dimensions');
var { width, height, scale } = Dimensions.get('window');//应该是获取屏幕的宽，高，比例

var MyButton = require('./MyButton');

var BottomTool = require('./BottomTool');

var VideoView = require('./VideoView');

var Menu = require('./Menu');

var showView = null;

var Home = React.createClass({
	_onPressButton(){
	    	alert('action');
	},
	getInitialState(){
		return {
			showMenu:0
		};
	},
	rightMenuButton(){
		
			this.setState({
				showMenu:(this.state.showMenu===0?1:0)
			});
	},
	_handlePress(){
		
		if (this.state.showMenu === 1)
		{
			this.setState({
				showMenu:0,
			});
		}
	},
	render(){//
		title = '九零012';//<View style={{ height:400,backgroundColor:'red',width:width}}/>
		// 
		/*
		 padding是控件的内容相对控件的边缘的边距。(与子组件里的关系) 
         margin是控件边缘相对父空间的边距．(与父组件间的关系)
         <View style={styles.title}>
			             <Text style={styles.titleStyle}>{title}</Text>
			         </View>
			         <MyButton width={40} height={40} x={width-40}/>
		*/
		//
		return (
			<TouchableWithoutFeedback onPress={this._handlePress}>
			<View style={styles.container} >
			    <View style={styles.headTool}  >
			         <View style={styles.title}>
			             <Text style={styles.titleStyle}>{title}</Text>
			         </View>
			         <MyButton width={40} height={40} image='image!menuIcon' onPress={this.rightMenuButton}
			         />
			    </View>
			    <VideoView startAnimated={1}/>
			    <BottomTool />
			    <Menu isShowing = {this.state.showMenu}/> 
			</View>
			</TouchableWithoutFeedback>
			);
	}
})
var styles = StyleSheet.create({
	container:{
		flex:1,
		backgroundColor:'#efeff4',
		flexDirection:'column',
		
		//alignItems:'center',
		//这是属性，仅仅控制子组件的垂直位置
	},
	headTool:{
		marginTop:24,
		flexDirection:'row',
		alignItems:'center',
		justifyContent:'center',
	    height:40,
	    //backgroundColor:'red',
	},
	title:{
		height:40,
	    width:width-2*40,
	    justifyContent:'center',
	    alignItems:'center',
	    //backgroundColor:'blue',
	},
	titleStyle:{
		color:'black',fontSize:23,fontWeight:'bold',textAlign:'center',	
		//number型的就不需要加‘’引号
		//backgroundColor:'yellow',
		justifyContent:'center',
	},
});
module.exports = Home;

