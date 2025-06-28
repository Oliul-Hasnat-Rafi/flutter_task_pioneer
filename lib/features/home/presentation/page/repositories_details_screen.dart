import 'package:flutter/material.dart';
import 'package:flutter_task/core/base/widgets/app_spacer.dart';
import 'package:flutter_task/core/base/widgets/card.dart';
import 'package:flutter_task/core/utils/date_time_conversion.dart';
import 'package:flutter_task/core/values/app_values.dart';
import 'package:flutter_task/features/home/data/model/pogo_model/Item_model.dart';
import 'package:go_router/go_router.dart';

class RepositoriesDetailsScreen extends StatelessWidget {
  const RepositoriesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repositoryData = GoRouterState.of(context).extra as Item;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Repository Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: Column(
        children: [
          CustomCard(
            margin: const EdgeInsets.symmetric(
              horizontal: AppValues.margin,
              vertical: AppValues.margin / 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: AppValues.radius * 2,
                      backgroundImage: NetworkImage(
                        repositoryData.owner!.avatarUrl!,
                      ),
                    ),
                    Expanded(
                      child: Text(repositoryData.owner?.login ?? 'No Name'),
                    ),
                  ],
                ),
                AppSpacer(),
                Text(
                  repositoryData.description ?? 'No Description',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                AppSpacer(),
                Text(
                  'Update at: ${repositoryData.updatedAt?.custom_MM_DD_yyyy ?? 'Unknown'}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
