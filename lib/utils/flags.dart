String getFlag(String currencyName) {

  const currencyToFlag = {
    "دولار أمريكي / USD": "assets/images/USD.jpg",
    "يورو / EUR": "assets/images/EUR.jpg",
    "ريال سعودي / SAR": "assets/images/SAR.jpg",
    "درهم إماراتي / AED": "assets/images/AED.jpg",
    "دينار بحريني / BHD": "assets/images/BHD.jpg",
    "فرنك سويسري / CHF": "assets/images/CHF.jpg",
    "جنية إسترليني / GBP": "assets/images/GBP.jpg",
    "دينار أردني / JOD": "assets/images/JOD.jpg",
    "ين ياباني JPY": "assets/images/JPY.jpg",
    "دينار كويتي KWD": "assets/images/KWD.jpg",
    "ريال عماني / OMR": "assets/images/OMR.jpg",
    "ريال قطري / QAR ": "assets/images/QAR.jpg",
  };

  String? flag = currencyToFlag[currencyName];

  return flag ?? "assets/images/USD.jpg";
}