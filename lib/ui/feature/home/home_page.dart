import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:registro_elettronico/data/network/service/api/spaggiari_client.dart';
import 'package:registro_elettronico/ui/feature/home/components/lesson_card.dart';
import 'package:registro_elettronico/ui/feature/widgets/app_drawer.dart';
import 'package:registro_elettronico/ui/global/localizations/app_localizations.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: AppDrawer(),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _drawerKey.currentState.openDrawer();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    AppLocalizations.of(context).translate('app_name'),
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  LessonCard(
                    color: Colors.red,
                  ),
                  LessonCard(
                    color: Colors.green,
                  ),
                  LessonCard(
                    color: Colors.blue,
                  ),
                  LessonCard(
                    color: Colors.indigo,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[400],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Notice Board',
                      style: Theme.of(context).textTheme.headline,
                    ),
                    Text(
                      'Discover all notice',
                      style: TextStyle(color: Colors.grey[500], fontSize: 14),
                    )
                  ],
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text(
                    'View',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                  ),
                  onPressed: () async {
                    final client =
                        SpaggiariClient(Injector.appInstance.getDependency());
                    final res = await client.getTodayLessons("6102171");
                    print(res.lessons[0].authorName);
                  },
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
          ),
        ],
      )),
    );
  }
}
