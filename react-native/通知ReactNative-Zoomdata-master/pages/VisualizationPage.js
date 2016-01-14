'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  View,
  Image,
  WebView,
} = React;

var VisualizationPage = React.createClass({
  render: function() {
    // console.log(this.props.name);

    return (
      <View style={styles.container}>
        <WebView
          style={styles.webView}
          bounces={false}
          scrollEnabled={false}
          url='shell.html'/>
        <Image style={styles.tabBar} source={require('image!TabBar')} />
      </View>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#3b5998',
  },
  webView: {
    backgroundColor: 'rgba(255,255,255,0.8)',
    height: 350,
  },
  tabBar: {
    alignSelf: 'center',
    width: 380,
    height: 50
  }
});

module.exports = VisualizationPage;
