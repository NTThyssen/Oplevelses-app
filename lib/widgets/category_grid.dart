import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/category_manager.dart';
import 'package:flutter_app/helpers/enums.dart';
import 'package:provider/provider.dart';

import 'category_card.dart';

class CategoryGrid extends StatefulWidget {
  final bool selectAll;

  const CategoryGrid({Key key, this.selectAll}) : super(key: key);

  @override
  _CategoryGridState createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      children: List.generate(7, (index) {
        return Selector<CategoryManager, ActivityState>(
          selector: (context, manager) => getActivityStateFromCategory(
              ActivityCategory.values[index], manager),
          builder: (context, value, child) {
            CategoryManager manager =
                Provider.of<CategoryManager>(context, listen: false);
            return CategoryCard(
              image: getActivityCategoryImageFromCategory(
                context,
                ActivityCategory.values[index],
              ),
              text: getActivityCategoryTextFromCategory(
                context,
                ActivityCategory.values[index],
              ),
              onTap: () {
                setCategoryState(
                    context, manager, ActivityCategory.values[index]);
              },
              state: widget.selectAll ? ActivityState.Selected : value,
            );
          },
        );
      }),
    );
  }
}

String getActivityCategoryImageFromCategory(
    BuildContext context, ActivityCategory category) {
  switch (category) {
    case ActivityCategory.Exercise:
      return 'images/bicycle.svg';

    case ActivityCategory.Entertainment:
      return 'images/popcorn.svg';

    case ActivityCategory.Food:
      return 'images/food.svg';

    case ActivityCategory.Nightlife:
      return 'images/speaker.svg';

    case ActivityCategory.Culture:
      return 'images/museum.svg';

    case ActivityCategory.Education:
      return 'images/open-book.svg';

    case ActivityCategory.Free:
      return 'images/thumb-up.svg';

    default:
      return 'images/bicycle.svg';
  }
}

String getActivityCategoryTextFromCategory(
    BuildContext context, ActivityCategory category) {
  switch (category) {
    case ActivityCategory.Exercise:
      return 'Motion';

    case ActivityCategory.Entertainment:
      return 'Underholdning';

    case ActivityCategory.Food:
      return 'Mad og drikke';

    case ActivityCategory.Nightlife:
      return 'Musik og natteliv';

    case ActivityCategory.Culture:
      return 'Kultur';

    case ActivityCategory.Education:
      return 'Bliv klogere';

    case ActivityCategory.Free:
      return 'Gratis';

    default:
      return 'Motion';
  }
}

ActivityState getActivityStateFromCategory(
    ActivityCategory category, CategoryManager manager) {
  switch (category) {
    case ActivityCategory.Exercise:
      return manager.exerciseState;

    case ActivityCategory.Entertainment:
      return manager.entertainmentState;

    case ActivityCategory.Food:
      return manager.foodState;

    case ActivityCategory.Nightlife:
      return manager.nightlifeState;

    case ActivityCategory.Culture:
      return manager.cultureState;

    case ActivityCategory.Education:
      return manager.educationState;

    case ActivityCategory.Free:
      return manager.freeState;

    default:
      return manager.exerciseState;
  }
}

void setCategoryState(
    BuildContext context, CategoryManager manager, ActivityCategory category) {
  switch (category) {
    case ActivityCategory.Exercise:
      manager.exerciseState == ActivityState.NotSelected
          ? manager.setExerciseState(ActivityState.Selected, context)
          : manager.setExerciseState(ActivityState.NotSelected, context);
      break;

    case ActivityCategory.Entertainment:
      manager.entertainmentState == ActivityState.NotSelected
          ? manager.setEntertainmentState(ActivityState.Selected, context)
          : manager.setEntertainmentState(ActivityState.NotSelected, context);
      break;

    case ActivityCategory.Food:
      manager.foodState == ActivityState.NotSelected
          ? manager.setFoodState(ActivityState.Selected, context)
          : manager.setFoodState(ActivityState.NotSelected, context);
      break;

    case ActivityCategory.Nightlife:
      manager.nightlifeState == ActivityState.NotSelected
          ? manager.setNightlifeState(ActivityState.Selected, context)
          : manager.setNightlifeState(ActivityState.NotSelected, context);
      break;

    case ActivityCategory.Culture:
      manager.cultureState == ActivityState.NotSelected
          ? manager.setCultureState(ActivityState.Selected, context)
          : manager.setCultureState(ActivityState.NotSelected, context);
      break;

    case ActivityCategory.Education:
      manager.educationState == ActivityState.NotSelected
          ? manager.setEducationState(ActivityState.Selected, context)
          : manager.setEducationState(ActivityState.NotSelected, context);
      break;

    case ActivityCategory.Free:
      manager.freeState == ActivityState.NotSelected
          ? manager.setFreeState(ActivityState.Selected, context)
          : manager.setFreeState(ActivityState.NotSelected, context);
      break;

    default:
      manager.exerciseState == ActivityState.NotSelected
          ? manager.setExerciseState(ActivityState.Selected, context)
          : manager.setExerciseState(ActivityState.NotSelected, context);
      break;
  }
}
