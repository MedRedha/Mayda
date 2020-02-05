import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:Mayda/generated/i18n.dart';
import 'package:Mayda/src/controllers/home_controller.dart';
import 'package:Mayda/src/elements/CardsCarouselWidget.dart';
import 'package:Mayda/src/elements/CaregoriesCarouselWidget.dart';
import 'package:Mayda/src/elements/FoodsCarouselWidget.dart';
import 'package:Mayda/src/elements/GridWidget.dart';
import 'package:Mayda/src/elements/ReviewsListWidget.dart';
import 'package:Mayda/src/elements/SearchBarWidget.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget> {
  HomeController _con;
  _HomeWidgetState() : super(HomeController()) {
    _con = controller;
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _con.refreshHome,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBarWidget(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  Icons.stars,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  S.of(context).top_restaurants,
                  style: Theme.of(context).textTheme.display1,
                ),
                subtitle: Text(
                  S.of(context).ordered_by_nearby_first,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
            CardsCarouselWidget(restaurantsList: _con.topRestaurants, heroTag: 'home_top_restaurants'),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              leading: Icon(
                Icons.trending_up,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                S.of(context).trending_this_week,
                style: Theme.of(context).textTheme.display1,
              ),
              subtitle: Text(
                S.of(context).double_click_on_the_food_to_add_it_to_the,
                style: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 11)),
              ),
            ),
            FoodsCarouselWidget(foodsList: _con.trendingFoods, heroTag: 'home_food_carousel'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  Icons.category,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  S.of(context).food_categories,
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            CategoriesCarouselWidget(
              categories: _con.categories,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  Icons.trending_up,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  S.of(context).most_popular,
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridWidget(
                restaurantsList: _con.topRestaurants,
                heroTag: 'home_restaurants',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 20),
                leading: Icon(
                  Icons.recent_actors,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  S.of(context).recent_reviews,
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ReviewsListWidget(reviewsList: _con.recentReviews),
            ),
          ],
        ),
      ),
    );
  }
}
