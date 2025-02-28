
import '../../../../core/usecases/usecases.dart';

import '../repositories/auth_repo.dart';
class IsUserSignedIn implements NormalUsecase<bool, NoParams>{
  final AuthRepo _authRepo;
  IsUserSignedIn(this._authRepo);

  @override
  bool call(NoParams params) {
    return _authRepo.isUserSignedIn();
  }
}