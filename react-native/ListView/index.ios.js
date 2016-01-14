/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';
var React = require('react-native');
var {
  StyleSheet,
  Text,
  View,
  TouchableHighlight,
  LayoutAnimation,
  Animated,
  TouchableWithoutFeedback,
  ListView,
  AppRegistry,

} = React;

var  CityLists = React.createClass({
   // transform:[{translateY:}]}}>
  
   componentWillMount:function(){
   	//var rowData = [['','',,'','',''],['','',,'','',''],['','',,'','','']];
   	
   	var docs = {'A':['row','row1',''],'B':['row'],'C':['row'],'D':['row']};//这个是数据源
   	var sectionIDs = Object.keys(docs);//这个是数据源字典对应的key值组合
   	alert(sectionIDs.class);
   	var rowIDs = sectionIDs.map(id=>
   		docs[id].map(s=>{console.log(s);return (s+id);}));//这个是自定义的，只是遍历数据源，
   		                                                 //然后给每组下得row配一个对应的key值，以便于系统查找
   	this.setState({
      //dataSource : this.state.dataSource.cloneWithRowsAndSections({'A':['row','row','',''],'B':['row'],'C':['row'],'D':['row']}),
        dataSource : this.state.dataSource.cloneWithRowsAndSections(docs,sectionIDs,rowIDs),
    });
   },
   componentWillReceiveProps(nextProps) {//在接收到新的props参数时调用，如果用其他的更新方法调用，就会陷入死循环
   	//alert(this.props.animated);
   	this.animatedAction();
   },
   getInitialState: function() {
   	var getSectionData = (dataBlob, sectionID) => {
            return dataBlob[sectionID];
        }

        var getRowData = (dataBlob, sectionID, rowID) => {
            return dataBlob[sectionID + ':' + rowID];
        }

   	var ds = new ListView.DataSource({
   		getSectionData : getSectionData,
        getRowData     : getRowData,
        rowHasChanged: (r1, r2) => r1 !== r2,
        sectionHeaderHasChanged : (s1, s2) => s1 !== s2
        });
  	// var rows = makeSequence(100).map((n) => ({text: 'not refreshed '+n}))
    return {top: -120,dataSource: ds};
  },
  onPressAction(){
  	alert('touch');
  },
  renderRow:function(rowData, sectionID, rowID, highlightRow){
  	return (<Text style={{height:100,textAligns:'center',backgroundColor:'red',}}>text</Text>);
  },
  renderHeadView:function(){
  	return (<View style={{height:10,backgroundColor:'black'}}/>);
  },
  renderFootView(){
  	return (<View style={{height:10,backgroundColor:'blue'}}/>);
  },
  renderSectionHeadView(sectionData, sectionID){
  	return (<View style={{height:10,backgroundColor:'green'}}/>);
  }, 
	render(){
		
		return (//onPress={this.animatedAction}
		<ListView
        dataSource={this.state.dataSource}
        renderRow={this.renderRow}
        //initialListSize = {1}//第一次显示的row数目
        //onEndReached={()=>alert('bottom')}//滚动到底部调用的方法
        pageSize = {2}////多少组
        renderHeader = {this.renderHeadView}
        renderSectionHeader  = {this.renderSectionHeadView}
        renderFooter = {this.renderFootView}
        />
	
	   
	    );	     	
	}
});
var styles = StyleSheet.create({
	listStyle:{
  	
  },
});
module.exports = CityLists;
AppRegistry.registerComponent('ListView', () => CityLists);
