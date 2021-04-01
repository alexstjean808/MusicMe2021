import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicme/features/music_app/data/data_provider/query_params_provider.dart';
import 'package:musicme/features/music_app/presentation/bloc/country_block.dart';
import 'package:musicme/features/music_app/presentation/bloc/country_event.dart';

class CountryPage extends StatelessWidget {
  // list of countrys we want to display
  final List _countrys = [
    ['Afghanistan', 'Albania'],
    ['America', 'Argentina'],
    ['Armenia', 'Australia'],
    ['Austria', 'Bahamas'],
    ['Barbados', 'Belarus'],
    ['Belgium', 'Bosnia'],
    ['Brazil', 'Bulgaria'],
    ['Cambodia', 'Canada'],
    ['China', 'Chile'],
    ['Colombia', 'Croatia'],
    ['Czech', 'Denmark'],
    ['Ecuador', 'Egypt'],
    ['England', 'Estonia'],
    ['Ethiopia', 'Finland'],
    ['France', 'Gabon'],
    ['Georgia', 'Germany'],
    ['Ghana', 'Greece'],
    ['Guatemala', 'Haiti'],
    ['Hong Kong', 'Hungary'],
    ['Iceland', 'India'],
    ['Indonesia', 'Ireland'],
    ['Israel', 'Italy'],
    ['Japan', 'Latvia'],
    ['Lebanon', 'Libya'],
    ['Lithuania', 'Malaysia'],
    ['Mexico', 'Moldova'],
    ['Mongolia', 'Morocco'],
    ['Nepal', 'Netherlands'],
    ['New Zealand', 'Nigeria'],
    ['Northern Ireland', 'North Macedonia'],
    ['Norway', 'Pakistan'],
    ['Peru', 'Philippines'],
    ['Poland', 'Portugal'],
    ['Romania', 'Russia'],
    ['Scotland', 'Serbia'],
    ['Singapore', 'Slovakia'],
    ['Slovenia', 'South Africa'],
    ['South Korea', 'Spain'],
    ['Sweden', 'Swiss'],
    ['Taiwan', 'Thailand'],
    ['Tunisia', 'Turkey'],
    ['Uganda', 'United Kingdom'],
    ['United Kingdomraine', 'Uzbekistan'],
    ['Vancouver', 'Venezuela'],
    ['Vietnam', 'Wales'],
    ['Yugoslavia', 'Zambia']
  ];

