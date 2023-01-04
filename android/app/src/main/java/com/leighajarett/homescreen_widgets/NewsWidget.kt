package com.leighajarett.homescreen_widgets

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import java.io.File


/**
 * Implementation of App Widget functionality.
 */
class NewsWidget : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.news_widget).apply {
                // Open App on Widget Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_container, pendingIntent)

                // Swap Title Text by calling Dart Code in the Background
                setTextViewText(R.id.headline_title, widgetData.getString("headline_title", null)
                    ?: "No Title Set")
                val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(
                    context,
                    Uri.parse("homewidgetexample://titleclicked")
                )
                setOnClickPendingIntent(R.id.headline_title, backgroundIntent)

                val message = widgetData.getString("headline_description", null)
                setTextViewText(R.id.headline_description, message
                    ?: "No Message Set")
                // Detect App opened via Click inside Flutter
                val pendingIntentWithData = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java,
                    Uri.parse("homewidgetexample://message?message=$message"))
                setOnClickPendingIntent(R.id.headline_description, pendingIntentWithData)


                // Get chart image and put it in the widget, if it exists
                val imageName = widgetData.getString("filename", null)
                val imageFile = File("${context.filesDir.path}/${imageName}")
                val imageExists = imageFile.exists()
                if (imageExists) {
                    println("image found @: ${imageFile.path}")
                    val myBitmap: Bitmap = BitmapFactory.decodeFile(imageFile.absolutePath)
                    setImageViewBitmap(R.id.widget_image, myBitmap)

                } else {
                    println("image not found!, looked @: ${context.filesDir.path}/${imageName}")
                }


            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }


    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}