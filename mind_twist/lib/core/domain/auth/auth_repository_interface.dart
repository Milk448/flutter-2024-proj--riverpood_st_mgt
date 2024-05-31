abstract class AuthRepositoryInterface {
  Future<void> signUp({required String username, required String password});

  Future<void> signIn({required String username, required String password});

  Future<void> signOut();
}
