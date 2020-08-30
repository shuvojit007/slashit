import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:slashit/src/blocs/features.dart';
import 'package:slashit/src/models/features_model.dart';
import 'package:slashit/src/resources/assets.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/url.dart';
import 'package:url_launcher/url_launcher.dart';

class FeaturesList extends StatefulWidget {
  static const routeName = "/features";
  @override
  _FeaturesListState createState() => _FeaturesListState();
}

class _FeaturesListState extends State<FeaturesList> {
  FeaturesBloc _bloc;

  @override
  void initState() {
    _bloc = FeaturesBloc();
    _bloc.featchAllFeatures();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Features List", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder(
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
    );
  }

  _featuresView(AsyncSnapshot<List<Result>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext ctx, int index) {
          return Container(
            height: 270,
            child: Card(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    snapshot.data[index].title,
                                    style: FeaturesTitle,
                                    maxLines: 1,
                                  ),
                                ),
                                Text(
                                  "NGN ${snapshot.data[index].price}",
                                  style: FeaturesPrice,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: RaisedButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                child: Text("BUY NOW"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                onPressed: () =>
                                    _launchURL(snapshot.data[index].link),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: CachedNetworkImage(
                        imageUrl: "${URL.S3_URL}${snapshot.data[index].img}",
                        fit: BoxFit.fitWidth,
                        height: 200,
                        width: double.infinity,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset(
                              Assets.Placeholder,
                              fit: BoxFit.cover,
                            )),
                  ),
                ],
              ),
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
