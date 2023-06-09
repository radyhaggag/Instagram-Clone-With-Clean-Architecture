import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_route.dart';
import '../../../../core/functions/build_toast.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/widgets/custom_shimmers.dart';
import '../../../../core/widgets/image_builder.dart';
import '../../domain/entities/shopping_item.dart';

import '../../../../core/utils/app_size.dart';
import '../bloc/shopping_bloc.dart';

class ShoppingScreenBody extends StatelessWidget {
  const ShoppingScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s3),
      child: BlocConsumer<ShoppingBloc, ShoppingState>(
        listener: (context, state) {
          if (state is ShoppingItemsLoadingFailed) {
            buildToast(toastType: ToastType.error, msg: state.message);
          }
        },
        builder: (context, state) {
          if (state is ShoppingItemsLoadingSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ShoppingBloc>().add(GetShoppingItems());
              },
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppSize.s10,
                  crossAxisSpacing: AppSize.s10,
                ),
                itemBuilder: (context, index) {
                  return ViewShoppingItemWidget(
                      shoppingItem: state.items[index]);
                },
                itemCount: state.items.length,
              ),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSize.s10,
                crossAxisSpacing: AppSize.s10,
              ),
              itemBuilder: (context, index) {
                return const ShoppingItemShimmer();
              },
              itemCount: 15,
            );
          }
        },
      ),
    );
  }
}

class ViewShoppingItemWidget extends StatelessWidget {
  const ViewShoppingItemWidget({super.key, required this.shoppingItem});

  final ShoppingItem shoppingItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.viewProductDetails,
          arguments: shoppingItem.link,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: AppSize.s1,
            color: AppColors.light,
          ),
          borderRadius: BorderRadius.circular(AppSize.s5),
        ),
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: shoppingItem.imageUrl,
                child: ImageBuilder(imageUrl: shoppingItem.imageUrl),
              ),
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              shoppingItem.title,
              style: Theme.of(context).textTheme.titleSmall,
              softWrap: true,
              maxLines: 3,
              overflow: TextOverflow.fade,
            ),
          ],
        ),
      ),
    );
  }
}

class ShoppingItemShimmer extends StatelessWidget {
  const ShoppingItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LightShimmer(
          width: double.infinity,
          height: context.height / 5.2,
        ),
        const SizedBox(height: AppSize.s10),
        const LightShimmer(
          width: double.infinity,
          height: AppSize.s15,
        ),
      ],
    );
  }
}
