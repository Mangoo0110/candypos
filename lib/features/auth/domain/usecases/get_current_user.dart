
import '../../../../core/usecases/usecases.dart';
import '../entities/user_auth.dart';
import '../repositories/auth_repo.dart';

class GetCurrentUserAuth implements NormalUsecase<Stream<UserAuth?>, NoParams> {

  final AuthRepo _authRepo;

  GetCurrentUserAuth(this._authRepo);

  @override
  Stream<UserAuth?> call(NoParams noParams) {
    return _authRepo.currentUserAuth;
  }

}