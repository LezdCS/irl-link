# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Google Play Core - Not included (incompatible with SDK 34+)
# Flutter references these classes for deferred components, but we're not using them
# Suppress warnings about missing classes
-dontwarn com.google.android.play.core.**
-dontwarn com.google.android.play.core.splitcompat.**
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**

# Gson (used by Firebase)
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# GetX
-keep class com.github.jonataslaw.** { *; }
-keepclassmembers class * extends io.flutter.plugin.common.PluginRegistry {
    public *;
}

# GetStorage
-keep class com.tekartik.sqflite.** { *; }
-keep class com.tekartik.sqflite.** { *; }

# Flutter Downloader
-keep class vn.hunghd.flutterdownloader.** { *; }

# Flutter Foreground Task
-keep class com.pravera.flutter_foreground_task.** { *; }

# Flutter Local Notifications
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# Geolocator
-keep class com.baseflow.geolocator.** { *; }

# Wakelock
-keep class dev.creativecreationcompany.wakelock.** { *; }

# Kick Chat
-keep class com.kickchat.** { *; }

# Twitch Chat
-keep class com.twitch.** { *; }

# OBS WebSocket
-keep class com.obs.** { *; }

# Mobile Scanner
-keep class dev.steenbakker.mobile_scanner.** { *; }

# WebView
-keep class io.flutter.plugins.webviewflutter.** { *; }

# In-App Purchase
-keep class com.dooboolab.** { *; }

# Permission Handler
-keep class com.baseflow.permissionhandler.** { *; }

# Path Provider
-keep class io.flutter.plugins.pathprovider.** { *; }

# File Picker
-keep class com.mr.flutter.plugin.filepicker.** { *; }

# Audio Players
-keep class xyz.luan.audioplayers.** { *; }

# Connectivity Plus
-keep class dev.fluttercommunity.plus.connectivity.** { *; }

# Flutter Web Auth 2
-keep class com.linusu.flutter_web_auth_2.** { *; }

# Flutter TTS
-keep class com.tundralabs.fluttertts.** { *; }

# Package Info Plus
-keep class io.flutter.plugins.packageinfo.** { *; }

# URL Launcher
-keep class io.flutter.plugins.urllauncher.** { *; }

# Share Plus
-keep class dev.fluttercommunity.plus.share.** { *; }

# Store Checker
-keep class com.jaumard.storechecker.** { *; }

# App Links
-keep class com.llfbandit.app_links.** { *; }

# Flutter SVG
-keep class com.flutter.** { *; }

# Talker
-keep class io.github.pavelicat.talker.** { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep Parcelable implementations
-keepclassmembers class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator CREATOR;
}

# Keep Serializable classes
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep annotations
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses
-keepattributes Signature

# Keep line numbers for stack traces
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

