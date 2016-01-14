'use strict';

var React = require('react-native');
var {
  StyleSheet,
  Navigator,
  Component,
  ScrollView,
  View,
} = React;

var NavigationBar = require('react-native-navbar');
var Dimensions = require('Dimensions');
var { width, height, scale } = Dimensions.get('window');//应该是获取屏幕的宽，高，比例
/*
 * get("获取属性")
 * Object.defineProperty(document.body, "description", {   
    get : function () {       
        return this.desc;  
    },    
    set : function (val) { 
        this.desc = val;    
    } 
}); 
document.body.description = "Content container"; 
 */
// 类别分组
var Types = require('./Types');

// 上门服务
var Service = require('./Service');

// 上门服务下面那块
var Kfc = require('./Kfc');

// 各种免费优惠
var Free = require('./Free');

// 猜你喜欢
var YouLike = require('./YouLike');

// 查看所有
var More = require('./More');

// 搜索栏
var SearchBar = require('./SearchBar');

// 右上角图标
var MyIcon = require('./MyIcon');

// 城市选择
var CitySelect = require('./CitySelect');

// 城市列表
var CitysList = require('./CitysList');

var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;
/*
 * position: 'absolute'style={{overflow: 'hidden'}}
 */
// 主页
var HomeContent = React.createClass({
  getInitialState:function(){
  	return {animated:false};
  },
 componentDidMount:function(){
 	
 },
 componentWillUpdate(nextProps, nextState) {
 	
 	if(this.props.showList)
      {      	
      	//alert('你中奖啦');
      	//this.setState({animated:true});
      }
 },
  render() {
  	 
    return (
      
       <View  style={{overflow: 'hidden',height: height - 66,backgroundColor:'black'}}>
       
      <ScrollView style={{position: 'absolute',backgroundColor: '#f3f3f3', top:0,left:0,height: height - 66}}>
        
        <Types/>
        <Service/>
        <Kfc/>
        <Free/>
        <YouLike/>
        <More/>
        
      </ScrollView>
      
      <CitysList  animated={this.props.showList} />
      </View>
     
    )
  }
})
var navi = null;
// 美团客户端
var Home = React.createClass({
  getInitialState:function(){
  	return {showList:false};
  },
  renderInScenes: function(route, navigator) {//renderScenes函数名字是自定义的
  
    var Component = route.component;
    var navBar = route.navigationBar;
    if (navBar) {
    	/*
    	 * 一个组件可能想改变另一个它不拥有的组件的props（就像改变一个组件的className，
    	 * 这个组件又作为this.props.children传入）。其它的时候，可能想生成传进来的一个组件的多个拷贝。
    	 * cloneWithProps()使其成为可能
    	 */
        navBar = React.addons.cloneWithProps(navBar, {
        navigator: navigator,
        route: route
      });////这里是自定义导航栏
    }
    navi =  <Component navigator={navigator} route={route} showList={this.state.showList} />;
    return (
    	//这里返回的是整个屏幕显示的内容
    	//向组件传入两个参数导航和路线
      <View style={styles.navigator}>
      
       {navBar}
        {navi}
      </View>
    );
  },
  onPressPass:function(title)
  {
  
  	this.setState({showList:true});
  	
  },
  render: function() {
    return (
      <Navigator
          renderScene={this.renderInScenes}//指整个navigator显示的内容,这里并未调用，
                                          //而只是给一个索引地址，组件Navigator会自己内部调用
          initialRoute={{
            component: HomeContent,
            navigationBar: <NavigationBar
              backgroundColor='rgb(6,193,174)'
              title="美团团购"
              customPrev={<CitySelect onPress={this.onPressPass}/>}//customPrev自定义左视图
              customTitle={<SearchBar/>}//customTitle自定义标题视图
              customNext={<MyIcon/>}//customNext自定义右视图
            />
          }}
        />
    )
  }
});

var styles = StyleSheet.create({
  flex: {flexDirection: 'row'},
  row: {marginBottom: 6, backgroundColor: '#fff'},
  block: {flex: 1, padding: 5},
  item: {flex: 1, alignItems: 'center', padding: 5},
  icon: {justifyContent: 'center', color: "#900", width: 50, height: 50},
});

module.exports = Home;
