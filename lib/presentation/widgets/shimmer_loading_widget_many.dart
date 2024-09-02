import 'package:cool_app/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class ShimmerLoadingWidgetMany extends StatelessWidget {
  final double itemBuilderHeight;
  final double separatorBuilderHeight;
  final int itemCount;

  const ShimmerLoadingWidgetMany({
    Key? key,
    required this.itemBuilderHeight,
    required this.separatorBuilderHeight,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ShimmerLoadingWidget(
          height: itemBuilderHeight,
          width: MediaQuery.of(context).size.width,
          borderRadius: 20,
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: separatorBuilderHeight,
        );
      },
      itemCount: itemCount,
    );
  }
}
