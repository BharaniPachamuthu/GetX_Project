import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CalciController.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Calculator extends StatelessWidget {
  final CalculatorController controller = Get.put(CalculatorController());

  Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenUtilInit(
        designSize: const Size(393, 853),
        builder: (context, child) => Scaffold(
          backgroundColor: Colors.grey.shade900,
          body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20).r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Obx(() => Align(
                        alignment: Alignment.bottomRight,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10).r,
                            child: Text(
                              controller.display.value,
                              style: const TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )),
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: controller.btn.length,
                  itemBuilder: (context, index) {
                    var value = controller.btn[index];
                    return buildBtn(value);
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    buildBtn("."),
                    const Spacer(),
                    buildBtn("0"),
                    const Spacer(),
                    buildBtn("=", changeWidget: true)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBtn(String value, {bool changeWidget = false}) {
    return Bounceable(
      scaleFactor: 0.7,
      onTap: () {
        _onButtonPress(value);
      },
      child: Container(
        height: changeWidget ? 74.h : 74.h,
        width: changeWidget ? 160.w : 76.w,
        margin: const EdgeInsets.all(5).r,
        decoration: BoxDecoration(
          color: ['=', '+', '-', '/', '*', '%'].contains(value)
              ? const Color(0xffea8729)
              : Colors.white30,
          borderRadius: BorderRadius.circular(60.0).r,
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _onButtonPress(String button) {
    if (button == 'AC') {
      controller.reset();
    } else if (button == '=') {
      controller.calculate();
    } else if (button == 'C') {
      controller.clear();
    } else if (['+', '-', '*', '/', '%'].contains(button)) {
      controller.setOperator(button);
    } else {
      controller.addDigit(button);
    }
  }
}
