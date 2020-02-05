import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Mayda/src/controllers/search_controller.dart';
import 'package:Mayda/src/elements/CardWidget.dart';
import 'package:Mayda/src/elements/CircularLoadingWidget.dart';
import 'package:Mayda/src/models/route_argument.dart';

class SearchResultWidget extends StatefulWidget {
  String heroTag;

  SearchResultWidget({Key key, this.heroTag}) : super(key: key);

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends StateMVC<SearchResultWidget> {
  SearchController _con;

  _SearchResultWidgetState() : super(SearchController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              trailing: IconButton(
                icon: Icon(Icons.close),
                color: Theme.of(context).hintColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Search',
                style: Theme.of(context).textTheme.display1,
              ),
              subtitle: Text(
                'Ordered by Nearby first',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              onChanged: (text) {
                _con.refreshSearch(text);
              },
              onSubmitted: (text) {
                _con.saveSearch(text);
              },
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                hintText: 'Search for restaurants or foods',
                hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
                border:
                    OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              title: Text(
                'Recents Search',
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
          ),
          _con.restaurants.isEmpty
              ? CircularLoadingWidget(height: 288)
              : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: _con.restaurants.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/Details',
                              arguments: RouteArgument(
                                id: _con.restaurants.elementAt(index).id,
                                heroTag: widget.heroTag,
                              ));
                        },
                        child: CardWidget(restaurant: _con.restaurants.elementAt(index), heroTag: widget.heroTag),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
