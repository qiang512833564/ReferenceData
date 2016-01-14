/*//简单的组件生成方式
var {requireNativeComponent}=require('react-native');
// requireNativeComponent automatically resolves this to "RCTMapManager"
module.exports = requireNativeComponent('Map',null);
*/
var React = require('react-native');
var { requireNativeComponent } = React;
var RCTMap = requireNativeComponent('RCTMap', MapView);

class MapView extends React.Component {
  render() {
    return <RCTMap {...this.props} />;
  }
}
////下面是为了降低JS传过来的proptype与OC代码之间的不匹配
//这里，，是为了确保传过来的属性值是我们所需要的类型
MapView.propTypes = {

  zoomEnabled: React.PropTypes.bool,
};

module.exports = MapView;
