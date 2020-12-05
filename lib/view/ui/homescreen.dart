import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:fshare/models/customapplication.dart';
import 'package:fshare/utils/dimens.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  PageController pageController;
  int _page = 0;
  List<CustomApplication> _apps = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'FShare',
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Test'),
              decoration: BoxDecoration(color: Colors.grey),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [],
            title: TabBar(
              tabs: [
                Tab(
                  text: 'Apps',
                ),
                Tab(
                  text: 'Photos',
                ),
                Tab(
                  text: 'Documents',
                )
              ],
              indicatorColor: Colors.black,
            ),
          ),
          body: TabBarView(
            children: [
              GridView.count(
                crossAxisCount: 3,
                children: List.generate(_apps.length, (index) {
                  CustomApplication app = _apps[index];
                  return SingleItem(
                    singleApp: app,
                    valueChanged: (value) {
                      setState(() {
                        app.isChecked = value;
                      });
                    },
                  );
                }),
              ),
              new Container(
                color: Colors.orange,
              ),
              new Container(
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void getApps() async {
    DeviceApps.getInstalledApplications(
            includeAppIcons: true,
            onlyAppsWithLaunchIntent: true,
            includeSystemApps: true)
        .then((value) {
      setState(() {
        _apps.clear();
        value.forEach((element) {
          _apps.add(new CustomApplication(element, false));
        });
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = new PageController();
    getApps();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
}

class SingleItem extends StatelessWidget {
  final CustomApplication singleApp;
  final ValueChanged<bool> valueChanged;

  SingleItem({Key key, this.singleApp, this.valueChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Application app = singleApp.application;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(overflow: Overflow.visible, children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.memory(
                  app is ApplicationWithIcon ? app.icon : null,
                  width: 24,
                  height: 24,
                ),
                Container(
                  margin: EdgeInsets.only(top: margin_small),
                  child: Text(
                    app.appName,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Checkbox(
                  value: singleApp.isChecked, onChanged: valueChanged)),
        ]),
      ),
    );
  }
}
