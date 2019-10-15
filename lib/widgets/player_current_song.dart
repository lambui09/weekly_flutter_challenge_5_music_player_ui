import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styleguide.dart';
import '../providers/player_provider.dart';
import '../widgets/song_seekbar_circle.dart';

class PlayerCurrentSong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      child: Stack(
        children: <Widget>[
          AppTitle(),
          SongHeader(
            "Love Me Like You Do",
            "Ellie Goulding",
            Duration(
              minutes: 4,
              seconds: 32,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width * .5,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .25,
              left: MediaQuery.of(context).size.width * .25,
              right: MediaQuery.of(context).size.width * .25,
            ),
            child: SongSeekbarCircle(),
          ),
          CurrentSongButtons(),
          CornerButton(
            icon: Icons.menu,
            corner: CornerPositions.topLeft,
          ),
          CornerButton(
            icon: Icons.search,
            corner: CornerPositions.topRight,
          ),
          CornerButton(
            icon: Icons.fast_rewind,
            corner: CornerPositions.bottomLeft,
            songId: 0,
          ),
          CornerButton(
            icon: Icons.fast_forward,
            corner: CornerPositions.bottomRight,
            songId: 2,
          ),
        ],
      ),
    );
  }
}

class AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 30,
      ),
      height: 35,
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        "Music Player",
        style: textTitleStyle,
      ),
    );
  }
}

class SongHeader extends StatelessWidget {
  final String _title;
  final String _artist;
  final Duration _duration;

  SongHeader(
    this._title,
    this._artist,
    this._duration,
  );

  @override
  Widget build(BuildContext context) {
    String twoDigitSeconds =
        _duration.inSeconds.remainder(Duration.secondsPerMinute) > 10
            ? "${_duration.inSeconds.remainder(Duration.secondsPerMinute)}"
            : "0${_duration.inSeconds.remainder(Duration.secondsPerMinute)}";

    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .15,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "$_title",
            style: TextStyle(
              fontSize: 17,
              color: textLightColor,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "$_artist",
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  color: textLightColor,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: textLightColor,
                  shape: BoxShape.circle,
                ),
                width: 4.0,
                height: 4.0,
              ),
              Text(
                "${_duration.inMinutes}:$twoDigitSeconds",
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  color: textLightColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CurrentSongButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .25 +
            MediaQuery.of(context).size.width * .5,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * (.7 - .25) -
            MediaQuery.of(context).size.width * .5 -
            30 -
            35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.replay,
              color: textLightColor.withOpacity(.8),
              size: 32,
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.favorite_border,
              color: textLightColor.withOpacity(.8),
              size: 32,
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.share,
              color: textLightColor.withOpacity(.8),
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}

class CornerButton extends StatelessWidget {
  final IconData icon;
  final CornerPositions corner;
  final int songId;

  CornerButton({this.icon, this.corner, this.songId});

  @override
  Widget build(BuildContext context) {
    String title = songId != null
        ? Provider.of<PlayerProvider>(context).geSongData(songId)['title']
        : null;
    String artist = songId != null
        ? Provider.of<PlayerProvider>(context).geSongData(songId)['artist']
        : null;

    return Positioned(
      top: (corner == CornerPositions.topLeft ||
              corner == CornerPositions.topRight)
          ? 30
          : null,
      bottom: (corner == CornerPositions.bottomLeft ||
              corner == CornerPositions.bottomRight)
          ? 30
          : null,
      left: (corner == CornerPositions.topLeft ||
              corner == CornerPositions.bottomLeft)
          ? 30
          : null,
      right: (corner == CornerPositions.topRight ||
              corner == CornerPositions.bottomRight)
          ? 30
          : null,
      child: Container(
        child: Row(
          children: <Widget>[
            corner == CornerPositions.bottomRight
                ? CornerButtonLabel(
                    artist: artist,
                    title: title,
                    corner: corner,
                  )
                : Container(
                    child: null,
                  ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
              width: 35.0,
              height: 35.0,
              child: Center(
                child: Icon(
                  icon,
                  size: 24,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ),
            corner == CornerPositions.bottomLeft
                ? CornerButtonLabel(
                    artist: artist,
                    title: title,
                    corner: corner,
                  )
                : Container(
                    child: null,
                  ),
          ],
        ),
      ),
    );
  }
}

class CornerButtonLabel extends StatelessWidget {
  final String artist;
  final String title;
  final CornerPositions corner;

  CornerButtonLabel({
    this.title,
    this.artist,
    this.corner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: corner == CornerPositions.bottomRight ? 10 : 0,
        left: corner == CornerPositions.bottomLeft ? 10 : 0,
      ),
      child: Column(
        crossAxisAlignment: corner == CornerPositions.bottomRight
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            artist,
            style: TextStyle(
              color: textLightColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(
              color: textLightColor,
              fontSize: 13,
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }
}

enum CornerPositions {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}
