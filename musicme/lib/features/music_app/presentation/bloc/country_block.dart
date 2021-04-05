import 'package:bloc/bloc.dart';
import 'package:musicme/features/music_app/data/data_provider/query_params_provider.dart';
import 'package:musicme/features/music_app/presentation/bloc/country_event.dart';
import 'package:musicme/features/music_app/data/local_data/user_data.dart';
// GLOBAL VARIABLE in use called userGLOBAL

class CountryBloc extends Bloc<CountryEvent, List> {
  final QueryParamsProvider countryProvider;

  CountryBloc(List initialState, this.countryProvider) : super(initialState);
  @override
  Stream<List> mapEventToState(CountryEvent event) async* {
    if (event is AddCountryEvent) {
      var params;
      try {
        await countryProvider.addUserCountries(event.countryInput, userGLOBAL);
      } catch (e) {
        print("we could not write to the file");
      }
      try {
        params = await countryProvider.readParams(userGLOBAL);
      } catch (e) {
        print("we could not read to the file");
      }

      yield params.countries;
    } else if (event is RemoveCountryEvent) {
      await countryProvider.removeUserCountries(event.countryInput, userGLOBAL);
      var params = await countryProvider.readParams(userGLOBAL);
      yield params.countries;
    } else if (event is LoadCountryEvent) {
      var params = await countryProvider.readParams(userGLOBAL);
      yield params.countries;
    }
  }
}
