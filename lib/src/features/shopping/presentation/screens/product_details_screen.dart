import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_shimmers.dart';
import '../../../../core/widgets/image_builder.dart';
import '../../domain/entities/product.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../bloc/shopping_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productLink});
  final String productLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<ShoppingBloc, ShoppingState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProductLoadingSuccess) {
            return ViewProductWidget(product: state.product);
          } else {
            return const ViewProductShimmer();
          }
        },
      ),
    );
  }
}

class ViewProductWidget extends StatelessWidget {
  const ViewProductWidget({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    double? numOfStars;
    int? secondPointOfNum;
    bool? isMoreThanHalf;
    if (product.stars != null) {
      numOfStars = double.parse(product.stars!.split(" ").first);
      secondPointOfNum = int.parse(numOfStars.toString().split(".").last);
      isMoreThanHalf = secondPointOfNum > 5 ? true : false;
    }
    return Padding(
      padding: const EdgeInsets.all(AppSize.s10),
      child: ListView(
        children: [
          Hero(
            tag: product.imageUrl,
            child: ImageBuilder(
              imageUrl: product.imageUrl,
              width: context.width,
              height: context.height / 3,
              fit: BoxFit.none,
            ),
          ),
          const SizedBox(height: AppSize.s20),
          Text(
            product.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSize.s10),
          Text(
            product.price,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if (product.capacity != null) ...[
            Text(
              "${AppStrings.capacity} ${product.capacity?.trim()}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSize.s5),
          ],
          if (numOfStars != null)
            Row(
              children: [
                ...List.generate(
                  numOfStars.round(),
                  (index) {
                    if (index == numOfStars!.round() - 1) {
                      return Icon(
                        secondPointOfNum == 1
                            ? Icons.star
                            : isMoreThanHalf!
                                ? Icons.star_half
                                : Icons.star,
                        color: secondPointOfNum != 1 || !isMoreThanHalf!
                            ? Colors.orange
                            : AppColors.blackWith40Opacity,
                      );
                    }
                    return const Icon(
                      Icons.star,
                      color: Colors.orange,
                    );
                  },
                ),
                const SizedBox(width: AppSize.s5),
                Text(
                  product.stars!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          const SizedBox(height: AppSize.s10),
          Text(
            AppStrings.aboutThisProduct,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.black,
                ),
          ),
          const SizedBox(height: AppSize.s10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              product.aboutThis.length,
              (index) => Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.domain_verification_outlined,
                        color: AppColors.grape,
                      ),
                      const SizedBox(width: AppSize.s10),
                      Expanded(
                        child: Text(
                          product.aboutThis[index],
                          style: Theme.of(context).textTheme.bodyMedium,
                          softWrap: true,
                          maxLines: 6,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s10),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSize.s20),
          SizedBox(
            width: context.width,
            height: AppSize.s50,
            child: ElevatedButton(
              onPressed: () async {
                if (!await launchUrl(Uri.parse(product.link))) {
                  throw Exception('Could not launch ${product.link}');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.grape,
                foregroundColor: AppColors.white,
              ),
              child: const Text(
                AppStrings.visitWebsite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ViewProductShimmer extends StatelessWidget {
  const ViewProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LightShimmer(
          width: context.width,
          height: context.height / 3,
        ),
        const SizedBox(height: AppSize.s10),
        LightShimmer(
          width: context.width,
          height: AppSize.s20,
        ),
        const SizedBox(height: AppSize.s10),
        LightShimmer(
          width: context.width / 3,
          height: AppSize.s15,
        ),
      ],
    );
  }
}
