import 'package:flutter/material.dart';
import 'package:slivers/pages/slivers.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollViewController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                pinned: true,
                floating: true,
                title: Text('Заголовок'),
                forceElevated: boxIsScrolled,
                bottom: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      text: '1',
                      icon: Icon(Icons.access_alarm),
                    ),
                    Tab(
                      text: '2',
                      icon: Icon(Icons.add_location),
                    ),
                    Tab(
                      text: '3',
                      icon: Icon(Icons.account_box),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            Container(
              color: Colors.brown,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 94.4),
              child: SliversPage(),
            ),
            Container(
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}