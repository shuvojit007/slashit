import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:slashit/src/blocs/features.dart';
import 'package:slashit/src/models/features_model.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
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
        title: Text("Features List", style: userTitle),
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
            height: 320,
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
                            child: Flexible(
                              child: Text(
                                snapshot.data[index].title,
                                style: FeaturesTitle,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: Text(
                                  "₦ ${snapshot.data[index].price}",
                                  style: FeaturesPrice,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 200,
                      child: CachedNetworkImage(
                        imageUrl: "${URL.S3_URL}${snapshot.data[index].img}",
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Center(child: CircularProgressIndicator()),
                      ),
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
