import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_health/controller/ClientController.dart';


class StorageController extends ClientController {
  Storage? storage;
  @override
  void onInit() {
    super.onInit();
    // appwrite
    storage = Storage(client);
  }

  Future storeImage(File file) async {
    try {
      final result = await storage!.createFile(
        bucketId: '656871a497f0043b7247',
        fileId: ID.unique(),
        file: InputFile.fromPath(
          path: file.path,
          filename: 'image.jpg',
        ),
      );
      print("StorageController:: storeImage $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Storage",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }

  Future<List<String>> listImages() async {
    try {
      final result = await storage!.listFiles(
        bucketId: '656871a497f0043b7247',
      );
      List<String> imageUrls = [];
      for (var file in result.files) {
        String imageUrl = storage!.getFileView(
          bucketId: '656871a497f0043b7247',
          fileId: file.$id,
        ) as String;
        imageUrls.add(imageUrl);
      }
      return imageUrls;
    } catch (error) {
      Get.defaultDialog(
        title: "Error Storage",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
      return [];
    }
  }
}