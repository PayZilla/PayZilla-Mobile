import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';

class FutureBottomSheet<T> extends StatelessWidget with BaseBottomSheetMixin {
  const FutureBottomSheet({
    required this.future,
    required this.itemBuilder,
    this.onItemSelected,
    this.height,
    this.desc,
    this.title,
    this.searchWidget,
    this.isDismissible = true,
    Key? key,
  }) : super(key: key);

  final Future<List<T>> Function() future;
  final Function(T)? onItemSelected;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget? searchWidget;
  final double? height;
  final String? title, desc;
  final bool isDismissible;

  @override
  Widget build(BuildContext context) {
    final child = FutureBuilder<List<T>>(
      future: future(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              if (searchWidget != null) ...[
                searchWidget!,
                const YBox(Insets.dim_18),
              ],
              ListView.builder(
                physics: const PageScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      if (onItemSelected != null) {
                        onItemSelected!(item);
                      } else {
                        AppNavigator.of(context).popDialog(item);
                      }
                    },
                    child: itemBuilder(context, item),
                  );
                },
              ),
            ],
          );
        }
        if (snapshot.hasError) {
          return const AfrichangeErrorWidget();
        }
        return const AfrichangeLoadingWidget();
      },
    );

    return BaseBottomSheet(
      height: height,
      title: title,
      desc: desc,
      isDismissible: isDismissible,
      child: child,
    );
  }
}
