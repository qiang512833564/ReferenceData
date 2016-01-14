var React = require('react-native');
var {
	View,
	Text,
	Component,
	
}=React;
class JSX extends Component{
	
	hide(){
		setTimeout(()=>alert('hide'));//直接使用setTimeout代表直接调用(里面的方法)，
		
	}
	
	renderChildren () {
    return React.cloneElement(//cloneElement方法，复制节点
    	//克隆并返回一个新的 ReactElement （内部子元素也会跟着克隆），
    	//新返回的元素会保留有旧元素的 props、ref、key，也会集成新的 props（只要在第二个参数中有定义）。
      this.props.children,
      {}
    );
   }
	render(){
		return (<View style={{width:this.props.width,height:this.props.height,backgroundColor:this.props.backgroundColor}}>
			{this.renderChildren()}
			</View>);
	}
};
module.exports = JSX;
