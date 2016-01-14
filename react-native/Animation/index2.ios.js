'use strict';
//http://facebook.github.io/react-native/docs/animated.html#content
var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
  LayoutAnimation,
} = React;

var App = React.createClass({
  componentWillMount() {
    // Animate creation
    LayoutAnimation.configureNext(LayoutAnimation.Presets.spring);
  },

  getInitialState() {
    return { w: 100, h: 100 }
  },
  _onPress() {
    // Animate the update
    LayoutAnimation.configureNext(LayoutAnimation.Presets.spring);
    this.setState({w: this.state.w + 15, h: this.state.h + 15})
  },

  render: function() {
    return (
      <View style={styles.container}>
        <View style={[styles.box, {width: this.state.w, height: this.state.h}]} />
        <TouchableOpacity onPress={this._onPress}>
          <View style={styles.button}>
            <Text style={styles.buttonText}>Press me!</Text>
          </View>
        </TouchableOpacity>
      </View>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  box: {
    backgroundColor: 'red',
  },
  button: {
    marginTop: 10,
    paddingVertical: 10,
    paddingHorizontal: 20,
    backgroundColor: 'black',
  },
  buttonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  },
});

AppRegistry.registerComponent('AwesomeProject', () => App);
module.exports = App;