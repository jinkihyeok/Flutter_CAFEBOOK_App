import 'package:caffe_app/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgreeListTile extends StatefulWidget {
  final String title;
  final bool isAgree;

  const AgreeListTile({
    super.key,
    required this.title,
    required this.isAgree,
  });

  @override
  State<AgreeListTile> createState() => _AgreeListTileState();
}

class _AgreeListTileState extends State<AgreeListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(
        widget.isAgree
            ? FontAwesomeIcons.solidCircleCheck
            : FontAwesomeIcons.check,
        size: Sizes.size16,
        color: widget.isAgree ? Colors.black : Colors.grey,
      ),
      title: Text(
        widget.title,
        style: const TextStyle(
          fontSize: Sizes.size16,
        ),
      ),
      trailing: const FaIcon(
        FontAwesomeIcons.chevronRight,
        size: Sizes.size16,
        color: Colors.grey,
      ),
    );
  }
}
