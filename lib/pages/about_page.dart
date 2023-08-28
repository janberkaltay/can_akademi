import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFAA00),
      appBar: AppBar(
        title: const Text('Hakkımızda'),
        elevation: 0,
        backgroundColor: const Color(0xFFFFAA00),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: const [
            Text(
              "Can Akademi, Adana'da faaliyet gösteren özel bir eğitim kurumu olarak ortaokul çağındaki öğrencilere derslerinde destek olmayı amaçlamaktadır."
              "Amacımız, öğrencilerimizin akademik başarılarını artırmak ve nitelikli liselere girişlerini sağlamaktır.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              "2023 Liselere Geçiş Sınavı'nda (LGS) öğrencilerimizin yaklaşık %75'i nitelikli liselere yerleşmesi, kurumumuzun etkin eğitim yöntemleri ve öğretmen kadrosunun kalitesinin bir göstergesidir."
              "Nitelikli liselere yerleşme oranımız, öğrencilerimizin LGS'ye hazırlanmalarında ve sınavda başarılı olmalarında kurumumuzun sağladığı desteğin bir sonucudur.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              "Can Akademi Adana olarak başarımızı belirleyen çeşitli etmenler bulunmaktadır. Bunlar arasında:",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              "Nitelikli Öğretmen Kadrosu: Öğrencilerimizin eğitimine en iyi şekilde destek verebilmek için alanında uzman, deneyimli ve özverili öğretmenlerle çalışıyoruz."
              "Öğretmenlerimiz, öğrencilerimizin bireysel ihtiyaçlarını anlamak ve onlara uygun stratejiler geliştirmek konusunda yeteneklidir.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8.0),
            Text(
              "Bireysel Takip ve Destek: Her öğrencinin güçlü ve zayıf yönlerini belirlemek ve onlara uygun bir eğitim programı oluşturmak için bireysel takip ve destek sunuyoruz."
              "Öğrencilerimizin ilerlemesini yakından takip ediyor, gerektiğinde ekstra yardım sağlıyor ve motivasyonlarını artırmaya yönelik çalışmalar yapıyoruz.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8.0),
            Text(
              "Zengin Kaynaklar: Öğrencilerimize çeşitli kaynaklar sunarak onların öğrenme deneyimini zenginleştiriyoruz. Nitelikli kitaplar, interaktif materyaller ve online eğitim "
              "platformları gibi kaynaklarla öğrencilerimizin farklı öğrenme stillerine hitap ediyor ve onların derslerdeki başarılarını destekliyoruz.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8.0),
            Text(
              "Motivasyon ve Rehberlik: Öğrencilerimizin sadece akademik başarılarını değil, aynı zamanda kişisel gelişimlerini de önemsiyoruz. Motivasyonel etkinlikler, "
              "rehberlik seansları ve kariyer planlaması gibi faaliyetlerle öğrencilerimizin özgüvenlerini artırmayı ve gelecekteki hedeflerine ulaşmalarına yardımcı olmayı amaçlıyoruz.",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "Can Akademi Adana olarak, öğrencilerimizin başarısı ve geleceği için çalışmaktan gurur duyuyoruz. Nitelikli liselere yerleşme oranımızdaki yüksek başarı, eğitim metodolojimizin "
              "etkinliğini ve öğrencilerimizin potansiyellerini ortaya çıkarmadaki başarımızı göstermektedir. Kendini geliştirmek ve başarıya ulaşmak isteyen ortaokul öğrencileri için Can Akademi Adana, güvenilir bir eğitim kurumu olarak tercih edilmektedir.",
              style: TextStyle(fontSize: 14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Illustrations by storyset.com',
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
