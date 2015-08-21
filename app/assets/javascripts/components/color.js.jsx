var Color = React.createClass({
  propTypes: {
    name: React.PropTypes.string,
    hex: React.PropTypes.string
  },

  render: function() {
    var divStyle = {
      backgroundColor: this.props.hex
    }
    return (
      <div style={divStyle}>
        <div className="no-color">{this.props.name}</div>
      </div>
    );
  }
});
