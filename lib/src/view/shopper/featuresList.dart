import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:slashit/src/blocs/features.dart';
import 'package:slashit/src/models/features_model.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/number.dart';
import 'package:slashit/src/utils/url.dart';
import 'package:url_launcher/url_launcher.dart';

class FeaturesList extends StatefulWidget {
  static const routeName = "/features";
  int index;

  FeaturesList(this.index);

  @override
  _FeaturesListState createState() => _FeaturesListState();
}

class _FeaturesListState extends State<FeaturesList> {
  FeaturesBloc _bloc;

  ScrollController _controller = ScrollController();

  bool scrlDown = true;
  int offset = 0;
  StreamSubscription _featuresSubscription;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  bool scroll = false;

  _scrollListener() async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      print(" Scroll Lister FetchMore Called");
      offset = offset + 1;
      _bloc.featchAllFeatures(20, offset);
    }
  }

  stream() {
    _featuresSubscription = _bloc.allFeatures.listen((event) {
      print("Stream is called");
      //  _controller.animateTo(5);

//      _controller.animateTo(3000,
//          duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
    }, onError: (err) {
      print("subscription err ${err.toString()}");
    }, onDone: () {});
  }

  @override
  void initState() {
    _bloc = FeaturesBloc();
    _controller.addListener(_scrollListener);
    _bloc.featchAllFeatures(20, 0);

    itemPositionsListener.itemPositions.addListener(() => {
          if (!scroll && widget.index != 0)
            {
              scroll = true,
              itemScrollController.scrollTo(
                  index: widget.index,
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOutCubic)
            },
          print("offset $offset getIndex ${getIndex()}"),
          if (offset == 0 && getIndex() == 20)
            {offset = offset + 1, _bloc.featchAllFeatures(20, offset)}
          else if (getIndex() == ((offset + 1) * 20))
            {offset = offset + 1, _bloc.featchAllFeatures(20, offset)}
        });

    stream();
    super.initState();
  }

  int getIndex() {
    return itemPositionsListener.itemPositions.value
            .toList()[
                itemPositionsListener.itemPositions.value.toList().length - 1]
            .index +
        1;
  }

  @override
  void dispose() {
    _bloc.dispose();
    _featuresSubscription?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  _progressDialog() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            margin: EdgeInsets.only(bottom: 30),
            child: CircularProgressIndicator()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Featured", style: userTitle),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: _bloc.allFeatures,
            builder: (context, AsyncSnapshot<List<Result>> snapshot) {
              if (snapshot.hasData) {
                return _featuresView(snapshot);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          StreamBuilder<bool>(
            stream: _bloc.isMoreLoading,
            initialData: false,
            builder: (context, snapshot) {
              if (!snapshot.data) {
                return Container();
              } else {
                return _progressDialog();
              }
            },
          ),
        ],
      ),
    );
  }

  _featuresView(AsyncSnapshot<List<Result>> snapshot) {
    return ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext ctx, int index) {
          return Container(
            key: Key(snapshot.data[index].id),
            height: 320,
            child: Column(
              children: <Widget>[
                Container(
                  height: 60,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 100),
                          child: Text(
                            snapshot.data[index].title,
                            style: FeaturesTitle,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Text(
                              "₦ ${formatNumberValue(snapshot.data[index].price)}",
                              style: FeaturesPrice,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: CachedNetworkImage(
                    imageUrl: "${URL.S3_URL}${snapshot.data[index].img}",
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    placeholderFadeInDuration: Duration(milliseconds: 3),
//                    placeholder: (context, url) =>
//                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: RaisedButton(
                      color: PrimaryColor,
                      textColor: Colors.white,
                      child: Text("VIEW"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      onPressed: () => _launchURL(snapshot.data[index].link),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not launch $url");
    }
  }
}
