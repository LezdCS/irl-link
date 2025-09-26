import 'package:dartz/dartz.dart';
import 'package:irllink/src/core/failure.dart';
import 'package:irllink/src/core/usecases/usecase.dart';
import 'package:irllink/src/domain/entities/dashboard_event.dart';
import 'package:irllink/src/domain/repositories/settings_repository.dart';

class GetDashboardEventsUseCase
    extends UseCase<Either<Failure, List<DashboardEvent>>, void> {
  final SettingsRepository repository;

  GetDashboardEventsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<DashboardEvent>>> call({
    required void params,
  }) async {
    return repository.getDashboardEvents();
  }
}
