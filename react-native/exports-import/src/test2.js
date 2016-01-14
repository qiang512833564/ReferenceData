var React = require('react-native');
var {
	View,
	Text,
	NativeModules,
	Component,
	StyleSheet,
	TouchableHighlight,
} = React;
var UIManager =  NativeModules.UIManager;
var merge = require('merge');
class MyTest extends Component{
	componentDidMount(){
		
		
	}
	_action(){
		//经过测试，知道React.findNodeHandle(this.root)是获取某个节点（在这里是一个视图），
		//另外UIManager.measure( , ()=>{})该方法是度量视图的，跟this.root.measure(()=>{})相似
		UIManager.measure(React.findNodeHandle(this.root),(x,y,w,h)=>{
			this.containerHeight = h;
			alert('dadadadad'+w)
		});
		this.root.measure((ox, oy, width, height, px, py)=>{
   		console.log(ox, oy, width, height, px, py);
   	});
	}
	render(){
		return (//
			 <View ref={component => this.root = component}>
			<TouchableHighlight onPress={this._action.bind(this)}>
			<View  style={styles.main}>
			</View>
			</TouchableHighlight>
			</View>
			//
		);
	}
}
var styles = StyleSheet.create({
	main:{
		width:100,
		height:100,
		backgroundColor:'red'
	}
});
module.exports = MyTest;