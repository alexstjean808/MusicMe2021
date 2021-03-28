import '../../../../countryArrays.dart';
import '../local_data/genreArrays.dart';

// ['Pop': , 'Rock'],
//     ['Hip-hop / Rap', 'Electronic'],
//     ['Alternative', 'Indie'],
//     ['Metal', 'Punk'],
//     ['Post-Punk', 'Folk'],
//     ['Country', 'Ambient'],
//     ['Rhythm and Blues', 'Jazz'],
//     ['Classical', 'Spiritual'],
//     ['Traditional Music', 'Wack']

//this Map contains all of the spotify micro genres that Alex defined for each
//macro genre
//all genres after 'Wack' are associated with different countries

Map genresFromArray = {
  'Pop': genrePop,
  'Rock': genreRock,
  'Hip-Hop / Rap': genreHiphop,
  'Electronic': genreElec,
  'Alternative': genreAlt,
  'Indie': genreIndie,
  'Metal': genreMetal,
  'Punk': genrePunk1,
  'Post-Punk': genrePunk2,
  'Folk': genreFolk,
  'Country': genreCountry,
  'Ambient': genreAmb,
  'Rhythm and Blues': genreRhythm,
  'Jazz': genreJazz,
  'Classical': genreClassical,
  'Spiritual': genreSpirit,
  'Traditional Music': genreTrad,
  'Wack': genreWack,
  'Afghanistan': countryAfghanistan,
  'Albania': countryAlbania,
  'America': countryAmerica,
  'Argentina': countryArgentina,
  'Armenia': countryArmenia,
  'Australia': countryAustralia,
  'Austria': countryAustria,
  'Bahamas': countryBahamas,
  'Barbados': countryBarbados,
  'Belarus': countryBelarus,
  'Belgium': countryBelgium,
  'Bosnia': countryBosnia,
  'Brazil': countryBrazil,
  'Bulgaria': countryBulgaria,
  'Cambodia': countryCambodia,
  'Canada': countryCanada,
  'China': countryChina,
  'Chile': countryChile,
  'Colombia': countryColombia,
  'Croatia': countryCroatia,
  'Czech': countryCzech,
  'Denmark': countryDenmark,
  'Ecuador': countryEcuador,
  'Egypt': countryEgypt,
  'England': countryEngland,
  'Estonia': countryEstonia,
  'Ethiopia': countryEthiopia,
  'Finland': countryFinland,
  'France': countryFrance,
  'Gabon': countryGabon,
  'Georgia': countryGeorgia,
  'Germany': countryGermany,
  'Ghana': countryGhana,
  'Greece': countryGreece,
  'Guatemala': countryGuatemala,
  'Haiti': countryHaiti,
  'Hong Kong': countryHongKong,
  'Hungary': countryHungary,
  'Iceland': countryIceland,
  'India': countryIndia,
  'Indonesia': countryIndonesia,
  'Ireland': countryIreland,
  'Israel': countryIsrael,
  'Italy': countryItaly,
  'Japan': countryJapan,
  'Latvia': countryLatvia,
  'Lebanon': countryLebanon,
  'Libya': countryLibya,
  'Lithuania': countryLithuania,
  'Malaysia': countryMalaysia,
  'Mexico': countryMexico,
  'Moldova': countryMoldova,
  'Mongolia': countryMongolia,
  'Morocco': countryMorocco,
  'Nepal': countryNepal,
  'Netherlands': countryNetherlands,
  'New Zealand': countryNewZealand,
  'Nigeria': countryNigeria,
  'N Ireland': countryNIreland,
  'N Macedonia': countryNMacedonia,
  'Norway': countryNorway,
  'Pakistan': countryPakistan,
  'Peru': countryPeru,
  'Philippines': countryPhilippines,
  'Poland': countryPoland,
  'Portugal': countryPortugal,
  'Romania': countryRomania,
  'Russia': countryRussia,
  'Scotland': countryScotland,
  'Serbia': countrySerbia,
  'Singapore': countrySingapore,
  'Slovakia': countrySlovakia,
  'Slovenia': countrySlovenia,
  'S Africa': countrySAfrica,
  'S Korea': countrySKorea,
  'Spain': countrySpain,
  'Sweden': countrySweden,
  'Swiss': countrySwiss,
  'Taiwan': countryTaiwan,
  'Thailand': countryThailand,
  'Tunisia': countryTunisia,
  'Turkey': countryTurkey,
  'Uganda': countryUganda,
  'UK': countryUK,
  'Ukraine': countryUkraine,
  'Uzbekistan': countryUzbekistan,
  'Vancouver': countryVancouver,
  'Venezuela': countryVenezuela,
  'Vietnam': countryVietnam,
  'Wales': countryWales,
  'Yugoslavia': countryYugoslavia,
  'Zambia': countryZambia
};
