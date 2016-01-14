'use strict';

var React = require('react-native');
var {
  AppRegistry,
  LayoutAnimation,
  StyleSheet,
  View,
  TouchableOpacity,
  Text,
  Image,
} = React;
var GridView = require('react-native-grid-view');

var LoginOverlay = require('../overlays/LoginOverlay');
var VisualizationPage = require('./VisualizationPage');

var VisualizationGridPage = React.createClass({
  getInitialState: function() {
    return {
      isLoggedIn: false,
      visualizations: [{
        name: 'Bubble',
        image: require('image!bubbles')
      }, {
        name: 'Pie',
        image: require('image!pie')
      }, {
        name: 'Gauge',
        image: require('image!gauge')
      }, {
        name: 'Treemap',
        image: require('image!treemap')
      }, {
        name: 'Scatterplot',
        image: require('image!scatter')
      }, {
        name: 'Trend',
        image: require('image!trend')
      }, {
        name: 'Donut',
        image: require('image!donut')
      }, {
        name: 'KPI',
        image: require('image!kpi')
      }]
    };
  },

  handleLoginStatus: function(loggedIn) {
    LayoutAnimation.configureNext(animationConfig);
    this.setState({'isLoggedIn': loggedIn});
  },

  render: function() {
    var grid = <GridView
      items={this.state.visualizations}
      itemsPerRow={2}
      renderItem={this.renderItem}>
    </GridView>;
    
    if(!this.state.isLoggedIn) {
      grid = <View></View>;
    }

    return (
      <View style={{backgroundColor: '#E6E6E6'}}>
        {grid}

        <LoginOverlay ref="overlay" isVisible={!this.state.isLoggedIn} updateLoginStatus={this.handleLoginStatus} />
      </View>
    );
  },

  renderItem: function(item) {
    return (
      <TouchableOpacity onPress={() => this._pressItem(item)}>
        <View style={styles.item}>
          <Text style={styles.itemText}>{item.name}</Text>
          <Image style={styles.itemImage} source={item.image} />
        </View>
      </TouchableOpacity>
    );
  },

  _pressItem: function(item) {
    this.props.toRoute({
      name: item.name,
      component: VisualizationPage,
      data: item
    });
  },
});

var styles = StyleSheet.create({
  item: {
    flex: 1,
    margin: 10,
    alignItems: 'center',
    backgroundColor: 'white',
    shadowColor: '#595959',
    shadowOffset: {
      width: 2,
      height: 2
    },
    shadowOpacity: 0.4,
    shadowRadius: 0
  },
  itemText: {
    marginTop: 5,
    marginLeft: 10,
    color: '#575757',
    alignSelf: 'flex-start'
  },
  itemImage: {
    width: 148,
    height: 95,
    marginTop: 10,
    marginBottom: 10
  }
});

var animationConfig = {
  duration: 2000,
  create: {
    type: LayoutAnimation.Types.spring,
    springDamping: 0.4,
    property: LayoutAnimation.Properties.opacity,
  },
  update: {
    type: LayoutAnimation.Types.spring,
    springDamping: 0.4,
    property: LayoutAnimation.Properties.opacity,
  }
};

module.exports = VisualizationGridPage;
