import 'package:flutter/material.dart';

class CommonSliverAppBar extends StatelessWidget {
  final Widget? leading;
  final String title;
  final List<Widget>? actions;
  final bool? floating;
  final Color? backgroundColor;
  final double? titleSpacing;
  final double? expandedHeight;
  final bool? centerTitle;
  final bool? pinned;
  final bool? snap;
  final Widget? flexibleSpace;
  final CollapseMode? collapseMode;
  final EdgeInsetsGeometry? titlePadding;
  final VoidCallback? onPressed;

  // final Widget? leading;
  //      final bool automaticallyImplyLeading = true;
  //  Widget? title,
  //      List<Widget>? actions,
  //  Widget? flexibleSpace,
  //      PreferredSizeWidget? bottom,
  //  double? elevation,
  //      double? scrolledUnderElevation,
  //  Color? shadowColor,
  //      Color? surfaceTintColor,
  //  bool forceElevated = false,
  //      Color? backgroundColor,
  //  Color? foregroundColor,
  //      IconThemeData? iconTheme,
  //  IconThemeData? actionsIconTheme,
  //      bool primary = true,
  //  bool? centerTitle,
  //      bool excludeHeaderSemantics = false,
  //  double? titleSpacing,
  //      double? collapsedHeight,
  //  double? expandedHeight,
  //      bool floating = false,
  //  bool pinned = true,
  //      bool snap = false,
  //  bool stretch = false,

  const CommonSliverAppBar({
    Key? key,
    required this.title,
    this.leading,
   this.actions,
    this.backgroundColor,
    this.titleSpacing,
    this.expandedHeight,
    this.centerTitle,
    this.flexibleSpace,
    this.collapseMode,
    this.titlePadding,
    this.floating,
    this.snap,
    this.pinned,
     this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      expandedHeight: 200,
      backgroundColor: Colors.teal,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(title),
        titlePadding: const EdgeInsets.only(bottom: 8.5),
        collapseMode: CollapseMode.pin,
      ),

    );
  }
}
