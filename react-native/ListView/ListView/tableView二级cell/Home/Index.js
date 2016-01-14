"use strict";

var React = require('react-native');
var Accordion = require('react-native-accordion');
var {
	View,
	ListView,
	Text,
	TouchableOpacity,
	StyleSheet,
}=React;
var MyComponent = React.createClass({
	getInitialState:function(){
		var ds = new ListView.DataSource({rowHasChanged:(r1,r2)=>r1 != r2});
		return {
			dataSource:ds.cloneWithRows(this._genRows({})),//['row1','row2']
		};
	},
	_genRows:function(pressData:{[key:number]:boolean}):Array<string>{
		var dataBlob = [];
		for(var i=0; i<100; i++){
			var pressedText = pressData[i]?'(pressed)':'';
			dataBlob.push('Row'+i+pressedText);
		}
		return dataBlob;
	},
	render(){
		/*
		 *
		 */
		return (
			 <ListView 
			         dataSource={this.state.dataSource}
			         renderRow={(rowData, sectionID, rowID, highlightRow) => this._renderRow(rowData, sectionID, rowID)}
			         style={{backgroundColor:'white'}}
			         initialListSize={20} 
			         renderSeparator={this._renderLine}
			        // automaticallyAdjustContentInsets={false}
			        /*
			         * ;if(rowID==3){
			         	highlightRow(null);
			         }
			         */
			>
			</ListView>
		);
	},
	//注意，这里的方法，是ListView自己调用的，而且传递的参数，也可以根据需要去设置，ListView默认使传递过来四个参数rowData, sectionID, rowID，highlightRow
	//另外需要注意的是：ListView的单个cell，要想有高度，还有cell底线，需要通过style去设置
	_renderRow(rowData, sectionID, rowID) {
		//if(rowID == 3){//The separators above and below will be hidden when a row is highlighted
			 //The highlighted state of a row can be reset by calling highlightRow(null).
		//}
		    var header = (
		    	<View style={styles.rowStyle}>
		    	 <Text>Click to Expand</Text>
		    	</View>
		    	);
		    	var content = (
		    		<View style={styles.rowStyle}>
		    		<Text>This content is hidden in the accordion</Text>
		    		</View>
		    	);
            return (
                <Accordion
                header={header}
                content={content}
                easing="easeOutCubic"
                />
            );
        },
      _renderLine(){
      	return (
      		<View style={styles.lineStyle}>
      		</View>
      	);
      },
});
var styles = StyleSheet.create({
    lineStyle:{
    	backgroundColor:'yellow',
    	width:200,
    	marginLeft:100,
    	height:1
    },
    rowStyle: {
        paddingVertical: 15,
        paddingLeft: 16,
        borderBottomColor: '#E0E0E0',
        borderBottomWidth: 1//这两个属性，是设置cell边框颜色的，默认是没有的，也可以通过设置ListView的renderSeparator去设置
    }
});
module.exports = MyComponent;
