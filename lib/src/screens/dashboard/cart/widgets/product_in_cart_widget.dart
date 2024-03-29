import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_store/src/blocs/cart/cart_bloc.dart';
import 'package:flower_store/src/blocs/cart/cart_event.dart';
import 'package:flower_store/src/blocs/cart/cart_state.dart';
import 'package:flower_store/src/models/cart/cart_product.dart';
import 'package:flower_store/src/models/product.dart';
import 'package:flower_store/src/utils/themes/app_colors.dart';
import 'package:flower_store/src/utils/themes/app_constant.dart';
import 'package:flower_store/src/utils/themes/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductInCartWidget extends StatelessWidget {
  final CartProduct cartProduct;
  const ProductInCartWidget({Key? key, required this.cartProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.w),
            child: CachedNetworkImage(
              fit: BoxFit.fitHeight,
              width: 114.w,
              height: 114.w,
              //imageUrl: product.image,
              imageUrl: cartProduct.image,
              placeholder: (context, url) => SpinKitRing(
                color: AppColors.color1,
              ),
              errorWidget: (context, url, error) => Image(
                image: AssetImage('assets/template_plant.png'),
              ),
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cartProduct.name,
                          style: AppTextStyle.header5.copyWith(
                            color: AppColors.color6,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                          iconSize: 20.h,
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(
                                CartRemoveProduct(
                                    selectedProduct: this.cartProduct));
                          },
                          icon:
                              SvgPicture.asset('assets/ico_delete_style_2.svg'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15.w),
                    child: Text(
                      cartProduct.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.header6.copyWith(
                        color: AppColors.color8,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(25.h)),
                        child: Material(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.color3,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.h)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 5.h,
                                horizontal: 10.w,
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    constraints: BoxConstraints(),
                                    iconSize: 10.w,
                                    onPressed: () {
                                      BlocProvider.of<CartBloc>(context).add(
                                          CartCartPageAmountDecrementPressed(
                                              selectedProduct:
                                                  this.cartProduct));
                                    },
                                    icon: SvgPicture.asset(
                                        'assets/ico_minus.svg'),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  BlocBuilder<CartBloc, CartState>(
                                    builder: (context, state) {
                                      return Text(
                                        cartProduct.quantity.toString(),
                                        style: AppTextStyle.header5.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.color10,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  IconButton(
                                    constraints: BoxConstraints(),
                                    iconSize: 12.w,
                                    onPressed: () {
                                      BlocProvider.of<CartBloc>(context).add(
                                          CartCartPageAmountIncrementPressed(
                                              selectedProduct:
                                                  this.cartProduct));
                                    },
                                    icon: SvgPicture.asset(
                                        'assets/ico_plus_amount.svg'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        "${cartProduct.basePrice.toString()} VND",
                        style: AppTextStyle.header5.copyWith(
                          color: AppColors.color2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
