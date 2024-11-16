import 'package:flutter/material.dart';

class Intropage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF6F7F9),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Row(
        // استخدام Row لعرض الصورة والنص جنب بعض
        mainAxisAlignment: MainAxisAlignment.start, // لضبط العناصر لليسار
        crossAxisAlignment:
            CrossAxisAlignment.center, // لضبط محاذاة العناصر عمودياً
        children: [
          // الصورة على اليسار
          Image.asset(
            'assets/img/img2.jpg',
            height: 140, // جعل الصورة أصغر لتناسب المساحة
            width: 140, // عرض الصورة
          ),
          SizedBox(width: 20), // ترك مسافة بين الصورة والنص
          // النص على اليمين
          Expanded(
            // لتوسيع النص ليأخذ المساحة المتبقية
            child: Text(
              'قد تجرف المياه جسراً مدمراً أو طريقاً مكسوراً، فالتزم الحذر والابتعاد.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.right, // محاذاة النص إلى اليمين
            ),
          ),
        ],
      ),
    );
  }
}
