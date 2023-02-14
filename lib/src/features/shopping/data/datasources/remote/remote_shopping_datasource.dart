import '../../../../../core/utils/app_boxes.dart';
import '../../../domain/entities/shopping_item.dart';

import '../../../domain/entities/product.dart';

import 'base_remote_shopping_datasource.dart';

import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

const baseUrl =
    "https://www.amazon.com/s?bbn=16225007011&rh=n%3A16225007011%2Cn%3A172456&dc&qid=1675633297&rnid=16225007011&ref=lp_16225007011_nr_n_0";
const baseDomain = "https://www.amazon.com/";

class RemoteShoppingDatasource implements BaseRemoteShoppingDatasource {
  @override
  Future<Product> getProduct(String productLink) async {
    try {
      final res = await http.get(Uri.parse(productLink));
      if (res.statusCode == 200) {
        final html = parser.parse(res.body);
        final title = html.getElementById('productTitle')?.text;
        final stars = html
            .querySelector(
              '#acrPopover > span.a-declarative > a > i > span',
            )
            ?.text;
        final price = html
            .querySelector(
              '#corePriceDisplay_desktop_feature_div > div.a-section.a-spacing-none.aok-align-center > span > span.a-offscreen',
            )
            ?.text;
        final capacity = html
            .querySelector(
              '#variation_size_name > div > span',
            )
            ?.text;
        final imageUrl = html.getElementById('landingImage')?.attributes['src'];

        List<String> aboutThis = html
            .querySelectorAll('#feature-bullets > ul > li > span')
            .map((e) => e.text)
            .toList();
        aboutThis.removeAt(0); // Fixed message in amazon.

        Product product = Product(
          price: price ?? "",
          capacity: capacity,
          aboutThis: aboutThis,
          stars: stars,
          title: title ?? "",
          imageUrl: imageUrl ?? "",
          link: productLink,
        );
        AppBoxes.productsBox.add(product);
        return product;
      } else {
        throw Exception('Http Error');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ShoppingItem>> getProducts() async {
    try {
      final res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode == 200) {
        List<ShoppingItem> items = [];

        final html = parser.parse(res.body);
        final titles = html.querySelectorAll(
          '.a-section .s-title-instructions-style > h2',
        );
        final links = html.querySelectorAll(
          '.a-section .s-title-instructions-style > h2 > a',
        );

        final images = html.querySelectorAll(
          'div.s-product-image-container > span > a > div > img',
        );

        for (var i = 0; i < titles.length; i++) {
          ShoppingItem shoppingItem = ShoppingItem(
            title: titles[i].text,
            imageUrl: images[i].attributes['src']!,
            link: "$baseDomain${links[i].attributes['href']}",
          );
          items.add(shoppingItem);
        }
        AppBoxes.shoppingItemsBox.clear();
        AppBoxes.shoppingItemsBox.addAll(items);
        return items;
      } else {
        throw Exception('Http Error');
      }
    } catch (_) {
      rethrow;
    }
  }
}
