import 'package:home_widget/home_widget.dart';

import 'news_data.dart';

class HomescreenUtils {
  static String iosName = 'NewsWidgets';
  static String androidName = 'NewsWidget';
  static String widgetName = 'NewsWidget';
  static String qualifiedAndroidName =
      'com.leighajarett.homescreen_widgets.$androidName';

  static const String methodChannelName =
      'example.widget.dev/get_container_path';

  static void updateHeadline(NewsArticle newHeadline) {
    // Save the headline data to the widget
    HomeWidget.saveWidgetData<String>('headline_title', newHeadline.title);
    HomeWidget.saveWidgetData<String>(
        'headline_description', newHeadline.description);
    HomeWidget.updateWidget(
      iOSName: 'NewsWidgets',
      androidName: 'NewsWidget',
    );
  }
}
