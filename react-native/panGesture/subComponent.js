var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
} = React;
type PropTypes = {
  onPanBegin: React.PropTypes.func,
};
var subComponent = React.createClass({
	render:function(){
		return (<View style={{flex:1,backgroundColor:'red'}}/>);
	}
})
module.exports = subComponent;