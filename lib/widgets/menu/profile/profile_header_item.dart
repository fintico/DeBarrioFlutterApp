import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/services/seller_service.dart';
import 'package:debarrioapp/providers/profile_provider.dart';
import 'package:debarrioapp/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/providers/home_provider.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/url_base.dart' as Url;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../utilsFunctions.dart';
import 'profile_style.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key key}) : super(key: key);

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBloc>(context, listen: false);
    return Container(
      width: screenWidth(context),
      height: screenHeight(context, dividedBy: 4.0),
      color: DBColors.BLUE_LIGHT_5,
      child: cZeroStr(homeBloc.sellerAddress.seller.urlImage)
          ? Container(
              padding: const EdgeInsets.all(28.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 100.0,
                /* backgroundImage:
                    NetworkImage(homeBloc.sellerAddress.seller.urlImage), */
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image(
                    image: NetworkImage(homeBloc.sellerAddress.seller.urlImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /* child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image(
                  image: NetworkImage(homeBloc.sellerAddress.seller.urlImage),
                  //width: 100,
                  //height: 100,
                  fit: BoxFit.cover,
                ),
              ), */
            )
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 52.0),
                  child: SvgPicture.asset(
                    'assets/images/empty.svg',
                    height: 72.0,
                    width: 88.0,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: InkWell(
                    onTap: () => pickProfileImage(context),
                    child: Text(
                      'AGREGAR FOTO',
                      style: addPhotoStyle,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future pickProfileImage(BuildContext context) async {
    final homeBloc = Provider.of<HomeBloc>(context, listen: false);
    final picker = ImagePicker();
    final prefs = new UserPreferences();
    File imageFile;
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);

      Response<dynamic> res =
          await Provider.of<SellerService>(context, listen: false)
              .updateImage(prefs.userId, 'urlImage', pickedFile.path);

      print(res.bodyString);

      Map<String, dynamic> jsonMap = json.decode(res.bodyString);

      setState(() {
        homeBloc.sellerAddress.seller.urlImage =
            '${Url.API_BASE_URL + jsonMap["urlImage"]}';
      });

      print(homeBloc.sellerAddress.seller.urlImage);
      //print(uploadImage(imageFile));
      //inspect(await uploadImage(imageFile));
    } else {
      print('nope');
    }
  }
}
