import 'package:flutter/material.dart';
import 'package:flutter_bbs/transitions/router_transition.dart';

void customShowPopup(context, title, content, button1, button2, page) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text(button1),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text(button2),
            onPressed: () {
              Navigator.of(context).push(
                RouterTransition(
                  page,
                ),
              );
            },
          ),
        ],
      );
    },
  );
}
