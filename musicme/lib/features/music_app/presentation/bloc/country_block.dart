import 'package:bloc/bloc.dart';
import 'package:musicme/features/music_app/data/data_provider/query_params_provider.dart';
import 'package:musicme/features/music_app/presentation/bloc/country_event.dart';

class CountryBloc extends Bloc<CountryEvent, List> {
  final QueryParamsProvider countryProvider;

  CountryBloc(List initialState, this.countryProvider) : super(initialState);
  @override
  Stream<List> mapEventToState(CountryEvent event) async* {
    if (event is AddCountryEvent) {
      var params;
      try {
        await countryProvider.addUserCountry(event.countryInput);
      } catch (e) {
        print("we could not write to the file");
      }
      try {
        params = await countryProvider.readParams('musicme');
      } catch (e) {
        print("we could not read to the file");
      }

      yield params.countries;
    } else if (event is RemoveCountryEvent) {
      await countryProvider.removeUserCountry(event.countryInput);
      var params = await countryProvider.readParams('musicme');
      yield params.countries;
    } else if (event is LoadCountryEvent) {
      var params = await countryProvider.readParams('musicme');
      yield params.countries;
    }
  }
}
