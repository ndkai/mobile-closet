part of '../../pages/root_view.dart';

GlobalKey<_LocalRootViewState> rootScreenKey = GlobalKey<_LocalRootViewState>();
class _LocalRootView extends StatefulWidget {
  const _LocalRootView({super.key});

  @override
  State<_LocalRootView> createState() => _LocalRootViewState();
}

class _LocalRootViewState extends State<_LocalRootView> {
  late int currentIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;
  }
  // final List<Widget> _pages = [
  //   const HomeScreen(),
  //   const StatisticScreen(),
  //   const HomeScreen(),
  //   const NotificationScreen(),
  //   const DnbcScreen(),
  // ];

  @override
  Widget build(BuildContext context) {
    AppTheme().initCurrentTheme(Theme.of(context));
    SizeConfig().init(context);
    return PopScope(onPopInvoked: (v){
      UI.onWillPop(context);
    }, child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
      //   IndexedStack(
      //   index: currentIndex,
      //   children: _pages,
      // ),
          _getCurrentPage(),
          CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: Colors.white,
            buttonBackgroundColor: Colors.transparent,
            animationDuration: const Duration(milliseconds: 300),
            index: 2,
            items: [
              NavItem(
                img: currentIndex == 0
                    ? Assets.iconsHome
                    : Assets.iconsHome,
                label: S.current.home,
                isActive: currentIndex == 0,
              ),
              NavItem(
                  img: currentIndex == 1
                      ? Assets.iconsHome
                      : Assets.iconsHome,
                  label: "Closet",
                  isActive: currentIndex == 1),
              SvgPicture.asset(Assets.iconsHome),
              NavItem(
                  img: currentIndex == 3
                      ? Assets.iconsHome
                      : Assets.iconsHome,
                  label: "Favorite",
                  isActive: currentIndex == 3),
              NavItem(
                  img: currentIndex == 4
                      ? Assets.iconsHome
                      : Assets.iconsHome,
                  label: "Explore",
                  isActive: currentIndex == 4),
            ],
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
              _navAction(index);
            },
          ).align(Alignment.bottomCenter)
        ],
      ),
    ));
  }


  void _navAction(int index) {
    switch (index) {
      case 2:
        context.push(AppRoutes.openAccountScreen);
    }
  }

  void changeIndex(int newIndex){
    setState(() {
      currentIndex = newIndex;
    });
  }

  Widget _getCurrentPage() {
    setState(() {});
    switch (currentIndex) {
      case 0:
        return const ClosetScreen();
      case 1:
        return const CategoryManageScreen();
      case 2:
        return const HomeScreen();
      case 3:
        return const HomeScreen();
      default:
        return const HomeScreen();
    }
  }
}
