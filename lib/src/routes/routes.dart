import 'package:flutter/cupertino.dart';

import 'package:pokemon/src/pages/home_page.dart';

final Map<String,Widget Function(BuildContext)> appRoutes ={
  
  'home' : ( _ ) => const HomePage(),
  
    
};