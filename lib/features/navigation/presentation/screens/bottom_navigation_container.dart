import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/qr/qr.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class BottomNavigationContainer extends StatefulWidget {
  const BottomNavigationContainer({
    Key? key,
    required this.selectedTab,
    required this.hideNav,
  }) : super(key: key);

  final AppNavTab selectedTab;
  final bool hideNav;

  @override
  State<BottomNavigationContainer> createState() =>
      _BottomNavigationContainerState();
}

class _BottomNavigationContainerState extends State<BottomNavigationContainer>
    with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    if (widget.hideNav || authProvider.showNavBar) {
      return Container();
    }
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.passthrough,
      children: [
        BottomAppBar(
          color: const Color(0xFFA6AAB4),
          selectedColor: AppColors.borderColor,
          backgroundColor: AppColors.grey,
          selectedTab: widget.selectedTab,
          height: context.getHeight(0.08),
          onTabSelected: (tab) {
            if (tab == AppNavTab.none) return;
            AppNavigator.of(context).push(AppRoutes.tab(tab));
          },
          items: [
            BottomAppBarItem(
              icon: LocalSvgImage(
                homeInActive,
                height: 22,
              ),
              activeIcon: LocalSvgImage(
                homeActive,
                height: 25,
              ),
              title: 'Home',
              tab: AppNavTab.home,
            ),
            BottomAppBarItem(
              icon: LocalSvgImage(
                myCardInactive,
                height: 22,
              ),
              activeIcon: LocalSvgImage(
                myCardActive,
                height: 22,
              ),
              title: 'My Card',
              tab: AppNavTab.card,
            ),
            BottomAppBarItem(
              icon: const SizedBox.shrink(),
              activeIcon: const SizedBox.shrink(),
              title: ' ',
              tab: AppNavTab.none,
            ),
            BottomAppBarItem(
              icon: LocalSvgImage(
                activityInactive,
                height: 22,
              ),
              activeIcon: LocalSvgImage(
                activityActive,
                height: 22,
              ),
              title: 'Activity',
              tab: AppNavTab.activity,
            ),
            BottomAppBarItem(
              icon: LocalSvgImage(
                profileInactive,
                height: 22,
              ),
              activeIcon: LocalSvgImage(
                profileActive,
                height: 22,
              ),
              title: 'Profile',
              tab: AppNavTab.profile,
            ),
          ],
        ),
        Positioned(
          top: -5,
          left: context.getWidth(.39),
          child: GestureDetector(
            onTap: () => AppNavigator.of(context).push(
              AppRoutes.qrShowScan,
              args: QrShowScreenArgs('238838392923848'),
            ),
            child: Container(
              height: context.getHeight(0.07),
              width: context.getHeight(0.1),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.appSecondaryColor,
              ),
              child: Center(
                child: LocalSvgImage(
                  scanSvg,
                  height: context.getHeight(0.04),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BottomAppBarItem {
  BottomAppBarItem({
    required this.icon,
    required this.activeIcon,
    required this.title,
    required this.tab,
  });
  Widget icon;
  Widget activeIcon;
  String title;
  AppNavTab tab;
}

class BottomAppBar extends StatefulWidget {
  const BottomAppBar({
    Key? key,
    required this.items,
    this.height = Insets.dim_66,
    required this.backgroundColor,
    required this.color,
    required this.selectedColor,
    required this.selectedTab,
    required this.onTabSelected,
  })  : assert(
          items.length >= 2 || items.length <= 5,
          'List of bottom nav must be 2-5',
        ),
        super(key: key);

  final List<BottomAppBarItem> items;
  final double height;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final AppNavTab selectedTab;
  final Function(AppNavTab) onTabSelected;

  @override
  State<StatefulWidget> createState() => BottomAppBarState();
}

class BottomAppBarState extends State<BottomAppBar> {
  @override
  Widget build(BuildContext context) {
    final items = widget.items.map((tabItem) {
      return _buildTabItem(
        item: tabItem,
        onPressed: () {
          widget.onTabSelected(tabItem.tab);
        },
      );
    }).toList();

    items.insert(items.length >> 1, _buildMiddleTabItem());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items,
    );
  }

  Widget _buildMiddleTabItem() {
    return SizedBox(
      height: widget.height,
      child: const SizedBox(height: Insets.dim_30),
    );
  }

  Widget _buildTabItem({
    required BottomAppBarItem item,
    required Function() onPressed,
  }) {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        width: Insets.dim_30,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onPressed,
            child: Column(
              children: [
                const YBox(7),
                if (widget.selectedTab == item.tab)
                  item.activeIcon
                else
                  item.icon,
                const YBox(Insets.dim_4),
                Text(
                  item.title,
                  style: TextStyle(
                    fontFamily: kFontFamily,
                    fontWeight: widget.selectedTab == item.tab
                        ? FontWeight.w700
                        : FontWeight.w500,
                    fontSize: Insets.dim_12,
                    letterSpacing: .2,
                    fontStyle: FontStyle.normal,
                    color: widget.selectedTab == item.tab
                        ? AppColors.textHeaderColor
                        : AppColors.textBodyColor,
                  ),
                ),
                const YBox(Insets.dim_18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
