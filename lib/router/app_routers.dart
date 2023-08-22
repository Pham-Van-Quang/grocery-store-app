import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_store_app/network/remote/models/product_data.dart';
import 'package:grocery_store_app/views/cart/cart.dart';
import 'package:grocery_store_app/views/cart/view_models/cart_cubit.dart';

import 'package:grocery_store_app/views/forgotten_password/forgotten_password.dart';
import 'package:grocery_store_app/views/forgotten_password/view_models/forgotten_password_cubit.dart';
import 'package:grocery_store_app/views/home.dart';
import 'package:grocery_store_app/views/map_screen/map_screen.dart';
import 'package:grocery_store_app/views/map_screen/view_models/map_screen_cubit.dart';
import 'package:grocery_store_app/views/onboarding/onboarding.dart';
import 'package:grocery_store_app/views/personal_infor/personal_infor.dart';
import 'package:grocery_store_app/views/personal_infor/view_models/personal_infor_cubit.dart';
import 'package:grocery_store_app/views/product_infor/product_infor.dart';
import 'package:grocery_store_app/views/sign_in/sign_in.dart';
import 'package:grocery_store_app/views/sign_in/view_models/sign_in_cubit.dart';
import 'package:grocery_store_app/views/sign_up/sign_up.dart';
import 'package:grocery_store_app/views/sign_up/view_models/sign_up_cubit.dart';
import 'package:grocery_store_app/views/splash_screen/splash_screen.dart';
import 'package:grocery_store_app/views/splash_screen/view_model/splash_screen_cubit.dart';
import 'package:grocery_store_app/views/start_screen/start_screen.dart';
import 'package:grocery_store_app/views/successful_order/successful_order.dart';
import 'package:grocery_store_app/views/tracking_order/tracking_order.dart';
import 'package:grocery_store_app/views/widget_tree.dart';

class AppRouter {
  static Route<dynamic>? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterName.splashscreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SplashScreenCubit(),
            child: const SplashScreen(
              title: '',
            ),
          ),
          settings: settings,
        );
      case AppRouterName.onboarding:
        return MaterialPageRoute(
          builder: (context) => const Onboarding(),
          settings: settings,
        );
      case AppRouterName.widgettree:
        return MaterialPageRoute(
          builder: (context) => const WidgetTree(),
          settings: settings,
        );
      case AppRouterName.signin:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignInCubit(),
            child: const SignIn(
              title: '',
            ),
          ),
          settings: settings,
        );
      case AppRouterName.homepage:
        return MaterialPageRoute(
          builder: (context) => const Home(
            currentAddress: '',
          ),
          settings: settings,
        );
      case AppRouterName.signup:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignUpCubit(),
            child: const SignUp(),
          ),
          settings: settings,
        );
      case AppRouterName.forgottenpassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ForgottenPasswordCubit(FirebaseAuth.instance),
            child: const ForgottenPassword(),
          ),
          settings: settings,
        );
      case AppRouterName.startscreen:
        return MaterialPageRoute(
          builder: (context) => const StartScreen(),
          settings: settings,
        );
      case AppRouterName.productinfor:
        return MaterialPageRoute(
          builder: (context) => ProductInfor(
            productData: settings.arguments as ProductData,
          ),
          settings: settings,
        );
      case AppRouterName.cart:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CartCubit(),
            child: Cart(
              productData: settings.arguments as ProductData,
              currentAddress: '',
            ),
          ),
          settings: settings,
        );
      case AppRouterName.mapscreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => MapCubit(),
            child: const MapScreen(),
          ),
          settings: settings,
        );
      case AppRouterName.successfulorder:
        return MaterialPageRoute(
          builder: (context) => const SuccussfulOrder(),
          settings: settings,
        );
      case AppRouterName.trackingorder:
        return MaterialPageRoute(
          builder: (context) => const TrackingOrder(),
          settings: settings,
        );
      case AppRouterName.personalinfor:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => PersonalInforCubit(),
            child: const PersonalInfor(),
          ),
          settings: settings,
        );
    }
    return null;
  }
}

class AppRouterName {
  static const splashscreen = "/splashscreen";
  static const onboarding = "/onboarding";
  static const widgettree = "/widgettree";
  static const signin = "/signin";
  static const signup = "/signup";
  static const homepage = "/homepage";
  static const forgottenpassword = "/forgottenpassword";
  static const startscreen = "/start_screen";
  static const productinfor = "/productinfor";
  static const cart = "/cart";
  static const successfulorder = "/successfulorder";
  static const trackingorder = "/trackingorder";
  static const mapscreen = "/mapscreen";
  static const personalinfor = "/personal_infor";
}
