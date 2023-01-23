

import 'package:shop_app/models/change_favourites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates{}

class ShopInitialStates extends ShopStates{}

class ShopBottomNavBarStates extends ShopStates{}

class ShopLoadingHomeDataStates extends ShopStates{}
class ShopSuccessHomeDataStates extends ShopStates{}
class ShopErrorHomeDataStates extends ShopStates{
  final error;
  ShopErrorHomeDataStates(this.error);
}

class ShopSuccessCategoriesStates extends ShopStates{}
class ShopErrorCategoriesStates extends ShopStates{
  final error;
  ShopErrorCategoriesStates(this.error);
}

class ShopSuccessChangeFavouritesStates extends ShopStates{
   final ChangeFavouritesModel model;
  ShopSuccessChangeFavouritesStates(this.model);
}
class ShopChangeFavouritesStates extends ShopStates{}
class ShopErrorChangeFavouritesStates extends ShopStates{
  final error;
  ShopErrorChangeFavouritesStates(this.error);
}

class ShopLoadingGetFavouritesStates extends ShopStates{}
class ShopSuccessGetFavouritesStates extends ShopStates{}
class ShopErrorGetFavouritesStates extends ShopStates{
  final error;
  ShopErrorGetFavouritesStates(this.error);
}

class ShopLoadingUserDataStates extends ShopStates{}
class ShopSuccessUserDataStates extends ShopStates{
 final ShopLoginModel? loginModel;

  ShopSuccessUserDataStates(this.loginModel);

}
class ShopErrorUserDataStates extends ShopStates{
  final error;
  ShopErrorUserDataStates(this.error);
}

class ShopLoadingUpdateUserStates extends ShopStates{}
class ShopSuccessUpdateUserStates extends ShopStates{
  final ShopLoginModel? loginModel;
  ShopSuccessUpdateUserStates(this.loginModel);
}
class ShopErrorUpdateUserStates extends ShopStates{
  final error;
  ShopErrorUpdateUserStates(this.error);
}

