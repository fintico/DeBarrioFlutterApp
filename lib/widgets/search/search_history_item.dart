import 'package:debarrioapp/models/customer_search.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/services/customer_service.dart';
import 'package:debarrioapp/utils/user_app_data.dart';
import 'package:debarrioapp/widgets/components/icons/watch.dart';
import 'package:debarrioapp/widgets/search/search_style.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

class SearchHistoryItem extends StatelessWidget {
  final CustomerSearch customerSearch;
  const SearchHistoryItem({Key key, this.customerSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(customerSearch.dish.dishName);
        _createSearch(context);
      },
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 34.0, top: 22.0, bottom: 22.0),
                  child: WatchIcon(
                    height: 20.0,
                    width: 20.0,
                    color: DBColors.GRAY_2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14.0, top: 20.0, bottom: 20.0),
                  child: Text(
                    customerSearch.dish.dishName,
                    style: itemSearchDescription,
                  ),
                ),
              ],
            ),
            Divider(
              color: DBColors.GRAY_12,
              indent: 28.0,
              endIndent: 28.0,
              thickness: 1.0,
            ),
          ],
        ),
      ),
    );
  }

  Future _createSearch(BuildContext context) async {
    try {
      await Provider.of<CustomerService>(context, listen: false)
          .postCustomerSearchCreate(28, customerSearch.dish.id);
    } catch (e) {
      print(e);
    }
  }
}
