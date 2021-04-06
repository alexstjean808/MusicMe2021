/*
   * updates user query ranges for a given mood
   * <p>
   * Method takes the given mood and determines which mood querry range
   * needs to be updated, then it passes the required song attributes
   * to the mood-specific helper method
   * 
   * @param energyVal   song energy value from Spotify TrackID
   * @param danceabilityVal   song danceability value from Spotify TrackID
   * @param acousticVal   song acousticness value from Spotify TrackID
   * @param mood   mood determined from last user input
   * @param userID user identifier for their specific mood querry ranges
   * 
   * @return       list of [new_joyRanges,new_sadRanges,new_madRanges]
 */
//sample curl request for "I'll never smile again": https://musicme-fd43b-default-rtdb.firebaseio.com/finalTracks.json?orderBy=%22id%22&equalTo=%226q9IP7wbfpocUiOEGvQqCZ%22&limitToFirst=10&print=pretty
Map updateQueryRanges(num energyVal, num danceabilityVal, num acousticVal,
    String mood, String userID) {
  //default values for querry ranges
  //To-do: these all should probably just be defined globally or from
  //an imported class

  //trackQueryParams class

  //joy

  num energyValMaxJ = 1.0;
  num energyValMinJ = 0.6;

  num danceabilityValMaxJ = 1.0;
  num danceabilityValMinJ = 0.5;

  //sadness

  num energyValMaxS = 0.48;
  num energyValMinS = 0.0;

  num danceabilityValMaxS = 0.4;
  num danceabilityValMinS = 0.0;

  //anger

  num energyValMaxA = 1.0;
  num energyValMinA = 0.6;

  num acousticValMaxA = 0.6;
  num acousticValMinA = 0.05;

  List joyList = [
    energyValMinJ,
    energyValMaxJ,
    danceabilityValMinJ,
    danceabilityValMaxJ
  ];
  List sadList = [
    energyValMinS,
    energyValMaxS,
    danceabilityValMinS,
    danceabilityValMaxS
  ];
  List angerList = [
    energyValMinA,
    energyValMaxA,
    acousticValMinA,
    acousticValMaxA
  ];

  switch (mood) {
    case "joy":
      {
        joyList = updateJoyParams(energyVal, danceabilityVal);
      }
      break;

    case "sadness":
      {
        sadList = updateSadParams(energyVal, danceabilityVal);
      }
      break;

    case "anger":
      {
        angerList = updateMadParams(energyVal, acousticVal);
      }
      break;

    default:
      {
        print("invalid mood");
      }
      break;
  }
  // ANGER list of [new_energyValMax,new_energyValMin,new_acousticValMax,new_acousticValMax,]
  // JOY list of [new_energyValMax,new_energyValMin,new_danceabilityValMax,new_danceabilityValMax,]
  // SAD list of [new_energyValMax,new_energyValMin,new_danceabilityValMax,new_danceabilityValMax,]
  //
  Map newParams = {
    "anger_params": {
      "acousticness": [angerList[2], angerList[3]],
      "danceability": [0],
      "energy": [angerList[0], angerList[1]],
      "major": 1
    },
    "joy_params": {
      "acousticness": [0],
      "danceability": [joyList[2], joyList[3]],
      "energy": [joyList[0], joyList[1]],
      "major": 1
    },
    "sadness_params": {
      "acousticness": [0],
      "danceability": [sadList[2], sadList[3]],
      "energy": [sadList[0], sadList[1]],
      "major": 1
    }
  };

  return newParams;
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
   * @param energyVal song energy value from Spotify TrackID
   * @param danceabilityVal song danceability value from Spotify TrackID
   * 
   * @return     list of [new_energyValMax,new_energyValMin,new_danceabilityValMax,new_danceabilityValMax,]
   */

List updateJoyParams(num energyVal, num danceabilityVal) {
  // To-do: fetch values from database here

  num energyValMax = 1.0;
  num energyValMin = 0.6;

  num danceabilityValMax = 1.0;
  num danceabilityValMin = 0.5;

  /*
  
  energyValPercent
  danceabilityValPercent
  acousticValPercent: variables for finding relative position of trackID
  attribute within the currently set querry range
  
  ex: if the current range is [0,1], and the trackID value for that
  attribute is 0.5, the valPercent will be 0.5
  (50% between the max and min values)
  
  */

  num valInc = 0.1;

  List eRange =
      updateEnergyRange(energyVal, energyValMax, energyValMin, valInc);
  List dRange = updateDanceRange(
      danceabilityVal, danceabilityValMax, danceabilityValMin, valInc);

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
   * @param energyVal song energy value from Spotify TrackID
   * @param danceabilityVal song danceability value from Spotify TrackID
   * 
   * @return     list of [new_energyValMax,new_energyValMin,new_danceabilityValMax,new_danceabilityValMax,]
   */

List updateSadParams(num energyVal, num danceabilityVal) {
  // To-do: fetch user querry ranges from database here

  num energyValMax = 0.48;
  num energyValMin = 0.0;

  num danceabilityValMax = 0.4;
  num danceabilityValMin = 0.0;

  /*
  
  energyValPercent
  danceabilityValPercent
  acousticValPercent: variables for finding relative position of trackID
  attribute within the currently set querry range
  
  ex: if the current range is [0,1], and the trackID value for that
  attribute is 0.5, the valPercent will be 0.5
  (50% between the max and min values)
  
  */

  num valInc = 0.1;

  List eRange =
      updateEnergyRange(energyVal, energyValMax, energyValMin, valInc);
  List dRange = updateDanceRange(
      danceabilityVal, danceabilityValMax, danceabilityValMin, valInc);

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
   * @param energyVal song energy value from Spotify TrackID
   * @param acousticVal song acousticness value from Spotify TrackID
   * 
   * @return     list of [new_energyValMax,new_energyValMin,new_acousticValMax,new_acousticValMax,]
   */

List updateMadParams(num energyVal, num acousticVal) {
  // To-do: fetch user querry ranges from database here

  num energyValMax = 1.0;
  num energyValMin = 0.6;

  num acousticValMax = 0.6;
  num acousticValMin = 0.05;

  /*
  
  energyValPercent
  danceabilityValPercent
  acousticValPercent: variables for finding relative position of trackID
  attribute within the currently set querry range
  
  ex: if the current range is [0,1], and the trackID value for that
  attribute is 0.5, the valPercent will be 0.5
  (50% between the max and min values)
  
  */

  num valInc = 0.1;

  List eRange =
      updateEnergyRange(energyVal, energyValMax, energyValMin, valInc);
  List aRange =
      updateAcousticRange(acousticVal, acousticValMax, acousticValMin, valInc);

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
   * @param energyVal    song energy value from Spotify TrackID
   * @param energyValMax current max query value for energy
   * @param energyValMin current min query value for energy
   * @param valInc  percentage change to increment ranges by
   * 
   * @return        list of [new_energyValMax,new_energyValMin]
   */

List updateEnergyRange(
    num energyVal, num energyValMax, num energyValMin, num valInc) {
  num energyValPercent =
      (energyVal - energyValMin) / (energyValMax - energyValMin);

  if (energyValPercent >= 0.66 && (energyValMax - valInc) > energyValMin) {
    energyValMax -= valInc;
  } else if (energyValPercent <= 0.33 &&
      (energyValMin + valInc) < energyValMax) {
    energyValMin += valInc;
  } else if (energyValPercent < 0.66 && energyValPercent > 0.33) {
    energyValMax += valInc;
    energyValMin -= valInc;
  }
  if (energyValMax > 1) {
    energyValMax = 1;
  }
  if (energyValMin < 0) {
    energyValMin = 0;
  }

  return [energyValMin, energyValMax];
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
   * @param danceabilityVal    song dancability value from Spotify TrackID
   * @param danceabilityValMax current max query value for dancability
   * @param danceabilityValMin current min query value for dancability
   * @param valInc  percentage change to increment ranges by
   * 
   * @return        list of [new_danceabilityValMax,new_danceabilityValMin]
   */

List updateDanceRange(num danceabilityVal, num danceabilityValMax,
    num danceabilityValMin, num valInc) {
  num danceabilityValPercent = (danceabilityVal - danceabilityValMin) /
      (danceabilityValMax - danceabilityValMin);

  if (danceabilityValPercent >= 0.66 &&
      (danceabilityValMax - valInc) > danceabilityValMin) {
    danceabilityValMax -= valInc;
  } else if (danceabilityValPercent <= 0.33 &&
      (danceabilityValMin + valInc) < danceabilityValMax) {
    danceabilityValMin += valInc;
  } else if (danceabilityValPercent < 0.66 && danceabilityValPercent > 0.33) {
    danceabilityValMax += valInc;
    danceabilityValMin -= valInc;
  }
  if (danceabilityValMax > 1) {
    danceabilityValMax = 1;
  }
  if (danceabilityValMin < 0) {
    danceabilityValMin = 0;
  }

  return [danceabilityValMin, danceabilityValMax];
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
   * @param danceabilityVal    song acousticness value from Spotify TrackID
   * @param danceabilityValMax current max query value for acousticness
   * @param danceabilityValMin current min query value for acousticness
   * @param valInc  percentage change to increment ranges by
   * 
   * @return        list of [new_acousticValMax,new_acousticValMin]
   */

List updateAcousticRange(
    num acousticVal, num acousticValMax, num acousticValMin, num valInc) {
  num acousticValPercent =
      (acousticVal - acousticValMin) / (acousticValMax - acousticValMin);

  if (acousticValPercent >= 0.66 &&
      (acousticValMax - valInc) > acousticValMin) {
    acousticValMax -= valInc;
  } else if (acousticValPercent <= 0.33 &&
      (acousticValMin + valInc) < acousticValMax) {
    acousticValMin += valInc;
  } else if (acousticValPercent < 0.66 && acousticValPercent > 0.33) {
    acousticValMax += valInc;
    acousticValMin -= valInc;
  }
  if (acousticValMax > 1) {
    acousticValMax = 1;
  }
  if (acousticValMin < 0) {
    acousticValMin = 0;
  }

  return [acousticValMin, acousticValMax];
}
