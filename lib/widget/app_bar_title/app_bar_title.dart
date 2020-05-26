import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

const double _kDefaultTitleSize = 17;
const double _kDefaultVerticalTitleSize = 20;
const double _kDefaultVerticalSubtitleSize = 17;

enum AppBarTitleLayout {
  horizontal,
  vertical,
}

enum AppBarPosition {
  left,
  right,
}

class AppBarTitle extends StatelessWidget {
  AppBarTitle({Key key, @required this.title, this.titleStyle, this.subtitle, this.subtitleStyle, this.layout = AppBarTitleLayout.horizontal, this.showLoading = false, this.loadingPosition = AppBarPosition.left, this.customAccessoryWidget, this.accessoryPosition = AppBarPosition.right})
      : assert(title != null),
        super(key: key);

  final String title;
  final TextStyle titleStyle;
  final String subtitle;
  final TextStyle subtitleStyle;
  final bool showLoading;
  final AppBarTitleLayout layout;
  final AppBarPosition loadingPosition;
  final Widget customAccessoryWidget;
  final AppBarPosition accessoryPosition;

  Widget _buildTitles() {
    List<Widget> titles = [];
    if (title != null) {
      double tSize = layout == AppBarTitleLayout.horizontal ? _kDefaultTitleSize : _kDefaultVerticalTitleSize;
      TextStyle tStyle = titleStyle ??
          TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: tSize,
          );
      Widget titleWidget = AutoSizeText(
        title,
        style: tStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
//        textAlign: TextAlign.end,
      );
      titles.add(titleWidget);
    }

    if (subtitle != null) {
      Widget inset = layout == AppBarTitleLayout.horizontal ? SizedBox(width: 5) : SizedBox(height: 3);
      titles.add(inset);

      double sSize = layout == AppBarTitleLayout.horizontal ? _kDefaultTitleSize : _kDefaultVerticalSubtitleSize;
      TextStyle sStyle = subtitleStyle ?? TextStyle(fontWeight: FontWeight.w300, fontSize: sSize);
      AutoSizeText subtitleWidget = AutoSizeText(
        subtitle,
        style: sStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
      );
      titles.add(subtitleWidget);
    }

    if (layout == AppBarTitleLayout.horizontal) {
      return Row(mainAxisSize: MainAxisSize.min, children: titles);
    } else {
      return Expanded(
        child: Column(
          children: titles,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      );
    }
  }

  Widget _buildLoadingIndicator(Color tintColor) {
    return Transform.scale(
        scale: 0.4,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation(tintColor),
        ));
  }

  _widgetInsetsAdd(List<Widget> list, Widget widget) {
    if (list.length > 0) {
      list.add(SizedBox(width: 3));
    }
    list.add(widget);
  }

  @override
  Widget build(BuildContext context) {
    final Widget titleWidget = _buildTitles();
    ThemeData themeData = Theme.of(context);
    final Color tintColor = themeData.appBarTheme.textTheme?.headline6?.color ?? themeData.primaryTextTheme.headline6.color;
    List<Widget> children = [];

    // build left
    if (loadingPosition == AppBarPosition.left && showLoading) {
      children.add(_buildLoadingIndicator(tintColor));
    }
    if (accessoryPosition == AppBarPosition.left && customAccessoryWidget != null) {
      _widgetInsetsAdd(children, customAccessoryWidget);
    }

    // add title
    _widgetInsetsAdd(children, titleWidget);

    // build right
    if (accessoryPosition == AppBarPosition.right && customAccessoryWidget != null) {
      _widgetInsetsAdd(children, customAccessoryWidget);
    }
    if (loadingPosition == AppBarPosition.right && showLoading) {
      _widgetInsetsAdd(children, _buildLoadingIndicator(tintColor));
    }

    return Row(
//      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
