import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class BottomNavigationContainer extends StatefulWidget {
  const BottomNavigationContainer({
    Key? key,
    required this.selectedTab,
    required this.hideNav,
  }) : super(key: key);

  final PZillaTab selectedTab;
  final bool hideNav;

  @override
  _BottomNavigationContainerState createState() =>
      _BottomNavigationContainerState();
}

class _BottomNavigationContainerState extends State<BottomNavigationContainer>
    with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    if (widget.hideNav) {
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
            if (tab == PZillaTab.none) return;
            PZilla.of(context).push(PZillaRoutes.tab(tab));
          },
          items: [
            BottomAppBarItem(
              icon: LocalSvgImage(homeInActive),
              activeIcon: LocalSvgImage(homeActive),
              title: 'Home',
              tab: PZillaTab.home,
            ),
            BottomAppBarItem(
              icon: LocalSvgImage(walletInactive),
              activeIcon: LocalSvgImage(
                walletInactive,
                color: AppColors.borderColor,
              ),
              title: 'Wallet',
              tab: PZillaTab.wallet,
            ),
            BottomAppBarItem(
              icon: const SizedBox.shrink(),
              activeIcon: const SizedBox.shrink(),
              title: ' ',
              tab: PZillaTab.none,
            ),
            BottomAppBarItem(
              icon: LocalSvgImage(referralInactive),
              activeIcon: LocalSvgImage(referralInactive),
              title: 'Referral',
              tab: PZillaTab.referral,
            ),
            BottomAppBarItem(
              icon: LocalSvgImage(payBillsInactive),
              activeIcon: LocalSvgImage(
                payBillsInactive,
                color: AppColors.borderColor,
              ),
              title: 'Profile',
              tab: PZillaTab.profile,
            ),
          ],
        ),
        Positioned(
          top: -25,
          left: context.getWidth(.39),
          child: GestureDetector(
            onTap: () {
              Log().debug('Send money tab');
            },
            child: Container(
              height: context.getHeight(0.07),
              width: context.getHeight(0.1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.borderColor,
              ),
              child: Center(
                child: LocalSvgImage(logo),
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
  PZillaTab tab;
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
  final PZillaTab selectedTab;
  final Function(PZillaTab) onTabSelected;

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
                    fontWeight: FontWeight.w500,
                    fontSize: Insets.dim_10,
                    letterSpacing: .2,
                    fontStyle: FontStyle.normal,
                    color: widget.selectedTab == item.tab
                        ? AppColors.borderColor
                        : const Color(0xFFCACACA),
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
