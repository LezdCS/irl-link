import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:irllink/data/database/database_helper.dart';
import 'package:irllink/src/core/params/kick_auth_params.dart';
import 'package:irllink/src/core/params/twitch_auth_params.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/speaker_service.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/domain/entities/settings/tts_settings.dart';
import 'package:irllink/src/domain/usecases/kick/login_usecase.dart';
import 'package:irllink/src/domain/usecases/kick/logout_usecase.dart';
import 'package:irllink/src/domain/usecases/tts/get_tts_settings_usecase.dart';
import 'package:irllink/src/domain/usecases/tts/set_tts_settings_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/get_twitch_users_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/login_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/logout_usecase.dart';
import 'package:irllink/src/presentation/controllers/home_view_controller.dart';
import 'package:path_provider/path_provider.dart';

class SettingsViewController extends GetxController {
  SettingsViewController({
    required this.logoutUseCase,
    required this.loginUseCase,
    required this.getTwitchUsersUseCase,
    required this.settingsService,
    required this.homeViewController,
    required this.ttsService,
    required this.storeService,
    required this.logoutKickUseCase,
    required this.loginKickUseCase,
    required this.getTtsSettingsUsecase,
    required this.setTtsSettingsUsecase,
  });

  final LogoutUseCase logoutUseCase;
  final LoginUseCase loginUseCase;
  final GetTwitchUsersUseCase getTwitchUsersUseCase;
  final LogoutKickUseCase logoutKickUseCase;
  final LoginKickUseCase loginKickUseCase;
  final GetTtsSettingsUsecase getTtsSettingsUsecase;
  final SetTtsSettingsUsecase setTtsSettingsUsecase;

  final SettingsService settingsService;
  final HomeViewController homeViewController;
  final TtsService ttsService;
  final StoreService storeService;

  RxBool rtIrlKeyShow = false.obs;

  late TextEditingController rtIrlInputController;

  // Download progress tracking
  final RxMap<String, DownloadTaskStatus> downloadStatus =
      <String, DownloadTaskStatus>{}.obs;
  final RxMap<String, int> downloadProgress = <String, int>{}.obs;

  // Available backups reactive list
  final RxList<File> availableBackups = <File>[].obs;

  final ReceivePort _port = ReceivePort();

  Rxn<TtsSettings> ttsSettings = Rxn<TtsSettings>();

  @override
  void onInit() async {
    Settings settings = settingsService.settings.value;

    rtIrlInputController = TextEditingController(text: settings.rtIrlPushKey);

    // Setup download progress listening
    _setupDownloadListener();

    // Load available backups
    loadAvailableBackups();

    await getTtsSettings();

    super.onInit();
  }

  @override
  void onClose() {
    _port.close();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.onClose();
  }

  Future<void> getTtsSettings() async {
    final result = await getTtsSettingsUsecase(params: null);
    result.fold(
      (l) {
        Get.snackbar(
          "Error",
          "Failed to get TTS settings: $l",
        );
      },
      (r) {
        ttsSettings.value = r;
      },
    );
  }

  Future<void> setTtsSettings(TtsSettings ttsSettings) async {
    final result = await setTtsSettingsUsecase(params: ttsSettings);
    result.fold(
      (l) {},
      (r) {},
    );
    getTtsSettings();
    ttsService.getTtsSettings();
  }

