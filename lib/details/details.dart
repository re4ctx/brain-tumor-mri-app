import 'dart:io';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final File image;
  final String label;
  final String confidence;

  Details({required this.image, required this.label, required this.confidence});

  @override
  Widget build(BuildContext context) {
    String explanation;

    if (label == 'Glioma') {
      explanation = 'Glioma adalah jenis tumor otak yang berasal dari sel-sel glial, yaitu sel-sel pendukung yang ada di dalam otak. Glioma dapat terbentuk di berbagai bagian otak dan sumsum tulang belakang. Mereka dapat bersifat ganas (kanker) atau jinak (non-kanker). Glioma ganas biasanya tumbuh dengan cepat dan dapat menyebar ke area di sekitarnya. Gejala yang mungkin muncul akibat glioma adalah sakit kepala yang berulang, mual, kehilangan keseimbangan, perubahan dalam penglihatan, dan masalah neurologis lainnya.';
    } else if (label == 'Meningioma') {
      explanation = 'Meningioma adalah jenis tumor otak yang berasal dari sel-sel meninges, yaitu lapisan tipis jaringan yang melapisi otak dan sumsum tulang belakang. Meningioma umumnya bersifat jinak, artinya mereka tidak menyebar ke jaringan di sekitarnya. Meningioma bisa tumbuh di mana saja di sepanjang meninges, tetapi biasanya mereka terlokalisasi di area tengkorak. Gejala yang mungkin timbul akibat meningioma tergantung pada ukuran dan lokasinya. Beberapa gejala umum termasuk sakit kepala, kejang, gangguan penglihatan, dan perubahan dalam perilaku atau kepribadian.';
    } else if (label == 'Pituitary') {
      explanation = 'Tumor pituitary, juga dikenal sebagai adenoma hipofisis, adalah jenis tumor yang terbentuk di kelenjar pituitary, yang terletak di dasar otak. Kelenjar pituitary berperan penting dalam mengendalikan produksi hormon di dalam tubuh. Tumor pituitary dapat bersifat jinak atau ganas, dan mereka dapat mempengaruhi produksi hormon pituitary. Gejala yang mungkin muncul akibat tumor pituitary tergantung pada ukuran dan jenisnya. Beberapa gejala yang umum termasuk gangguan penglihatan, perubahan siklus menstruasi, masalah keseimbangan hormon, dan sakit kepala.';
    } else {
        explanation = 'Hasil klasifikasi gambar menunjukkan bahwa tidak ditemukan adanya tumor pada gambar otak yang dianalisis. Hal ini menunjukkan bahwa tidak ada kelainan atau pertumbuhan abnormal seperti glioma, meningioma, atau pituitary pada gambar tersebut.';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff222831),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Penjelasan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Image.file(
                image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Nilai Confidence : ${confidence}',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    explanation,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
