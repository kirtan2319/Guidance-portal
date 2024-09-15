import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class commentPosting extends StatefulWidget {
  final snap;
  commentPosting({Key? key, required this.snap}) : super(key: key);

  @override
  State<commentPosting> createState() => _commentPostingState();
}

class _commentPostingState extends State<commentPosting> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromARGB(186, 91, 90, 90),
        ),
        margin: EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.snap['name'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent)),
                Container(
                  alignment: Alignment.topRight,
                  child: Text('~ ${widget.snap['person']}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.greenAccent)),
                ),
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //           text: widget.snap['name'],
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               color: Colors.white)),
                //       TextSpan(
                //           text: '  ${widget.snap['text']}',
                //           style: TextStyle(color: Colors.white)),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(7),
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '  ${widget.snap['text']}',
                    style: TextStyle(color: Color.fromARGB(255, 187, 185, 185)),
                  ),
                ),
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //           text: widget.snap['name'],
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               color: Colors.white)),
                //       TextSpan(
                //           text: '  ${widget.snap['text']}',
                //           style: TextStyle(color: Colors.white)),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap['datePublished'].toDate()),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 184, 183, 183),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
