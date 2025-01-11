import 'package:faker/faker.dart';
import 'package:revolvair/domain/entities/user.dart';
import 'faker_factory.dart';

class UserFaker implements FakerFactory<User>{


  @override
  User create() {
   return _createUser();
  }

  @override
  Future<List<User>> createMany(int amount) async{
    return List.generate(amount, (index) => _createUser());
  }

  User _createUser() {
    return User(
      name: faker.person.name(),
      email: faker.internet.email(),
      password: "admin1",
    );
  } 

}