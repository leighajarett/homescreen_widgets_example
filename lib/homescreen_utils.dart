import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';
import 'package:homescreen_widgets/news_data.dart';

class HomescreenUtils {
  // This callback can be triggered from Android code
  static void backgroundCallback(Uri? data) async {
    print("backgroundCallback URI = $data}");
  }

  // Saves data to device storage, so it can be fetched by the Homescreen Widget later
  static void saveHomescreenWidgetData(NewsArticle article) {
    try {
      HomeWidget.saveWidgetData<String>('headline_title', article.title);
      HomeWidget.saveWidgetData<String>(
          'headline_description', article.description);
    } on PlatformException catch (error) {
      print('Error updating widget: $error');
    }
  }

  // Tells the Homescreen Widget to fetch the data currently saved in device storage
  static void updateHomescreenWidget() {
    // Force the widgets to update?
    try {
      HomeWidget.updateWidget(
        name: 'NewsWidget',
        androidName: 'NewsWidget',
        iOSName: 'NewsWidgets',
      );
    } on PlatformException catch (error) {
      print('Error updating widget: $error');
    }
  }

  // Gets the data from device storage
  static void getHomescreenWidgetData({
    String property = 'headline_title',
    String defaultValue = 'Default Value',
  }) {
    Future.wait([
      HomeWidget.getWidgetData<String>(property, defaultValue: defaultValue)
    ]).then(
      (value) => print(value),
    );
  }
}
