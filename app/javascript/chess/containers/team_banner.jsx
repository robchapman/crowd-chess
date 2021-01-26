import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

class TeamBanner extends Component {

  render() {
    return (
      <div className= {`team-banner ${this.props.team}-banner ${this.props.FEN.split(" ")[1] === this.props.team[0] ? 'banner-active' : "" }`}>
        {`${this.props.team === this.props.playerTeam ? 'Your' : this.capitalize(this.props.team) + 's'}`} Turn!
      </div>
    );
  }

  capitalize(word) {
    return word.charAt(0).toUpperCase() + word.slice(1);
  }
}

function mapStateToProps(state) {
  return {
    FEN: state.FEN,
    playerTeam: state.playerTeam
  };
}

export default connect(mapStateToProps, null)(TeamBanner);

