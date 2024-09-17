import 'package:flutter/material.dart';
import 'package:my_hand/config/routes/app_router.dart';
import 'package:my_hand/config/routes/routes.dart';
import 'package:my_hand/config/theme/colors.dart';
import 'package:my_hand/core/helpers/spacing.dart';
import 'package:my_hand/core/widgets/textbuilder.dart';
import 'package:my_hand/my_app.dart';

class SideNav extends StatefulWidget {
  const SideNav({super.key});

  @override
  State<SideNav> createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  final drawer = DrawersController();
  static bool isCollapse = false;

  void collapseDrawer() {
    setState(() {
      isCollapse = !isCollapse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: isCollapse ? 90 : 180,
      child: Material(
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // logo
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: isCollapse ? 80.0 : 100.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                          color: ColorsManager.black,
                          offset: Offset(1.0, 1.0),
                        )
                      ],
                      borderRadius:
                          isCollapse ? null : BorderRadius.circular(10),
                      color: Colors.white),
                  child: Center(
                    child: ListTile(
                      leading: CircleAvatar(
                          maxRadius: isCollapse ? 20.0 : 55.0,
                          backgroundImage:
                              AssetImage('assets/images/khayrat_logoo.png'),
                          child: Text('a')),
                    ),
                  ),
                ),
              ),
              verticalSpace(10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: drawer.sideDrawer.length,
                itemBuilder: (BuildContext context, int i) {
                  return ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _navigateToRoute(context, i);
                    },
                    leading: Icon(
                      drawer.sideDrawer[i].icon,
                      color: ColorsManager.black,
                    ),
                    title: isCollapse
                        ? null
                        : TextBuilder(
                            text: drawer.sideDrawer[i].title!,
                            fontSize: 18.0,
                            color: ColorsManager.black,
                          ),
                  );
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MyApp(appRouter: AppRouter())),
                      (route) => false);
                },
                leading: const Icon(
                  Icons.power_settings_new,
                  color: ColorsManager.black,
                ),
                title: isCollapse
                    ? null
                    : const TextBuilder(
                        text: 'Log out',
                        fontSize: 18.0,
                        color: ColorsManager.black,
                      ),
              ),
              IconButton(
                  onPressed: collapseDrawer,
                  icon: isCollapse
                      ? const Icon(Icons.arrow_forward_ios)
                      : const Icon(Icons.arrow_back_ios))
            ],
          ),
        )),
      ),
    );
  }
}

void _navigateToRoute(BuildContext context, int index) {
  String routeName;
  switch (index) {
    case 0:
      routeName = Routes.orderScreen;
      break;
    case 1:
      routeName = Routes.customerScreen;
      break;
    case 2:
      routeName = Routes.customerScreen;
      break;
    // Handle additional cases if necessary
    default:
      routeName = Routes.orderScreen;
  }
  Navigator.pushNamed(context, routeName);
}

class DrawersController {
  final sideDrawer = [
    DrawerModel('الرئيسية', Icons.home),
    DrawerModel('موردين', Icons.receipt_long),
    DrawerModel('عملاء', Icons.account_balance),
    DrawerModel('مخزون', Icons.person),
    DrawerModel('إعدادات', Icons.settings),
    DrawerModel('Share App', Icons.share),
  ];
}

class DrawerModel {
  final String? title;
  final IconData? icon;

  DrawerModel(this.title, this.icon);
}
