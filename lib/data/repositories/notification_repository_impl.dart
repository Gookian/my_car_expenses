import 'package:my_car_expenses/data/data_sources/database/notification/notification_data_source.dart';
import 'package:my_car_expenses/data/models/notification/notification_model.dart';
import 'package:my_car_expenses/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDataSource dataSource;

  NotificationRepositoryImpl({required this.dataSource});

  @override
  Future<int> add(NotificationModel notificationModel) => dataSource.create(notificationModel: notificationModel);
}