  // these are colors but will be image URI's when we find images we want
  final List _imageAssets = [
    ['assets/images/Afghanistan.png', 'assets/images/Albania.png'],
    ['assets/images/America.png', 'assets/images/Argentina.png'],
    ['assets/images/Armenia.png', 'assets/images/Australia.png'],
    ['assets/images/Austria.png', 'assets/images/Bahamas.png'],
    ['assets/images/Barbados.png', 'assets/images/Belarus.png'],
    ['assets/images/Belgium.png', 'assets/images/Bosnia.png'],
    ['assets/images/Brazil.png', 'assets/images/Bulgaria.png'],
    ['assets/images/Cambodia.png', 'assets/images/Canada.png'],
    ['assets/images/China.png', 'assets/images/Chile.png'],
    ['assets/images/Colombia.png', 'assets/images/Croatia.png'],
    ['assets/images/Czech.png', 'assets/images/Denmark.png'],
    ['assets/images/Ecuador.png', 'assets/images/Egypt.png'],
    ['assets/images/England.png', 'assets/images/Estonia.png'],
    ['assets/images/Ethiopia.png', 'assets/images/Finland.png'],
    ['assets/images/France.png', 'assets/images/Gabon.png'],
    ['assets/images/Georgia.png', 'assets/images/Germany.png'],
    ['assets/images/Ghana.png', 'assets/images/Greece.png'],
    ['assets/images/Guatemala.png', 'assets/images/Haiti.png'],
    ['assets/images/HongKong.png', 'assets/images/Hungary.png'],
    ['assets/images/Iceland.png', 'assets/images/India.png'],
    ['assets/images/Indonesia.png', 'assets/images/Ireland.png'],
    ['assets/images/Israel.png', 'assets/images/Italy.png'],
    ['assets/images/Japan.png', 'assets/images/Latvia.png'],
    ['assets/images/Lebanon.png', 'assets/images/Libya.png'],
    ['assets/images/Lithuania.png', 'assets/images/Malaysia.png'],
    ['assets/images/Mexico.png', 'assets/images/Moldova.png'],
    ['assets/images/Mongolia.png', 'assets/images/Morocco.png'],
    ['assets/images/Nepal.png', 'assets/images/Netherlands.png'],
    ['assets/images/NewZealand.png', 'assets/images/Nigeria.png'],
    ['assets/images/Northern Ireland.png', 'assets/images/NorthMacedonia.png'],
    ['assets/images/Norway.png', 'assets/images/Pakistan.png'],
    ['assets/images/Peru.png', 'assets/images/Philippines.png'],
    ['assets/images/Poland.png', 'assets/images/Portugal.png'],
    ['assets/images/Romania.png', 'assets/images/Russia.png'],
    ['assets/images/Scotland.png', 'assets/images/Serbia.png'],
    ['assets/images/Singapore.png', 'assets/images/Slovakia.png'],
    ['assets/images/Slovenia.png', 'assets/images/South Africa.png'],
    ['assets/images/SouthKorea.png', 'assets/images/Spain.png'],
    ['assets/images/Sweden.png', 'assets/images/Switzerland.png'],
    ['assets/images/Taiwan.png', 'assets/images/Thailand.png'],
    ['assets/images/Tunisia.png', 'assets/images/Turkey.png'],
    ['assets/images/Uganda.png', 'assets/images/United Kingdom.png'],
    ['assets/images/Ukraine.png', 'assets/images/Uzbekistan.png'],
    ['assets/images/Vancouver.png', 'assets/images/Venezuela.png'],
    ['assets/images/Vietnam.png', 'assets/images/Wales.png'],
    ['assets/images/Yugoslavia.png', 'assets/images/Zambia.png']
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CountryBloc([], QueryParamsProvider())..add(LoadCountryEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: _countrys.length,
            itemBuilder: (BuildContext context, int index) {
              return CountryRow(
                imageAssets: _imageAssets[index],
                tileSpacing: 0,
                countryNames: _countrys[index],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CountryRow extends StatelessWidget {
  final List<String> imageAssets; // max size is 2 for now
  final List<String> countryNames; // max size is 2 now
  final double tileSpacing;
  CountryRow({this.imageAssets, this.countryNames, this.tileSpacing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CountryBox(
          imageAsset: imageAssets[0],
          countryName: countryNames[0],
        ),
        SizedBox(
          width: tileSpacing,
        ),
        CountryBox(
          imageAsset: imageAssets[1],
          countryName: countryNames[1],
        ),
      ],
    );
  }
}

class CountryBox extends StatelessWidget {
  // for now showing color but it will display an image later
  final String imageAsset;
  final String countryName;

  CountryBox({this.imageAsset, this.countryName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryBloc, List>(
      builder: (context, countrys) {
        if (countrys.contains(countryName)) {
          return SelectedcountryBox(
              imageAsset: imageAsset, countryName: countryName);
        } else {
          return NotSelectedCountryBox(
              imageAsset: imageAsset, countryName: countryName);
        }
      },
    );
  }
}

class NotSelectedCountryBox extends StatelessWidget {
  const NotSelectedCountryBox({
    Key key,
    @required this.imageAsset,
    @required this.countryName,
  }) : super(key: key);

  final String imageAsset;
  final String countryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<CountryBloc>(context)
                  .add(AddCountryEvent(countryInput: this.countryName));
            },
            child: SizedBox(
                width: 175, height: 175, child: Image.asset(imageAsset)),
          ),
          SizedBox(height: 5),
          Text(
            countryName,
            style: BoxCaption(),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}

TextStyle BoxCaption() {
  return TextStyle(
      fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold);
}

class SelectedcountryBox extends StatelessWidget {
  const SelectedcountryBox({
    Key key,
    @required this.imageAsset,
    @required this.countryName,
  }) : super(key: key);

  final String imageAsset;
  final String countryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<CountryBloc>(context)
                  .add(RemoveCountryEvent(countryInput: this.countryName));
            },
            child: Stack(
              children: [
                SizedBox(
                  width: 175,
                  height: 175,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(imageAsset)),
                      border: Border.all(width: 8, color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(85.0)),
                    ),
                  ),
                ),
                Icon(Icons.check_circle),
              ],
            ),
          ),
          SizedBox(height: 5),
          Text(countryName, style: BoxCaption()),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
