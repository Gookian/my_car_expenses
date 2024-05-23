import 'package:get_it/get_it.dart';
import 'package:my_car_expenses/domain/converters/car_converter.dart';
import 'package:my_car_expenses/domain/converters/car_make_converter.dart';
import 'package:my_car_expenses/domain/converters/car_model_converter.dart';
import 'package:my_car_expenses/domain/converters/document_converter.dart';
import 'package:my_car_expenses/domain/converters/expense_converter.dart';
import 'package:my_car_expenses/domain/converters/structure_converter.dart';
import 'package:my_car_expenses/domain/entities/category_type.dart';
import 'package:my_car_expenses/domain/entities/document_type.dart';
import 'package:my_car_expenses/domain/repositories/car_repository.dart';
import 'package:my_car_expenses/domain/repositories/category_repository.dart';
import 'package:my_car_expenses/domain/repositories/documents_repository.dart';
import 'package:my_car_expenses/domain/repositories/expense_repository.dart';
import 'package:my_car_expenses/domain/repositories/structure_repository.dart';
import 'package:my_car_expenses/domain/repositories/vehicle_info_repository.dart';
import 'package:my_car_expenses/domain/use_cases/car/get/get_all_car_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/car/get/get_car_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/car/get/get_car_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/creating_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/car/create/creating_car_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/car/get/get_all_car_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/documents/create/insurance_creation_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/documents/create/vehicle_passport_creation_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/documents/create/vehicle_registration_certificate_creation_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/documents/get_documents_by_car_id_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/create/fuel_expense_creation_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/create/other_expense_creation_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/create/parking_expense_creation_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/create/repair_expense_creation_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/create/service_expense_creation_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/create/toll_road_expense_creation_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/create/tow_truck_expense_creation_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/create/tuning_expense_creation_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/create/wash_expense_creation_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/get/get_expenses_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/get/get_expenses_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/get_category/get_category_data_on_month_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/get_category/get_category_data_on_month_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/structure/documents/get_structure_document_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/structure/expenses/get_structure_expense_use_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/structure/get_structure_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/vehicle_info/get_fuel_types_case_impl.dart';
import 'package:my_car_expenses/domain/use_cases/vehicle_info/get_fuel_types_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/vehicle_info/get_makes_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/vehicle_info/get_model_id_by_name_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/vehicle_info/get_models_use_case.dart';

class DomainLayerDependencyInjection {
  final getIt = GetIt.instance;

