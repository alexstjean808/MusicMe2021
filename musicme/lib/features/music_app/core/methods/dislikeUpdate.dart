void main() {
  // To-do: fetch user song attributes from trackID here
  // To-do: make method user-specific, incorporate userID

  num eVal = 0.9;
  num dVal = 0.3;
  num aVal = 0.3;
  String mood = "anger";
  String userID = "musicme";

  bool dislike = true; //has a dislike event occured for given trackID?

  //

  var userMoodList = [];

  if (dislike) {
    userMoodList = updateQueryRanges(eVal, dVal, aVal, mood, userID);
    print(userMoodList);
  } 
}


/*
   * updates user querry ranges for a given mood
   * <p>
   * Method takes the given mood and determines which mood querry range
   * needs to be updated, then it passes the required song attributes
   * to the mood-specific helper method
   * 
   * @param eVal   song energy value from Spotify TrackID
   * @param dVal   song danceability value from Spotify TrackID
   * @param aVal   song acousticness value from Spotify TrackID
   * @param mood   mood determined from last user input
   * @param userID user identifier for their specific mood querry ranges
   * 
   * @return       list of [new_joyRanges,new_sadRanges,new_madRanges]
 */

List updateQueryRanges(
    num eVal, num dVal, num aVal, String mood, String userID) {
  //default values for querry ranges
  //To-do: these all should probably just be defined globally or from
  //an imported class

  //trackQueryParams class

  //joy

  num eValMaxJ = 1.0;
  num eValMinJ = 0.6;

  num dValMaxJ = 1.0;
  num dValMinJ = 0.5;

  //sadness

  num eValMaxS = 0.48;
  num eValMinS = 0.0;

  num dValMaxS = 0.4;
  num dValMinS = 0.0;

  //anger

  num eValMaxA = 1.0;
  num eValMinA = 0.6;

  num aValMaxA = 0.6;
  num aValMinA = 0.05;

  List joyList = [eValMinJ, eValMaxJ, dValMinJ, dValMaxJ];
  List sadList = [eValMinS, eValMaxS, dValMinS, dValMaxS];
  List angerList = [eValMinA, eValMaxA, aValMinA, aValMaxA];

  switch (mood) {
    case "joy":
      {
        joyList = updateJoyParams(eVal, dVal);
      }
      break;

    case "sadness":
      {
        sadList = updateSadParams(eVal, dVal);
      }
      break;

    case "anger":
      {
        angerList = updateMadParams(eVal, aVal);
      }
      break;

    default:
      {
        print("invalid mood");
      }
      break;
  }

  return [joyList, sadList, angerList];
}

//////////////////////////////////////////////

/*
   * updates user querry ranges for Joy
   * <p>
   * Method takes the given song attributes relevant to the Joy mood
   * (energy and danceability) and calls appropriate helper methods to
   * update values based on relative position of the given value in the
   * current range
   * 
   * @param eVal song energy value from Spotify TrackID
   * @param dVal song danceability value from Spotify TrackID
   * 
   * @return     list of [new_eValMax,new_eValMin,new_dValMax,new_dValMax,]
   */

List updateJoyParams(num eVal, num dVal) {
  // To-do: fetch values from database here

  num eValMax = 1.0;
  num eValMin = 0.6;

  num dValMax = 1.0;
  num dValMin = 0.5;

  /*
  
  eValPercent
  dValPercent
  aValPercent: variables for finding relative position of trackID
  attribute within the currently set querry range
  
  ex: if the current range is [0,1], and the trackID value for that
  attribute is 0.5, the valPercent will be 0.5
  (50% between the max and min values)
  
  */

  num valInc = 0.1;

  List eRange = updateEnergyRange(eVal, eValMax, eValMin, valInc);
  List dRange = updateDanceRange(dVal, dValMax, dValMin, valInc);

  return (eRange + dRange);
}

/*
   * updates user querry ranges for Sadness
   * <p>
   * Method takes the given song attributes relevant to the Sadness mood
   * (energy and danceability) and calls appropriate helper methods to
   * update values based on relative position of the given value in the
   * current range
   * 
   * @param eVal song energy value from Spotify TrackID
   * @param dVal song danceability value from Spotify TrackID
   * 
   * @return     list of [new_eValMax,new_eValMin,new_dValMax,new_dValMax,]
   */

List updateSadParams(num eVal, num dVal) {
  // To-do: fetch user querry ranges from database here

  num eValMax = 0.48;
  num eValMin = 0.0;

  num dValMax = 0.4;
  num dValMin = 0.0;

  /*
  
  eValPercent
  dValPercent
  aValPercent: variables for finding relative position of trackID
  attribute within the currently set querry range
  
  ex: if the current range is [0,1], and the trackID value for that
  attribute is 0.5, the valPercent will be 0.5
  (50% between the max and min values)
  
  */

  num valInc = 0.1;

  List eRange = updateEnergyRange(eVal, eValMax, eValMin, valInc);
  List dRange = updateDanceRange(dVal, dValMax, dValMin, valInc);

  return (eRange + dRange);
}

/*
   * updates user querry ranges for Anger
   * <p>
   * Method takes the given song attributes relevant to the Anger mood
   * (energy and acousticness) and calls appropriate helper methods to
   * update values based on relative position of the given value in the
   * current range
   * 
   * @param eVal song energy value from Spotify TrackID
   * @param aVal song acousticness value from Spotify TrackID
   * 
   * @return     list of [new_eValMax,new_eValMin,new_aValMax,new_aValMax,]
   */

