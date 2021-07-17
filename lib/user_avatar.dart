import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';

class UserAvatar extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String imageUrl;
  final double size;

  const UserAvatar({required this.firstName, required this.lastName, this.size = Dimens.USER_AVATAR, this.imageUrl = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColors.of(context).primary, width: 1),
        color: ThemeColors.of(context).primaryLight,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: ThemeColors.of(context).primary, width: 1),
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => _placeholder(context),
        errorWidget: (context, url, error) => _placeholder(context),
      ),
    );
  }

  Widget _placeholder(BuildContext context) => SizedBox(
        width: size * .55,
        child: FittedBox(
          child: Text(
            '${firstName[0]}${lastName[0]}'.toUpperCase(),
            style: Theme.of(context).textTheme.userAvatar?.apply(color: ThemeColors.of(context).textColorLighter),
          ),
        ),
      );
}
