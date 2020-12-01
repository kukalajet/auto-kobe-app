import 'package:auto_kobe/screens/feed_tab.dart';
import 'package:auto_kobe/screens/listing_creation_screen.dart';
import 'package:auto_kobe/widgets/tomka_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:auto_kobe/models/models.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  final List<Widget> _tabs = [
    FeedTab(),
    Scaffold(
      body: SafeArea(
        child: Center(
          child: ImagePickerInput(),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          // `IndexedStack` is used to keep state in tabs. If possible, look
          // for a better solution. @Jeton
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF282a57), Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: IndexedStack(
              index: activeTab.index,
              children: _tabs,
            ),
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              bottomOpacity: 0.0,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                'Tomka',
                style: TextStyle(color: Colors.indigoAccent),
              ),
              leading: IconButton(
                icon: Icon(Icons.ac_unit),
                color: Colors.indigoAccent,
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.supervised_user_circle,
                    color: Colors.indigoAccent,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 50,
            child: TabSelector(
              activeTab: activeTab,
              onTabSelected: (tab) =>
                  BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: TomkaFloatingActionButton(
            onPressed: () {
              showCupertinoModalBottomSheet(
                expand: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context, scrollController) => ListingCreationScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
