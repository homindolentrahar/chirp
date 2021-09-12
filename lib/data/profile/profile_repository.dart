import 'dart:developer';
import 'dart:io';

import 'package:chirp/constants/storage_constants.dart';
import 'package:chirp/constants/table_constants.dart';
import 'package:chirp/data/profile/dtos/profile_user_dto.dart';
import 'package:chirp/error/app_errors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  final Supabase _supabase;

  ProfileRepository({required Supabase supabase}) : _supabase = supabase;

  Future<bool> userExists(String userId) async {
    final response = await _supabase.client
        .from(TableConstants.USER_PROFILE_TABLE)
        .select()
        .eq("id", userId)
        .single()
        .execute();

    if (response.error != null && response.status != 406) {
      //  throw error
      throw AppError("${response.error!.code}: ${response.error!.message}");
    } else {
      //  success getting single user profile
      return response.data != null;
    }
  }

  Future<ProfileUserDto> getProfileUser(String userId) async {
    final response = await _supabase.client
        .from(TableConstants.USER_PROFILE_TABLE)
        .select()
        .eq("id", userId)
        .single()
        .execute();

    if (response.error != null && response.status != 406) {
      //  throw error
      throw AppError("${response.error!.code}: ${response.error!.message}");
    } else {
      //  success getting single user profile
      final jsonData = response.data as Map<String, dynamic>;
      return ProfileUserDto.fromJson(jsonData);
    }
  }

  Future<void> addProfileUser(ProfileUserDto dto) async {
    if (dto.avatarUrl.isNotEmpty &&
        dto.avatarUrl.startsWith("/data/user/0/com.homindolentrahar.chirp")) {
      final file = File(dto.avatarUrl);

      final storageResponse = await _supabase.client.storage
          .from(StorageConstants.AVATARS_STORAGE)
          .upload(dto.userId.toString(), file);

      final downloadAvatar = await _supabase.client.storage
          .from(StorageConstants.AVATARS_STORAGE)
          .download(dto.userId.toString());

      log("Storage response: ${storageResponse.data}");

      dto.avatarUrl = downloadAvatar.data!.join(", ");

      log("Updated avatar: ${dto.avatarUrl}");
    }

    final addedData = dto.toJson();
    final response = await _supabase.client
        .from(TableConstants.USER_PROFILE_TABLE)
        .insert([addedData]).execute();

    if (response.error != null) {
      //  throw error
      throw AppError("${response.error!.code}: ${response.error!.message}");
    }
  }

  Future<void> updateProfileUser(String userId, ProfileUserDto dto) async {
    final updatedValue = dto.toJson();
    final response = await _supabase.client
        .from(TableConstants.USER_PROFILE_TABLE)
        .update(updatedValue)
        .eq("id", userId)
        .execute();

    if (response.error != null) {
      //  throw error
      throw AppError("${response.error!.code}: ${response.error!.message}");
    }
  }

  Future<void> deleteProfileUser(String userId) async {
    final response = await _supabase.client
        .from(TableConstants.USER_PROFILE_TABLE)
        .delete()
        .eq("id", userId)
        .execute();

    if (response.error != null) {
      //  throw error
      throw AppError("${response.error!.code}: ${response.error!.message}");
    }
  }
}
