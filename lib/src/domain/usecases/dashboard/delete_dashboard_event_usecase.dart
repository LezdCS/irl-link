import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class DeleteDashboardEventUseCase
    extends UseCase<Either<Failure, void>, DashboardEvent> {
  final SettingsRepository repository;

  DeleteDashboardEventUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call({required DashboardEvent params}) async {
    return repository.removeDashboardEvent(params);
  }
}
