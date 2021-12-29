import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';

/// This is the class which contains the Page UI.
class Page extends StatefulWidget {
  ///page details
  final PageViewModel pageViewModel;

  ///percent visible of page
  final double percentVisible;

  /// [MainAxisAligment]
  final MainAxisAlignment columnMainAxisAlignment;

  //Constructor
  Page({
    this.pageViewModel,
    this.percentVisible = 1.0,
    this.columnMainAxisAlignment = MainAxisAlignment.spaceAround,
  });

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: widget.pageViewModel.pagePadding ?? const EdgeInsets.all(8.0),
      width: double.infinity,
      color: widget.pageViewModel.pageColor,
      alignment: Alignment.center,
      child: new Opacity(
        //Opacity is used to create fade in effect
        opacity: widget.percentVisible,
        child: new OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitPage()
              : _buildPortraitPage();
        }), //OrientationBuilder
      ),
    );
  }

  /// when device is Portrait place title, image and body in a column
  Widget _buildPortraitPage() {
    return SafeArea(
        child: Center(
          child: ListView(
                  //itemExtent: MediaQuery.of(context).size.height,
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: new _TitlePageTransform(
                        percentVisible: widget.percentVisible,
                        pageViewModel: widget.pageViewModel,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: new _BodyPageTransform(
                        percentVisible: widget.percentVisible,
                        pageViewModel: widget.pageViewModel,
                      ),
                    ),
                  ],
                ),
        ),
    );
  }

  /// if Device is Landscape reorder with row and column
  Widget __buildLandscapePage() {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: new _ImagePageTransform(
            percentVisible: widget.percentVisible,
            pageViewModel: widget.pageViewModel,
          ),
        ), //Transform

        new Flexible(
          child: new Column(
            mainAxisAlignment: widget.columnMainAxisAlignment,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new _TitlePageTransform(
                percentVisible: widget.percentVisible,
                pageViewModel: widget.pageViewModel,
              ), //Transform
              new _BodyPageTransform(
                percentVisible: widget.percentVisible,
                pageViewModel: widget.pageViewModel,
              ), //Transform
            ],
          ), // Column
        ),
      ],
    );
  }
}

/// Body for the Page.
class _BodyPageTransform extends StatefulWidget {
  final double percentVisible;
  final PageViewModel pageViewModel;

  const _BodyPageTransform({
    Key key,
    @required this.percentVisible,
    @required this.pageViewModel,
  }) : super(key: key);

  @override
  _BodyPageTransformState createState() => _BodyPageTransformState();
}

class _BodyPageTransformState extends State<_BodyPageTransform> {
  @override
  Widget build(BuildContext context) {
    return new Transform(
      //Used for vertical transformation
      transform: new Matrix4.translationValues(
          0.0, 30.0 * (1 - widget.percentVisible), 0.0),
      child: new Padding(
        padding: const EdgeInsets.only(
          bottom: 75.0,
          left: 10.0,
          right: 10.0,
        ),
        child: DefaultTextStyle.merge(
          style: widget.pageViewModel.bodyTextStyle,
          textAlign: TextAlign.center,
          child: widget.pageViewModel.body,
        ),
      ), //Padding
    );
  }
}

/// Main Image of the Page
class _ImagePageTransform extends StatelessWidget {
  final double percentVisible;

  final PageViewModel pageViewModel;

  const _ImagePageTransform({
    Key key,
    @required this.percentVisible,
    @required this.pageViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Transform(
      //Used for vertical transformation
      transform:
          new Matrix4.translationValues(0.0, 50.0 * (1 - percentVisible), 0.0),
      child: new Padding(
        padding: new EdgeInsets.only(
          top: 20.0,
          bottom: 40.0,
        ),
        child: new Container(
          child: pageViewModel.mainImage, //Loading main
        ), //Container
      ), //Padding
    );
  }
}

/// Title for the Page
class _TitlePageTransform extends StatelessWidget {
  final double percentVisible;

  final PageViewModel pageViewModel;

  const _TitlePageTransform({
    Key key,
    @required this.percentVisible,
    @required this.pageViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Transform(
      //Used for vertical transformation
      transform:
          new Matrix4.translationValues(0.0, 30.0 * (1 - percentVisible), 0.0),
      child: new Padding(
        padding: new EdgeInsets.only(
          top: 5.0,
          bottom: 30.0,
          left: 10.0,
          right: 10.0,
        ),
        child: DefaultTextStyle.merge(
          style: pageViewModel.titleTextStyle,
          child: pageViewModel.title,
        ),
      ), //Padding
    );
  }
}
