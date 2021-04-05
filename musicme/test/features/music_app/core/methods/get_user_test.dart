import 'package:flutter_test/flutter_test.dart';
import 'package:musicme/features/music_app/core/methods/get_user.dart';
import 'package:musicme/features/music_app/data/entities/user.dart';
import 'package:musicme/features/music_app/data/local_data/user_data.dart';

void main() {
  test('Testing intializeNewUser using an authToken', () async {
    var authenticationToken =
        'BQCA2SjZHQipLyqaGMV1yTfc-9Cdrg_qosmqVDN16O6sIS6K8ag0CaLS0LEnBY7G4XpS4tcZZKE-4NK2gwUjxYfjeytmM-IQKqPsdH8HiZJ1DFbsLwoPo-U935uNWY-lyxkcqJU718saBX55QvxlRMDOmVN4sVEkMvshCKwESOAqTomW8ac';
    User user = await getUserData(authenticationToken);
    await userValidation(user);
    print(userGLOBAL.email);
    expect(user.email, "erikd234");
  });
}
