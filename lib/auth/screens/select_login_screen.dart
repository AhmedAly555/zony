import 'package:flutter/material.dart';
import 'package:zony/auth/widgets/language_widget.dart';

import '../../services/size_config.dart';
import '../widgets/box.widget.dart';

class SelectLoginScreen extends StatefulWidget {
  const SelectLoginScreen({super.key});

  @override
  State<SelectLoginScreen> createState() => _SelectLoginScreenState();
}

class _SelectLoginScreenState extends State<SelectLoginScreen> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Stack(
          alignment: Alignment.center,
          children: [
            //LanguageWidget(),
            Align(
              alignment: Alignment.center,
              child: Text(
                'login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            Align(alignment: Alignment.centerLeft, child: LanguageWidget()),
          ],
        ),
        //leading: LanguageWidget(),
        //centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          height: SizeConfig.heightPercent(0.38),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Log in as',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 10),
                Divider(height: 1, color: Color(0xFFF4F4F4)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BoxChoice(
                      svgPath: 'assets/svgs/PODU_logo.svg',
                      title: 'PODU',
                      onTap: () {
                        setState(() {
                          _selectedIndex = 0; // Select PODU
                        });
                        print('Selected:::::::: $_selectedIndex');
                      },
                      isSelected: _selectedIndex == 0,
                    ),

                    SizedBox(width: 10),
                    BoxChoice(
                      svgPath: 'assets/svgs/Courier_logo.svg',
                      title: 'Courier',
                      onTap: () {
                        setState(() {
                          _selectedIndex = 1; // Select Courier
                        });
                        print('Selected:::::::: $_selectedIndex');
                      },
                      isSelected: _selectedIndex == 1,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: 0.0,
                    end:
                        (_selectedIndex == 0 || _selectedIndex == 1)
                            ? 1.0
                            : 0.0,
                  ),
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xFF49159B),
                            Color.lerp(
                              Color(0xFF49159B),
                              Color(0xFFF4F4F4),
                              1 - value,
                            )!,
                          ],
                          stops: [0.0, value.clamp(0.0, 1.0)],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed:
                            (_selectedIndex == 0 || _selectedIndex == 1)
                                ? () {
                                  //
                                }
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                /*SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      /* 
                      if (_selectedIndex == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PODUFilterPage(),
                          ),
                        );
                      } else if (_selectedIndex == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourierFilterPage(),
                          ),
                        );
                      } */
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          (_selectedIndex == 0 || _selectedIndex == 1)
                              ? Color(0xFF49159B)
                              : Color(0xFFBDBDBD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
