var React = require('react-native');
var {View,Component,Text,TouchableWithoutFeedback}=React;
function a(c){
  	this.b = c;
  	this.d = function(){
  		alert(this,b);
  	};
  };
class HelloComponent extends Component {
	
    constructor(props) {
        super(props);
        this.myname = 'lucy';//这是构造函数，所以，这里在这里改掉对外的属性----可以对比js的构造函数来理解
        this.state = {wording: '你好呀, '};
        /*
         * React在ES6的实现中去掉了getInitialState这个hook函数，规定state在constructor中实现，如下：
Class App extends React.Component {
constructor(props) {
    super(props);
    this.state = {};
}    
...
         */
    }

    //state = {wording:'你好呀，'}
    render() {
        return (
        	<TouchableWithoutFeedback onPress={this.onPressAction.bind(this)}>
        	<Text>{this.state.wording} {this.props.name} {this.myname}</Text>
        	</TouchableWithoutFeedback>)
    }
    onPressAction(){
    	//alert('sss');
  	this.props.onPress();
  	this.forceUpdate();//手动强制刷新
  }
}

module.exports = HelloComponent;