  void _setupDownloadListener() {
    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    _port.listen((data) {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus.fromInt(data[1]);
      int progress = data[2];

      downloadStatus[id] = status;
      downloadProgress[id] = progress;

      // Handle download completion
      if (status == DownloadTaskStatus.complete) {
        Get.snackbar(
          "Download Complete",
          "Backup file downloaded successfully",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.download_done, color: Colors.green),
          borderWidth: 1,
          borderColor: Colors.green,
        );
      } else if (status == DownloadTaskStatus.failed) {
        Get.snackbar(
          "Download Failed",
          "Failed to download backup file",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.error_outline, color: Colors.red),
          borderWidth: 1,
          borderColor: Colors.red,
        );
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  void updateKeepSpeakerOn({required bool value}) {
    settingsService.settings.value = settingsService.settings.value.copyWith(
      generalSettings: settingsService.settings.value.generalSettings.copyWith(
        keepSpeakerOn: value,
      ),
    );
    settingsService.saveSettings();

    if (Get.isRegistered<SpeakerService>()) {
      Get.find<SpeakerService>().updateSettings(settingsService.settings.value);
    }
  }

  Future<void> logout() async {
    if (homeViewController.twitchData.value == null) {
      return;
    }

    final logoutResult = await logoutUseCase(
      params: homeViewController.twitchData.value!.accessToken,
    );

    logoutResult.fold(
      (l) {
        Get.snackbar(
          "Error",
          "Logout failed: $l",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.error_outline, color: Colors.red),
          borderWidth: 1,
          borderColor: Colors.red,
        );
      },
      (r) {
        homeViewController.twitchData.value = null;
        Get.snackbar(
          "Twitch",
          "Successfully logged out",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.check, color: Colors.green),
          borderWidth: 1,
          borderColor: Colors.green,
        );
      },
    );
  }

