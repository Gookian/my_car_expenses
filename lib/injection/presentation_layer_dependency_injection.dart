import 'package:get_it/get_it.dart';
import 'package:my_car_expenses/domain/converters/car_make_converter.dart';
import 'package:my_car_expenses/domain/converters/car_model_converter.dart';
import 'package:my_car_expenses/domain/entities/category_type.dart';
import 'package:my_car_expenses/domain/use_cases/documents/get_documents_by_car_id_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/vehicle_info/get_makes_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/vehicle_info/get_model_id_by_name_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/vehicle_info/get_models_use_case.dart';
import 'package:my_car_expenses/presentation/bloc/screens/cars_screen/cars_cubit.dart';
import 'package:my_car_expenses/presentation/bloc/screens/create_car_screen/create_car_cubit.dart';
import 'package:my_car_expenses/presentation/bloc/screens/document_screen/document_cubit.dart';
import 'package:my_car_expenses/presentation/enum/create_cubit_type.dart';
import 'package:my_car_expenses/domain/use_cases/car/get/get_car_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/creating_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/car/get/get_all_car_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/get/get_expenses_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/get_category/get_category_data_on_month_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/structure/get_structure_use_case.dart';
import 'package:my_car_expenses/presentation/bloc/screens/base_expense_screen/base_expense_cubit.dart';
import 'package:my_car_expenses/presentation/bloc/screens/create_screen/create_cubit.dart';
import 'package:my_car_expenses/presentation/bloc/screens/home_screen/home_cubit.dart';

class PresentationLayerDependencyInjection {
  final getIt = GetIt.instance;

  void injection() {
    getIt.registerFactory<HomeCubit>(() =>
        HomeCubit(
          getCategoryDataOnMonthUseCase: getIt<GetCategoryDataOnMonthUseCase>(),
          getAllCarUseCase: getIt<GetAllCarUseCase>(),
          getCarUseCase: getIt<GetCarUseCase>()
        )
    );
    getIt.registerFactoryParam<BaseExpenseCubit, CategoryType, String?>((param1, param2) =>
        BaseExpenseCubit(
            getExpensesUseCase: getIt<GetExpensesUseCase>(),
            getCarUseCase: getIt<GetCarUseCase>(),
            getAllCarUseCase: getIt<GetAllCarUseCase>(),
            category: param1
        )
    );
    getIt.registerFactory<CreateCarCubit>(() =>
        CreateCarCubit(
            getModelsUseCase: getIt<GetModelsUseCase>(),
            getMakesUseCase: getIt<GetMakesUseCase>(),
            creatingUseCase: getIt<CreatingUseCase>(instanceName: "CreatingCarUseCase"),
            getModelIdByNameUseCase: getIt<GetModelIdByNameUseCase>(),
            carModelConverter: getIt<CarModelConverter>(),
            carMakesConverter: getIt<CarMakeConverter>()
        )
    );
    getIt.registerFactory<CarsCubit>(() => CarsCubit(useCase: getIt<GetAllCarUseCase>()));
    getIt.registerFactory<DocumentCubit>(() =>
        DocumentCubit(
          getAllCarUseCase: getIt<GetAllCarUseCase>(),
          getDocumentsByCarIdUseCase: getIt<GetDocumentsByCarIdUseCase>()
        )
    );
    getIt.registerFactoryParam<CreateCubit, CreateCubitType, int?>((param1, param2) {
      switch (param1) {
        case CreateCubitType.fuelExpense:
          return CreateCubit(
            getStructureUseCase: getIt<GetStructureUseCase>(instanceName: "GetStructureFuelExpenseUseCase"),
            creatingUseCase: getIt<CreatingUseCase>(instanceName: "FuelExpenseCreationUseCase", param1: param2),
          );
        case CreateCubitType.washExpense:
          return CreateCubit(
            getStructureUseCase: getIt<GetStructureUseCase>(instanceName: "GetStructureWashExpenseUseCase"),
            creatingUseCase: getIt<CreatingUseCase>(instanceName: "WashExpenseCreationUseCase", param1: param2),
          );
        case CreateCubitType.consumableExpense:
          // TODO добавить потом
        case CreateCubitType.repairExpense:
          return CreateCubit(
            getStructureUseCase: getIt<GetStructureUseCase>(instanceName: "GetStructureRepairExpenseUseCase"),
            creatingUseCase: getIt<CreatingUseCase>(instanceName: "RepairExpenseCreationUseCase", param1: param2),
          );
        case CreateCubitType.towTruckExpense:
          return CreateCubit(
            getStructureUseCase: getIt<GetStructureUseCase>(instanceName: "GetStructureTowTruckExpenseUseCase"),
            creatingUseCase: getIt<CreatingUseCase>(instanceName: "TowTruckExpenseCreationUseCase", param1: param2),
          );
        case CreateCubitType.serviceExpense:
          return CreateCubit(
            getStructureUseCase: getIt<GetStructureUseCase>(instanceName: "GetStructureServiceExpenseUseCase"),
            creatingUseCase: getIt<CreatingUseCase>(instanceName: "ServiceExpenseCreationUseCase", param1: param2),
          );
        case CreateCubitType.tuningExpense:
          return CreateCubit(
            getStructureUseCase: getIt<GetStructureUseCase>(instanceName: "GetStructureTuningExpenseUseCase"),
            creatingUseCase: getIt<CreatingUseCase>(instanceName: "TuningExpenseCreationUseCase", param1: param2),
          );
        case CreateCubitType.parkingExpense:
          return CreateCubit(
            getStructureUseCase: getIt<GetStructureUseCase>(instanceName: "GetStructureParkingExpenseUseCase"),
            creatingUseCase: getIt<CreatingUseCase>(instanceName: "ParkingExpenseCreationUseCase", param1: param2),
          );
        case CreateCubitType.tollRoadExpense:
          return CreateCubit(
            getStructureUseCase: getIt<GetStructureUseCase>(instanceName: "GetStructureTollRoadExpenseUseCase"),
            creatingUseCase: getIt<CreatingUseCase>(instanceName: "TollRoadExpenseCreationUseCase", param1: param2),
          );
        case CreateCubitType.otherExpense:
          return CreateCubit(
            getStructureUseCase: getIt<GetStructureUseCase>(instanceName: "GetStructureOtherExpenseUseCase"),
            creatingUseCase: getIt<CreatingUseCase>(instanceName: "OtherExpenseCreationUseCase", param1: param2),
          );
        case CreateCubitType.vehicleRegistrationCertificate:
          return CreateCubit(
            getStructureUseCase: getIt<GetStructureUseCase>(instanceName: "GetStructureVehicleRegistrationCertificateUseCase"),
            creatingUseCase: getIt<CreatingUseCase>(instanceName: "VehicleRegistrationCertificateCreationUseCase", param1: param2),
          );
        case CreateCubitType.vehiclePassport:
          return CreateCubit(
            getStructureUseCase: getIt<GetStructureUseCase>(instanceName: "GetStructureVehiclePassportUseCase"),
            creatingUseCase: getIt<CreatingUseCase>(instanceName: "VehiclePassportCreationUseCase", param1: param2),
          );
        case CreateCubitType.insurance:
          return CreateCubit(
            getStructureUseCase: getIt<GetStructureUseCase>(instanceName: "GetStructureInsuranceUseCase"),
            creatingUseCase: getIt<CreatingUseCase>(instanceName: "InsuranceCreationUseCase", param1: param2),
          );
      }
    });
  }
}