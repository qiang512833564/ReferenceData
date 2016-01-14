var React = require('react-native');
var {
	View,
	Text,
	Image,
	Component,
	TouchableOpacity,
	Modal,
	StyleSheet,
	TouchableHighlight,
	SwitchIOS,
	cloneElement,
}=React;

var Sub = React.createClass({
	getInitialState() {
    return {
      animated: false,
      modalVisible: false,
      transparent: true,
      origin:{
      	x: 0,
        y: 0,
        opacity: 0,
      },
      target:{
      	x: 0,
        y: 0,
        opacity: 1,
      },
      width:0,
      height:0,
    };
  },

  _setModalVisible() {
  	this.root.measure((ox, oy, width, height, px, py)=>{
  		this.setState({
  			origin:{
  				x:px,
  				y:py,
  				opacity:0,
  			},
  			width,
  			height,
  		},()=>{
  			
  		});
  	});
  	
    this.setState({modalVisible: true});
  },
  renderChildren(){
  	var url = {uri:'http://www.yayomg.com/wp-content/uploads/2014/04/yayomg-pig-wearing-party-hat.jpg'};
  	return React.cloneElement(this.props.children,{});
  },
  render() {
  	var {
      origin,
      target,
      width,
      height,
  	}=this.state;
  	var openStyle = {
      left: target.x,
      top: target.y,
      width: 375,
      height: 667,
      
    };
    var background = {
    	flex: 1,backgroundColor:'white',}
    
    return (
      <View ref={component => this.root = component}>

        <TouchableOpacity onPress={this._setModalVisible}>
          {this.props.children}
        </TouchableOpacity>
        
        <Modal animated={this.state.animated} transparent={this.state.transparent} visible={this.state.modalVisible}>
          <View style={[openStyle,background]}>
            
            {this.renderChildren()}
          </View>
        </Modal>
      </View>
    );
  },
});
var styles = StyleSheet.create({
	 container: {
    flex: 1,
    justifyContent: 'center',
    padding: 20,
  },
  innerContainer: {
    borderRadius: 10,
  },
  row: {
    alignItems: 'center',
    flex: 1,
    flexDirection: 'row',
    marginBottom: 20,
  },
  rowTitle: {
    flex: 1,
    fontWeight: 'bold',
  },
  button: {
    borderRadius: 5,
    flex: 1,
    height: 44,
    justifyContent: 'center',
    overflow: 'hidden',
  },
  buttonText: {
    fontSize: 18,
    margin: 5,
    textAlign: 'center',
  },
  modalButton: {
    marginTop: 10,
  },
});
module.exports = Sub;
