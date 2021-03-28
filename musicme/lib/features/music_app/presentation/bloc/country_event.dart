import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CountryEvent extends Equatable {}

class AddCountryEvent extends CountryEvent {
  final String countryInput;

  AddCountryEvent({@required this.countryInput}) : assert(countryInput != null);
  @override
  List<Object> get props => [countryInput];
}

class RemoveCountryEvent extends CountryEvent {
  final String countryInput;

  RemoveCountryEvent({@required this.countryInput})
      : assert(countryInput != null);
  @override
  List<Object> get props => [countryInput];
}

class LoadCountryEvent extends CountryEvent {
  @override
  List<Object> get props => [];
}
