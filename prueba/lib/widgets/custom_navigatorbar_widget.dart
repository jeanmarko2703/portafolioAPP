
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../theme/app_theme.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;
   

    return ClipRRect(
      borderRadius: BorderRadius.only (topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: BottomNavigationBar(
        
        onTap: (int i) {
          if (currentIndex != i) {
            uiProvider.selectedMenuOpt = i;
            // Navigator.pushNamed(context, menuOption[i].route);
          }
          return null;
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        elevation: 5,
        selectedItemColor: AppTheme.primary.withOpacity(0.8),
        unselectedItemColor: AppTheme.secondColor,
        items: const <BottomNavigationBarItem>[
          
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Inicio',
              backgroundColor: AppTheme.primary),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list_alt_rounded ,
                size: 30,
              ),
              label: 'Me gusta',
              backgroundColor: AppTheme.backgroundColor),
          
        ],
      ),
    );
  }
}
