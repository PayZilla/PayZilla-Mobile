import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuListTile extends StatelessWidget {
  const MenuListTile({
    Key? key,
    required this.title,
    this.assetName,
    this.trailingWidget,
    this.onMenuTapped,
  }) : super(key: key);
  final String title;
  final String? assetName;
  final Widget? trailingWidget;
  final Function? onMenuTapped;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onMenuTapped == null) return;
        onMenuTapped!;
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Container(
          color: Colors.transparent,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: assetName != null
                ? SizedBox(
                    width: 30,
                    height: 30,
                    child: assetName!.endsWith('svg')
                        ? SvgPicture.asset(
                            assetName!,
                          )
                        : Image.asset(
                            assetName!,
                            scale: 0.8,
                          ),
                  )
                : null,
            trailing: trailingWidget ??
                const Icon(
                  Icons.chevron_right,
                ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: const Color(0xff333D47),
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
