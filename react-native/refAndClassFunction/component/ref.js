var React = require('react-native');
var {
	View,
	Text,
	Component,//这个千万不要忘记了
	StyleSheet,
	TouchableHighlight,
}=React;

var Ref = React.createClass({
	
   onPressAction(){
   	//measure这个方法只能在子组件中使用
   	//是测量改组件在父组件中的位置
   	//ox,oy-->相对于父组件的xy位置
   	//width,height-->组件的宽高
   	//px,py--->相对于屏幕的x,y位置
   	this.root.measure((ox, oy, width, height, px, py)=>{
   		console.log(ox, oy, width, height, px, py);
   		this.setState({
   			ox,
   			oy,
   			width,
   			height,
   			px,
   			py,//这里设的值，都会自动生成与对象相同的key与之对应
   		},()=>{
   			
   			
   			//alert(this.state.ox);
   		});//后面的方法，是在state设置值完成后，调用的
   	});
  
     
   },
   getInitialState: function() {
    return {
    	status:'yellow',
    	value:100
    }
   },
	render () {
	var {
   			status,
   			value
   		}=this.state;
   		alert(status);//这样子，下面就可以直接使用this.state下得属性（status与value）而不需要通过this.state
   		//这种方式就相当于
   		/*
   		 * var {
   		 * 	View,Text,
   		 * }=React;
   		 * 这是es6的语法
   		 */
    return (
    	<View 
    	ref={component=>this.root=component}
    	style={styles.container} >{/*ref要放在TouchableHighlight事件的父组件上*/}
       <TouchableHighlight onPress={this.onPressAction.bind(this)}>
       <View style={{flex:1,backgroundColor:'blue',height:100,width:100}}>
       </View>
       </TouchableHighlight>	
    	</View>  
    );
 },
  test(){
  	alert('对象方法调用ref成功啦');
  }
});
var styles = StyleSheet.create({
	container : {
		width:100,
		height:100,
		margin:10,
		backgroundColor:'red',
	}
});
module.exports = Ref;
