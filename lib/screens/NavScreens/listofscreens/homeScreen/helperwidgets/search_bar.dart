import 'package:fire_flutter/utils/searchAction/search_delegate.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/helperwidgets/helper_widgets.dart';

class SearchActionsAndFilter extends StatelessWidget {
  const SearchActionsAndFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () =>
                showSearch(context: context, delegate: MySearchDelegate()),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 45.0,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(5.0)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.manage_search_sharp,
                      size: 40.0,
                    ),
                    addHorizontalSpacer(10.0),
                    Text('Search here..')
                  ],
                ),
              ),
            ),
          ),
        ),
        addHorizontalSpacer(10.0),
        ElevatedButton(
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size.square(50.0))),
            onPressed: () {},
            child: Icon(Icons.filter_list)),
      ],
    );
  }
}
