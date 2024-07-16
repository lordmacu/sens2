import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:sens2/core/services/first_task_handler.dart';

class ForegroundTaskService {
  ReceivePort? _receivePort;

  @pragma('vm:entry-point')
  static void startCallback() {
    FlutterForegroundTask.setTaskHandler(FirstTaskHandler());
  }

  Future<void> requestPermissions() async {
    if (!await FlutterForegroundTask.canDrawOverlays) {
      await FlutterForegroundTask.openSystemAlertWindowSettings();
    }

    if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
      await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    }

    final NotificationPermission notificationPermissionStatus = await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermissionStatus != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }
  }

  Future<void> initForegroundTask() async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'foreground_service',
        channelName: 'Foreground Service Notification',
        channelDescription: 'This notification appears when the foreground service is running.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),
        buttons: [
          const NotificationButton(id: 'sendButton', text: 'Send'),
          const NotificationButton(id: 'testButton', text: 'Test'),
        ],
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000,
        isOnceEvent: false,
        autoRunOnBoot: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<bool> startForegroundTask() async {
    await FlutterForegroundTask.saveData(key: 'customData', value: 'hello');

    final ReceivePort? receivePort = FlutterForegroundTask.receivePort;
    final bool isRegistered = registerReceivePort(receivePort);
    if (!isRegistered) {
      print('Failed to register receivePort!');
      return false;
    }

    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        notificationTitle: 'Sens esta online',
        notificationText: 'Tap para volver al app',
        callback: startCallback,
      );
    }
  }

  bool registerReceivePort(ReceivePort? newReceivePort) {
    if (newReceivePort == null) {
      return false;
    }

    closeReceivePort();

    _receivePort = newReceivePort;
    _receivePort?.listen((data) {
      if (data is String) {
        DateTime timestamp = DateTime.parse(data);
        print('timestamp: ${timestamp.toString()}');
      } else if (data is int) {
        print('eventCount: $data');
      } else if (data == 'onNotificationPressed') {
        // Handle notification pressed event
      }
    });

    return _receivePort != null;
  }

  void closeReceivePort() {
    _receivePort?.close();
    _receivePort = null;
  }
}