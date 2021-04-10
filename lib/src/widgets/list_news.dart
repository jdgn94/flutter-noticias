import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';

class ListNews extends StatelessWidget {
  final List<Article> news;

  const ListNews(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (BuildContext context, int index) {
        return _Notice(notice: this.news[index], index: index);
      },
    );
  }
}

class _Notice extends StatelessWidget {
  final Article notice;
  final int index;

  const _Notice({@required this.notice, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TargetTopBar(notice: notice, index: index),
        _TargetTitle(notice: notice),
        _TargetImage(notice: notice),
        _TargetBody(notice: notice),
        SizedBox(height: 10.0),
        Divider(),
        _TargetFooter(),
      ],
    );
  }
}

class _TargetTopBar extends StatelessWidget {
  final Article notice;
  final int index;

  const _TargetTopBar({@required this.notice, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: <Widget>[
          Text(
            '${index + 1}. ',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          Text('${notice.source.name}'),
        ],
      ),
    );
  }
}

class _TargetTitle extends StatelessWidget {
  final Article notice;

  const _TargetTitle({@required this.notice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        notice.title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TargetImage extends StatelessWidget {
  final Article notice;

  const _TargetImage({@required this.notice});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(
              50.0,
            )),
        child: FadeInImage(
          placeholder: AssetImage('assets/img/giphy.gif'),
          image: notice.urlToImage.isNotEmpty
              ? NetworkImage(notice.urlToImage)
              : AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }
}

class _TargetBody extends StatelessWidget {
  final Article notice;

  const _TargetBody({@required this.notice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(notice.description.isEmpty ? '' : notice.description),
    );
  }
}

class _TargetFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Icon(Icons.star_outline),
          ),
          SizedBox(width: 10.0),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}