  Future<void> login() async {
    final loginResult = await loginUseCase(
      params: const TwitchAuthParams(),
    );

    loginResult.fold(
      (l) {
        Get.snackbar(
          "Error",
          "Login failed: $l",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.error_outline, color: Colors.red),
          borderWidth: 1,
          borderColor: Colors.red,
        );
      },
      (r) {
        homeViewController.twitchData.value = r;
        Get.snackbar(
          "Twitch",
          "Successfully logged in",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.check, color: Colors.green),
          borderWidth: 1,
          borderColor: Colors.green,
        );
      },
    );
  }

  Future<void> loginKick() async {
    final loginResult = await loginKickUseCase(
      params: KickAuthParams.withPKCE(),
    );

    loginResult.fold(
      (l) {
        Get.snackbar(
          "Error",
          "Login failed: $l",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.error_outline, color: Colors.red),
          borderWidth: 1,
          borderColor: Colors.red,
        );
      },
      (r) {
        homeViewController.kickData.value = r;
        Get.snackbar(
          "Kick",
          "Successfully logged in",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.check, color: Colors.green),
          borderWidth: 1,
          borderColor: Colors.green,
        );
      },
    );
  }

  List<dynamic> getVoiceForLanguage(String language) {
    return ttsService.ttsVoices.where((v) => v['locale'] == language).toList();
  }

  Future<void> logoutKick() async {
    if (homeViewController.kickData.value == null) {
      return;
    }

    final logoutResult = await logoutKickUseCase(
      params: homeViewController.kickData.value!.accessToken,
    );

    logoutResult.fold(
      (l) {
        Get.snackbar(
          "Error",
          "Logout failed: $l",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.error_outline, color: Colors.red),
          borderWidth: 1,
          borderColor: Colors.red,
        );
      },
      (r) {
        homeViewController.kickData.value = null;
        Get.snackbar(
          "Kick",
          "Successfully logged out",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.check, color: Colors.green),
          borderWidth: 1,
          borderColor: Colors.green,
        );
      },
    );
  }

  /// Export database to Downloads folder
  Future<void> exportDatabase() async {
    try {
      // Get Documents directory for temporary file creation
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'irllink_backup_$timestamp.json';
      final filePath = '${directory.path}/$fileName';

      // Export database to temporary location
      await DatabaseHelper.instance.exportDatabaseDump(filePath);

      // Get Downloads directory
      Directory? downloadsDirectory;
      if (Platform.isAndroid) {
        try {
          // Try to use the standard Downloads directory
          downloadsDirectory = Directory('/storage/emulated/0/Download');
          if (!downloadsDirectory.existsSync()) {
            // Fallback to external storage directory if available
            final externalDir = await getExternalStorageDirectory();
            if (externalDir != null) {
              downloadsDirectory = Directory('${externalDir.path}/Download');
            }
          }
        } catch (e) {
          // If all fails, use documents directory
          downloadsDirectory = await getApplicationDocumentsDirectory();
        }
      } else if (Platform.isIOS) {
        downloadsDirectory = await getApplicationDocumentsDirectory();
      }

      if (downloadsDirectory != null) {
        try {
          // Ensure Downloads directory exists
          if (!downloadsDirectory.existsSync()) {
            await downloadsDirectory.create(recursive: true);
          }

          // Copy file directly to Downloads directory
          final targetPath = '${downloadsDirectory.path}/$fileName';
          await File(filePath).copy(targetPath);

          Get.snackbar(
            "Backup Complete",
            "Database backup saved to Downloads: $fileName",
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Icons.download_done, color: Colors.green),
            borderWidth: 1,
            borderColor: Colors.green,
            duration: const Duration(seconds: 5),
          );

          // Add the new backup to the reactive list
          availableBackups.insert(0, File(filePath));
        } catch (e) {
          // Fallback: just show success for the internal file
          Get.snackbar(
            "Backup",
            "Database exported to app storage: $fileName\nError accessing Downloads: $e",
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Icons.backup, color: Colors.orange),
            borderWidth: 1,
            borderColor: Colors.orange,
            duration: const Duration(seconds: 5),
          );

          // Add the new backup to the reactive list
          availableBackups.insert(0, File(filePath));
        }
      } else {
        // Fallback: just show success for the internal file
        Get.snackbar(
          "Backup",
          "Database exported successfully to: $fileName",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.backup, color: Colors.green),
          borderWidth: 1,
          borderColor: Colors.green,
          duration: const Duration(seconds: 5),
        );

        // Add the new backup to the reactive list
        availableBackups.insert(0, File(filePath));
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to export database: $e",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error_outline, color: Colors.red),
        borderWidth: 1,
        borderColor: Colors.red,
      );
    }
  }

  /// Import database from a file path
  /// This method expects the file to be already in the app's accessible storage
  Future<void> importDatabase(String filePath) async {
    try {
      // Validate file exists
      final file = File(filePath);
      if (!file.existsSync()) {
        throw Exception('Backup file not found');
      }

      // Show confirmation dialog
      final shouldImport = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Import Database'),
          content: const Text(
            'This will replace all current data with the backup data. This action cannot be undone. Continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Import'),
            ),
          ],
        ),
      );

      if (shouldImport != true) {
        return;
      }

      // Import database
      await DatabaseHelper.instance.importDatabaseDump(filePath);

      Get.snackbar(
        "Restore",
        "Database imported successfully. Please restart the app.",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.restore, color: Colors.green),
        borderWidth: 1,
        borderColor: Colors.green,
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to import database: $e",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error_outline, color: Colors.red),
        borderWidth: 1,
        borderColor: Colors.red,
      );
    }
  }

  /// Get list of available backup files
  Future<List<File>> getAvailableBackups() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final files = directory
          .listSync()
          .whereType<File>()
          .where(
            (file) =>
                file.path.contains('irllink_backup_') &&
                file.path.endsWith('.json'),
          )
          .toList();

      // Sort by modification date (newest first)
      files
          .sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));

      return files;
    } catch (e) {
      return [];
    }
  }

  /// Delete a backup file
  Future<void> deleteBackup(String filePath) async {
    try {
      final file = File(filePath);
      final fileName = file.path.split('/').last;

      // Show confirmation dialog
      final shouldDelete = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Delete Backup'),
          content: Text(
            'Are you sure you want to delete this backup?\n\n$fileName\n\nThis action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (shouldDelete != true) {
        return;
      }

      // Delete the file
      if (file.existsSync()) {
        await file.delete();

        Get.snackbar(
          "Delete",
          "Backup deleted successfully",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.delete, color: Colors.orange),
          borderWidth: 1,
          borderColor: Colors.orange,
        );

        // Remove the backup from the reactive list
        availableBackups.removeWhere((backup) => backup.path == filePath);
      } else {
        throw Exception('Backup file not found');
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete backup: $e",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error_outline, color: Colors.red),
        borderWidth: 1,
        borderColor: Colors.red,
      );
    }
  }

  /// Share backup file using system sharing
  Future<void> shareBackupFile(String filePath) async {
    try {
      final file = File(filePath);
      final fileName = file.path.split('/').last;

      if (!file.existsSync()) {
        throw Exception('Backup file not found');
      }

      // Create a temporary file in the app's temporary directory for sharing
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/$fileName');
      await file.copy(tempFile.path);

      Get.snackbar(
        "Share Ready",
        "Backup file prepared for sharing: $fileName",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.share, color: Colors.blue),
        borderWidth: 1,
        borderColor: Colors.blue,
      );

      // Note: You might want to integrate with a sharing plugin like share_plus
      // For now, we'll just show the file location
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to prepare file for sharing: $e",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error_outline, color: Colors.red),
        borderWidth: 1,
        borderColor: Colors.red,
      );
    }
  }

  /// Download/copy an existing backup file to Downloads folder
  Future<void> downloadBackup(String filePath) async {
    try {
      final file = File(filePath);
      final fileName = file.path.split('/').last;

      if (!file.existsSync()) {
        throw Exception('Backup file not found');
      }

      // Get Downloads directory
      Directory? downloadsDirectory;
      if (Platform.isAndroid) {
        downloadsDirectory = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        downloadsDirectory = await getApplicationDocumentsDirectory();
      }

      if (downloadsDirectory != null && downloadsDirectory.existsSync()) {
        // Copy file to Downloads directory
        final targetPath = '${downloadsDirectory.path}/$fileName';
        await file.copy(targetPath);

        Get.snackbar(
          "Download Complete",
          "Backup copied to Downloads: $fileName",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.download_done, color: Colors.green),
          borderWidth: 1,
          borderColor: Colors.green,
          duration: const Duration(seconds: 5),
        );
      } else {
        // Fallback to sharing
        await shareBackupFile(filePath);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to download backup: $e",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error_outline, color: Colors.red),
        borderWidth: 1,
        borderColor: Colors.red,
      );
    }
  }

  /// Load available backups into the reactive list
  Future<void> loadAvailableBackups() async {
    try {
      final backups = await getAvailableBackups();
      availableBackups.value = backups;
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load available backups: $e",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error_outline, color: Colors.red),
        borderWidth: 1,
        borderColor: Colors.red,
      );
    }
  }

  /// Refresh the backups list manually
  Future<void> refreshBackups() async {
    await loadAvailableBackups();
  }

  /// Import database from a file selected by the user
  Future<void> importDatabaseFromFile() async {
    try {
      // Show file picker to select a JSON file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        dialogTitle: 'Select Backup File to Import',
      );

      if (result != null && result.files.single.path != null) {
        final filePath = result.files.single.path!;

        // Validate that it's a backup file by checking the name pattern
        final fileName = result.files.single.name;
        if (!fileName.contains('irllink_backup_') ||
            !fileName.endsWith('.json')) {
          Get.snackbar(
            "Invalid File",
            "Please select a valid IRL Link backup file (should contain 'irllink_backup_' and end with '.json')",
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Icons.warning, color: Colors.orange),
            borderWidth: 1,
            borderColor: Colors.orange,
            duration: const Duration(seconds: 5),
          );
          return;
        }

        // Import the selected file
        await importDatabase(filePath);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to select or import file: $e",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error_outline, color: Colors.red),
        borderWidth: 1,
        borderColor: Colors.red,
      );
    }
  }
}
