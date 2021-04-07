import 'package:flutter/material.dart';

final snackBar = SnackBar(
  content: Text('Yay! A SnackBar!'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),
);

          
    
// Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          //ScaffoldMessenger.of(context).showSnackBar(snackBar);