import 'package:base/features/home/ui/blocks/home_product_cubit.dart';
import 'package:base/features/home/ui/widgets/category_item.dart';
import 'package:base/features/home/ui/widgets/custom_search_bar.dart';
import 'package:base/features/home/ui/widgets/custom_text_row.dart';
import 'package:base/features/home/ui/widgets/image_slider.dart';
import 'package:base/features/home/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Dhaka,Bangladesh',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            InkWell(
              child: SvgPicture.asset(
                'lib/features/home/ui/assets/svgs/bell.svg',
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            const CustomSearchBar(),
            const SizedBox(
              height: 16,
            ),
            const CustomTextRow(),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 105,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryItem(),
                  SizedBox(
                    width: 16,
                  ),
                  CategoryItem(),
                  SizedBox(
                    width: 16,
                  ),
                  CategoryItem(),
                  SizedBox(
                    width: 16,
                  ),
                  CategoryItem(),
                  SizedBox(
                    width: 16,
                  ),
                  CategoryItem(),
                  SizedBox(
                    width: 16,
                  ),
                  CategoryItem(),
                  SizedBox(
                    width: 16,
                  ),
                  CategoryItem(),
                  SizedBox(
                    width: 16,
                  ),
                  CategoryItem(),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ImageSlider(),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Hot Deals',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const CircularProgressIndicator();
                } else if (state is ProductLoaded) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemCount:
                        state.products.length, // Ensure this is an integer
                    itemBuilder: (context, int index) {
                      // Explicitly type index as int
                      return ProductCard(product: state.products[index]);
                    },
                  );
                } else if (state is ProductError) {
                  return Text(state.message);
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
