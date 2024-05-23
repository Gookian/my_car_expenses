import 'package:my_car_expenses/data/models/notification/notification_model.dart';

abstract interface class NotificationRepository {
  Future<int> add(NotificationModel notificationModel);
}