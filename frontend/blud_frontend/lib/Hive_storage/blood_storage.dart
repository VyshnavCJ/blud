import 'package:hive/hive.dart';

part 'blood_storage.g.dart';

@HiveType(typeId: 1)
class BloodStorage {
  BloodStorage(
      {required this.token,
      required this.phoneNumber,
      required this.requestID});

  @HiveField(0)
  String token;

  @HiveField(1)
  String phoneNumber;

  @HiveField(3)
  String requestID;
}
