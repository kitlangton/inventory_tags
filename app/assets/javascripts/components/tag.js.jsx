var Tags = React.createClass({
  getInitialState: function() {
    return {data: []};
  },
  render: function() {
    var tagNodes = this.props.data.map(function (tag) {
      return (
        <Tag name={tag.name}
        model={tag.model}
        size={tag.size}
        color={tag.color}
        manufacturer={tag.manufacturer}/>
      );
    });
    return (
      <div id="tags">
        <div className="row">
          <div className="tags-container">
            {tagNodes}
          </div>
        </div>
      </div>
    );
  }
});

var Tag = React.createClass({
  propTypes: {
    name: React.PropTypes.string,
    model: React.PropTypes.string,
    size: React.PropTypes.node,
    color: React.PropTypes.instanceOf(Color),
    manufacturer: React.PropTypes.string
  },

  render: function() {
    var colorNode;
    if (this.props.color != null) {
      colorNode = <Color name={this.props.color.name} hex={this.props.color.hex}/>
    } else {
      colorNode = <Color name="N/A" hex="#FFFFFF"/>
    }
    return (
      <div className="tag">
        <div className="tag-left">
          <div className="manufacturer-name">{this.props.manufacturer}</div>
          <div className="tag-name">{this.props.name}</div>
          <div className="tag-model">{this.props.model}</div>
        </div>
        <div className="tag-right">
          {colorNode}
          <div>{this.props.size}</div>
        </div>
      </div>
    );
  }
});
