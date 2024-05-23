import 'package:my_car_expenses/data/models/structure/base_structure_model.dart';
import 'package:my_car_expenses/data/models/structure/documents/insurance_structure.dart';
import 'package:my_car_expenses/data/models/structure/documents/vehicle_passport_structure.dart';
import 'package:my_car_expenses/data/models/structure/documents/vehicle_registration_certificate_structure.dart';
import 'package:my_car_expenses/data/models/structure/expenses/fuel_expense_structure.dart';
import 'package:my_car_expenses/data/models/structure/expenses/other_expense_structure.dart';
import 'package:my_car_expenses/data/models/structure/expenses/parking_expense_structure.dart';
import 'package:my_car_expenses/data/models/structure/expenses/repair_expense_structure.dart';
import 'package:my_car_expenses/data/models/structure/expenses/service_expense_structure.dart';
import 'package:my_car_expenses/data/models/structure/expenses/toll_road_expense_structure.dart';
import 'package:my_car_expenses/data/models/structure/expenses/tow_truck_expense_structure.dart';
import 'package:my_car_expenses/data/models/structure/expenses/tuning_expense_structure.dart';
import 'package:my_car_expenses/data/models/structure/expenses/wash_expense_structure.dart';
import 'package:my_car_expenses/data/models/structure/structure_type_model.dart';

abstract interface class StructureDataSource {
  List<BaseStructureItemModel> getStructure(StructureTypeModel type);
}

class StructureDataSourceImpl implements StructureDataSource {
  @override
  List<BaseStructureItemModel> getStructure(StructureTypeModel type) {
    switch (type) {
      case StructureTypeModel.fuelExpense:
        return FuelExpenseStructure.structure;
      case StructureTypeModel.washExpense:
        return WashExpenseStructure.structure;
      case StructureTypeModel.consumableExpense:
        return [];// TODO: Handle this case.
      case StructureTypeModel.repairExpense:
        return RepairExpenseStructure.structure;
      case StructureTypeModel.towTruckExpense:
        return TowTruckExpenseStructure.structure;
      case StructureTypeModel.serviceExpense:
        return ServiceExpenseStructure.structure;
      case StructureTypeModel.tuningExpense:
        return TuningExpenseStructure.structure;
      case StructureTypeModel.parkingExpense:
        return ParkingExpenseStructure.structure;
      case StructureTypeModel.tollRoadExpense:
        return TollRoadExpenseStructure.structure;
      case StructureTypeModel.otherExpense:
        return OtherExpenseStructure.structure;
      case StructureTypeModel.vehicleRegistrationCertificate:
        return VehicleRegistrationCertificateStructure.structure;
      case StructureTypeModel.vehiclePassport:
        return VehiclePassportStructure.structure;
      case StructureTypeModel.insurance:
        return InsuranceStructure.structure;
    }
  }
}