List updateMadParams(num eVal, num aVal) {
  // To-do: fetch user querry ranges from database here

  num eValMax = 1.0;
  num eValMin = 0.6;

  num aValMax = 0.6;
  num aValMin = 0.05;

  /*
  
  eValPercent
  dValPercent
  aValPercent: variables for finding relative position of trackID
  attribute within the currently set querry range
  
  ex: if the current range is [0,1], and the trackID value for that
  attribute is 0.5, the valPercent will be 0.5
  (50% between the max and min values)
  
  */

  num valInc = 0.1;

  List eRange = updateEnergyRange(eVal, eValMax, eValMin, valInc);
  List aRange = updateAcousticRange(aVal, aValMax, aValMin, valInc);

  return (eRange + aRange);
}

/*
   * updates user querry ranges for Energy
   * <p>
   * Method takes the given song's energy value from Spotify and 
   * determines where in the current set querry range the given value
   * lies. Dividing the range into thirds,
   * the ranges update by a set incrememnt percentage (valInc) depending
   * on where in the range the dislike occured:
   * 
   * Dislike in top third -> reduce range max by increment
   * Dislike in middle third -> widen range max and min by increment
   * Dislike in bottom third -> reduce range min by increment
   * 
   * Increment value to be set based on testing for what value returns
   * the best results - default is 0.1, or a 10% change for each dislike
   * 
   * @param eVal    song energy value from Spotify TrackID
   * @param eValMax current max query value for energy
   * @param eValMin current min query value for energy
   * @param valInc  percentage change to increment ranges by
   * 
   * @return        list of [new_eValMax,new_eValMin]
   */ 

List updateEnergyRange(num eVal, num eValMax, num eValMin, num valInc) {
  num eValPercent = (eVal - eValMin) / (eValMax - eValMin);

  if (eValPercent >= 0.66 && (eValMax - valInc) > eValMin) {
    eValMax -= valInc;
  } else if (eValPercent <= 0.33 && (eValMin + valInc) < eValMax) {
    eValMin += valInc;
  } else if (eValPercent < 0.66 && eValPercent > 0.33) {
    eValMax += valInc;
    eValMin -= valInc;
  } if (eValMax > 1) {
    eValMax = 1;
  } if (eValMin < 0) {
    eValMin = 0;
  }

  return [eValMin, eValMax];
}

/*
   * updates user querry ranges for Dancability
   * <p>
   * Method takes the given song's dancability value from Spotify and 
   * determines where in the current set querry range the given value
   * lies. Dividing the range into thirds,
   * the ranges update by a set incrememnt percentage (valInc) depending
   * on where in the range the dislike occured:
   * 
   * Dislike in top third -> reduce range max by increment
   * Dislike in middle third -> widen range max and min by increment
   * Dislike in bottom third -> reduce range min by increment
   * 
   * Increment value to be set based on testing for what value returns
   * the best results - default is 0.1, or a 10% change for each dislike
   * 
   * @param dVal    song dancability value from Spotify TrackID
   * @param dValMax current max query value for dancability
   * @param dValMin current min query value for dancability
   * @param valInc  percentage change to increment ranges by
   * 
   * @return        list of [new_dValMax,new_dValMin]
   */

List updateDanceRange(num dVal, num dValMax, num dValMin, num valInc) {
  num dValPercent = (dVal - dValMin) / (dValMax - dValMin);

  if (dValPercent >= 0.66 && (dValMax - valInc) > dValMin) {
    dValMax -= valInc;
  } else if (dValPercent <= 0.33 && (dValMin + valInc) < dValMax) {
    dValMin += valInc;
  } else if (dValPercent < 0.66 && dValPercent > 0.33) {
    dValMax += valInc;
    dValMin -= valInc;
  } if (dValMax > 1) {
    dValMax = 1;
  } if (dValMin < 0) {
    dValMin = 0;
  }

  return [dValMin, dValMax];
}

/*
   * updates user querry ranges for Acousticness
   * <p>
   * Method takes the given song's acousticness value from Spotify and 
   * determines where in the current set querry range the given value
   * lies. Dividing the range into thirds,
   * the ranges update by a set incrememnt percentage (valInc) depending
   * on where in the range the dislike occured:
   * 
   * Dislike in top third -> reduce range max by increment
   * Dislike in middle third -> widen range max and min by increment
   * Dislike in bottom third -> reduce range min by increment
   * 
   * Increment value to be set based on testing for what value returns
   * the best results - default is 0.1, or a 10% change for each dislike
   * 
   * @param dVal    song acousticness value from Spotify TrackID
   * @param dValMax current max query value for acousticness
   * @param dValMin current min query value for acousticness
   * @param valInc  percentage change to increment ranges by
   * 
   * @return        list of [new_aValMax,new_aValMin]
   */

List updateAcousticRange(num aVal, num aValMax, num aValMin, num valInc) {
  num aValPercent = (aVal - aValMin) / (aValMax - aValMin);

  if (aValPercent >= 0.66 && (aValMax - valInc) > aValMin) {
    aValMax -= valInc;
  } else if (aValPercent <= 0.33 && (aValMin + valInc) < aValMax) {
    aValMin += valInc;
  } else if (aValPercent < 0.66 && aValPercent > 0.33) {
    aValMax += valInc;
    aValMin -= valInc;
  } if (aValMax > 1) {
    aValMax = 1;
  } if (aValMin < 0) {
    aValMin = 0;
  }

  return [aValMin, aValMax];
}