  void injection() {
    getIt.registerSingleton<GetCategoryDataOnMonthUseCase>(
        GetCategoryDataOnMonthUseCaseImpl(
            categoryRepository: getIt<CategoryRepository>(),
            expenseRepository: getIt<ExpenseRepository>()
        )
    );
    getIt.registerSingleton<CarConverter>(CarConverter(repository: getIt<VehicleInfoRepository>()));
    getIt.registerSingleton<CreatingUseCase>(
        CreatingCarUseCaseImpl(
            repository: getIt<CarRepository>(),
            converter: getIt<CarConverter>()
        ),
        instanceName: "CreatingCarUseCase"
    );

    getIt.registerSingleton<CarMakeConverter>(CarMakeConverter());
    getIt.registerSingleton<CarModelConverter>(CarModelConverter());
    getIt.registerSingleton<GetModelsUseCase>(GetModelsUseCaseImpl(repository: getIt<VehicleInfoRepository>()));
    getIt.registerSingleton<GetMakesUseCase>(GetMakesUseCaseImpl(repository: getIt<VehicleInfoRepository>()));
    getIt.registerSingleton<GetModelIdByNameUseCase>(GetModelIdByNameUseCaseImpl(repository: getIt<VehicleInfoRepository>()));

    getIt.registerSingleton<DocumentConverter>(DocumentConverter());
    getIt.registerSingleton<GetDocumentsByCarIdUseCase>(
        GetDocumentsByCarIdUseCaseImpl(repository: getIt<DocumentRepository>(), converter: getIt<DocumentConverter>())
    );

    getIt.registerSingleton<ExpenseConverter>(ExpenseConverter());
    getIt.registerFactoryParam<CreatingUseCase, int?, int?>((param1, param2) =>
        FuelExpenseCreationUseCaseImpl(
            expenseRepository: getIt<ExpenseRepository>(),
            carRepository: getIt<CarRepository>(),
            converter: getIt<ExpenseConverter>(),
            carId: param1!
        ),
        instanceName: "FuelExpenseCreationUseCase"
    );
    getIt.registerFactoryParam<CreatingUseCase, int?, int?>((param1, param2) =>
        WashExpenseCreationUseCaseImpl(
            expenseRepository: getIt<ExpenseRepository>(),
            carRepository: getIt<CarRepository>(),
            converter: getIt<ExpenseConverter>(),
            carId: param1!
        ),
        instanceName: "WashExpenseCreationUseCase"
    );
    getIt.registerFactoryParam<CreatingUseCase, int?, int?>((param1, param2) =>
        OtherExpenseCreationUseCaseImpl(
            expenseRepository: getIt<ExpenseRepository>(),
            carRepository: getIt<CarRepository>(),
            converter: getIt<ExpenseConverter>(),
            carId: param1!
        ),
        instanceName: "OtherExpenseCreationUseCase"
    );
    getIt.registerFactoryParam<CreatingUseCase, int?, int?>((param1, param2) =>
        ParkingExpenseCreationUseCaseImpl(
            expenseRepository: getIt<ExpenseRepository>(),
            carRepository: getIt<CarRepository>(),
            converter: getIt<ExpenseConverter>(),
            carId: param1!
        ),
        instanceName: "ParkingExpenseCreationUseCase"
    );
    getIt.registerFactoryParam<CreatingUseCase, int?, int?>((param1, param2) =>
        RepairExpenseCreationUseCaseImpl(
            expenseRepository: getIt<ExpenseRepository>(),
            carRepository: getIt<CarRepository>(),
            converter: getIt<ExpenseConverter>(),
            carId: param1!
        ),
        instanceName: "RepairExpenseCreationUseCase"
    );
    getIt.registerFactoryParam<CreatingUseCase, int?, int?>((param1, param2) =>
        ServiceExpenseCreationUseCaseImpl(
            expenseRepository: getIt<ExpenseRepository>(),
            carRepository: getIt<CarRepository>(),
            converter: getIt<ExpenseConverter>(),
            carId: param1!
        ),
        instanceName: "ServiceExpenseCreationUseCase"
    );
    getIt.registerFactoryParam<CreatingUseCase, int?, int?>((param1, param2) =>
        TollRoadExpenseCreationUseCaseImpl(
            expenseRepository: getIt<ExpenseRepository>(),
            carRepository: getIt<CarRepository>(),
            converter: getIt<ExpenseConverter>(),
            carId: param1!
        ),
        instanceName: "TollRoadExpenseCreationUseCase"
    );
    getIt.registerFactoryParam<CreatingUseCase, int?, int?>((param1, param2) =>
        TowTruckExpenseCreationUseCaseImpl(
            expenseRepository: getIt<ExpenseRepository>(),
            carRepository: getIt<CarRepository>(),
            converter: getIt<ExpenseConverter>(),
            carId: param1!
        ),
        instanceName: "TowTruckExpenseCreationUseCase"
    );
    getIt.registerFactoryParam<CreatingUseCase, int?, int?>((param1, param2) =>
        TuningExpenseCreationUseCaseImpl(
            expenseRepository: getIt<ExpenseRepository>(),
            carRepository: getIt<CarRepository>(),
            converter: getIt<ExpenseConverter>(),
            carId: param1!
        ),
        instanceName: "TuningExpenseCreationUseCase"
    );

    getIt.registerFactoryParam<CreatingUseCase, int?, int?>((param1, param2) =>
        VehicleRegistrationCertificateCreationUseCaseImpl(
            repository: getIt<DocumentRepository>(),
            converter: getIt<DocumentConverter>(),
            carId: param1!
        ),
        instanceName: "VehicleRegistrationCertificateCreationUseCase"
    );
    getIt.registerFactoryParam<CreatingUseCase, int?, int?>((param1, param2) =>
        VehiclePassportCreationUseCaseImpl(
            repository: getIt<DocumentRepository>(),
            converter: getIt<DocumentConverter>(),
            carId: param1!
        ),
        instanceName: "VehiclePassportCreationUseCase"
    );
    getIt.registerFactoryParam<CreatingUseCase, int?, int?>((param1, param2) =>
        InsuranceCreationUseCaseImpl(
            repository: getIt<DocumentRepository>(),
            converter: getIt<DocumentConverter>(),
            carId: param1!
        ),
        instanceName: "InsuranceCreationUseCase"
    );

    getIt.registerSingleton<GetExpensesUseCase>(
        GetExpensesUseCaseImpl(
            repository: getIt<ExpenseRepository>(),
            converter: getIt<ExpenseConverter>()
        )
    );
    getIt.registerSingleton<GetAllCarUseCase>(
        GetAllCarUseCaseImpl(
            repository: getIt<CarRepository>(),
            converter: getIt<CarConverter>()
        )
    );
    getIt.registerSingleton<GetCarUseCase>(
        GetCarUseCaseImpl(
            repository: getIt<CarRepository>(),
            converter: getIt<CarConverter>()
        )
    );
    getIt.registerSingleton<GetFuelTypesUseCase>(
        GetFuelTypesUseCaseImpl(
            repository: getIt<VehicleInfoRepository>()
        )
    );

    getIt.registerSingleton<StructureConverter>(StructureConverter());
    getIt.registerSingleton<GetStructureUseCase>(
        GetStructureExpenseUseCaseImpl(
            repository: getIt<StructureRepository>(),
            converter: getIt<StructureConverter>(),
            type: CategoryType.fuelExpense
        ),
        instanceName: "GetStructureFuelExpenseUseCase"
    );
    getIt.registerSingleton<GetStructureUseCase>(
        GetStructureExpenseUseCaseImpl(
            repository: getIt<StructureRepository>(),
            converter: getIt<StructureConverter>(),
            type: CategoryType.washExpense
        ),
        instanceName: "GetStructureWashExpenseUseCase"
    );
    getIt.registerSingleton<GetStructureUseCase>(
        GetStructureExpenseUseCaseImpl(
            repository: getIt<StructureRepository>(),
            converter: getIt<StructureConverter>(),
            type: CategoryType.otherExpense
        ),
        instanceName: "GetStructureOtherExpenseUseCase"
    );
    getIt.registerSingleton<GetStructureUseCase>(
        GetStructureExpenseUseCaseImpl(
            repository: getIt<StructureRepository>(),
            converter: getIt<StructureConverter>(),
            type: CategoryType.parkingExpense
        ),
        instanceName: "GetStructureParkingExpenseUseCase"
    );
    getIt.registerSingleton<GetStructureUseCase>(
        GetStructureExpenseUseCaseImpl(
            repository: getIt<StructureRepository>(),
            converter: getIt<StructureConverter>(),
            type: CategoryType.repairExpense
        ),
        instanceName: "GetStructureRepairExpenseUseCase"
    );
    getIt.registerSingleton<GetStructureUseCase>(
        GetStructureExpenseUseCaseImpl(
            repository: getIt<StructureRepository>(),
            converter: getIt<StructureConverter>(),
            type: CategoryType.serviceExpense
        ),
        instanceName: "GetStructureServiceExpenseUseCase"
    );
    getIt.registerSingleton<GetStructureUseCase>(
        GetStructureExpenseUseCaseImpl(
            repository: getIt<StructureRepository>(),
            converter: getIt<StructureConverter>(),
            type: CategoryType.tollRoadExpense
        ),
        instanceName: "GetStructureTollRoadExpenseUseCase"
    );
    getIt.registerSingleton<GetStructureUseCase>(
        GetStructureExpenseUseCaseImpl(
            repository: getIt<StructureRepository>(),
            converter: getIt<StructureConverter>(),
            type: CategoryType.towTruckExpense
        ),
        instanceName: "GetStructureTowTruckExpenseUseCase"
    );
    getIt.registerSingleton<GetStructureUseCase>(
        GetStructureExpenseUseCaseImpl(
            repository: getIt<StructureRepository>(),
            converter: getIt<StructureConverter>(),
            type: CategoryType.tuningExpense
        ),
        instanceName: "GetStructureTuningExpenseUseCase"
    );

    getIt.registerSingleton<GetStructureUseCase>(
        GetStructureDocumentUseCaseImpl(
            repository: getIt<StructureRepository>(),
            converter: getIt<StructureConverter>(),
            type: DocumentType.vehicleRegistrationCertificate
        ),
        instanceName: "GetStructureVehicleRegistrationCertificateUseCase"
    );
    getIt.registerSingleton<GetStructureUseCase>(
        GetStructureDocumentUseCaseImpl(
            repository: getIt<StructureRepository>(),
            converter: getIt<StructureConverter>(),
            type: DocumentType.vehiclePassport
        ),
        instanceName: "GetStructureVehiclePassportUseCase"
    );
    getIt.registerSingleton<GetStructureUseCase>(
        GetStructureDocumentUseCaseImpl(
            repository: getIt<StructureRepository>(),
            converter: getIt<StructureConverter>(),
            type: DocumentType.insurance
        ),
        instanceName: "GetStructureInsuranceUseCase"
    );
  }
}