import 'package:flutter/material.dart';

// const kPrimaryColor = Color(0xFF72CBDC);
const kPrimaryColor = Color(0xFF75A9FA);
// const kSecondaryColor = Color(0xFF281EA5);
// const kContentColorLightTheme = Color(0xFF1D1D35);
// const kSecondaryColor = Color(0xFF17172A);
const kSecondaryColor = Color(0xFF1E1E21);
const kContentColorLightTheme = Color(0xFF000000);
const kContentColorDarkTheme = Color(0xFFD8E4EC);
const kWarninngColor = Color(0xFFC7C000);
const kErrorColor = Color(0xFFF03738);
const kGradient1 = Color(0xFF5897FA);
const kGradient2 = Color(0xFFA48BFF);

const kDefaultPadding = 20.0;

List emojiList = [
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐คฃ",
  "๐ฅฒ",
  "โบ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ฅฐ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐คช",
  "๐คจ",
  "๐ง",
  "๐ค",
  "๐",
  "๐ฅธ",
  "๐คฉ",
  "๐ฅณ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "โน",
  "๐ฃ",
  "๐",
  "๐ซ",
  "๐ฉ",
  "๐ฅบ",
  "๐ข",
  "๐ญ",
  "๐ค",
  "๐ ",
  "๐ก",
  "๐คฌ",
  "๐คฏ",
  "๐ณ",
  "๐ฅต",
  "๐ฅถ",
  "๐ฑ",
  "๐จ",
  "๐ฐ",
  "๐ฅ",
  "๐",
  "๐ค",
  "๐ค",
  "๐คญ",
  "๐คซ",
  "๐คฅ",
  "๐ถ",
  "๐",
  "๐",
  "๐ฌ",
  "๐",
  "๐ฏ",
  "๐ฆ",
  "๐ง",
  "๐ฎ",
  "๐ฒ",
  "๐ฅฑ",
  "๐ด",
  "๐คค",
  "๐ช",
  "๐ต",
  "๐ค",
  "๐ฅด",
  "๐คข",
  "๐คฎ",
  "๐คง",
  "๐ท",
  "๐ค",
  "๐ค",
  "๐ค",
  "๐ค ",
  "๐",
  "๐ฟ",
  "๐น",
  "๐บ",
  "๐คก",
  "๐ฉ",
  "๐ป",
  "๐",
  "โ ",
  "๐ฝ",
  "๐พ",
  "๐ค",
  "๐",
  "๐บ",
  "๐ธ",
  "๐น",
  "๐ป",
  "๐ผ",
  "๐ฝ",
  "๐",
  "๐ฟ",
  "๐พ",
  "๐",
  "๐ค",
  "๐",
  "โ",
  "๐",
  "๐",
  "๐ค",
  "๐ค",
  "โ",
  "๐ค",
  "๐ค",
  "๐ค",
  "๐ค",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "โ",
  "๐",
  "๐",
  "โ",
  "๐",
  "๐ค",
  "๐ค",
  "๐",
  "๐",
  "๐",
  "๐คฒ",
  "๐ค",
  "๐",
  "โ",
  "๐",
  "๐คณ",
  "๐ช",
  "๐ฆพ",
  "๐ฆต",
  "๐ฆฟ",
  "๐ฆถ",
  "๐ฃ",
  "๐",
  "๐ฆป",
  "๐",
  "๐ซ",
  "๐ซ",
  "๐ง ",
  "๐ฆท",
  "๐ฆด",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ฉธ",
  "๐ถ",
  "๐ฑ",
  "๐ญ",
  "๐น",
  "๐ฐ",
  "๐ฆ",
  "๐ป",
  "๐ผ",
  "๐ปโโ",
  "๐จ",
  "๐ฏ",
  "๐ฆ",
  "๐ฎ",
  "๐ท",
  "๐ฝ",
  "๐ธ",
  "๐ต",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ง",
  "๐ฆ",
  "๐ค",
  "๐ฃ",
  "๐ฅ",
  "๐ฆ",
  "๐ฆ",
  "๐ฆ",
  "๐ฆ",
  "๐บ",
  "๐",
  "๐ด",
  "๐ฆ",
  "๐",
  "๐ชฑ",
  "๐",
  "๐ฆ",
  "๐",
  "๐",
  "๐",
  "๐ชฐ",
  "๐ชฒ",
  "๐ชณ",
  "๐ฆ",
  "๐ฆ",
  "๐ท",
  "๐ธ",
  "๐ฆ",
  "๐ข",
  "๐",
  "๐ฆ",
  "๐ฆ",
  "๐ฆ",
  "๐",
  "๐ฆ",
  "๐ฆ",
  "๐ฆ",
  "๐ฆ",
  "๐ก",
  "๐ ",
  "๐",
  "๐ฌ",
  "๐ณ",
  "๐",
  "๐ฆ",
  "๐",
  "๐",
  "๐",
  "๐ฆ",
  "๐ฆ",
  "๐ฆง",
  "๐ฆฃ",
  "๐",
  "๐ฆ",
  "๐ฆ",
  "๐ช",
  "๐ซ",
  "๐ฆ",
  "๐ฆ",
  "๐ฆฌ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ฆ",
  "๐",
  "๐ฆ",
  "๐",
  "๐ฉ",
  "๐ฆฎ",
  "๐โ๐ฆบ",
  "๐",
  "๐โโฌ",
  "๐ชถ",
  "๐",
  "๐ฆ",
  "๐ฆค",
  "๐ฆ",
  "๐ฆ",
  "๐ฆข",
  "๐ฆฉ",
  "๐",
  "๐",
  "๐ฆ",
  "๐ฆจ",
  "๐ฆก",
  "๐ฆซ",
  "๐ฆฆ",
  "๐ฆฅ",
  "๐",
  "๐",
  "๐ฟ",
  "๐ฆ",
  "๐พ",
  "๐",
  "๐ฒ",
  "๐ต",
  "๐",
  "๐ฒ",
  "๐ณ",
  "๐ด",
  "๐ชต",
  "๐ฑ",
  "๐ฟ",
  "โ",
  "๐",
  "๐",
  "๐ชด",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ชจ",
  "๐พ",
  "๐",
  "๐ท",
  "๐น",
  "๐ฅ",
  "๐บ",
  "๐ธ",
  "๐ผ",
  "๐ป",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ช",
  "๐ซ",
  "โญ",
  "๐",
  "โจ",
  "โก",
  "โ",
  "๐ฅ",
  "๐ฅ",
  "๐ช",
  "๐",
  "โ",
  "๐ค",
  "โ",
  "๐ฅ",
  "โ",
  "๐ฆ",
  "๐ง",
  "โ",
  "๐ฉ",
  "๐จ",
  "โ",
  "โ",
  "โ",
  "๐ฌ",
  "๐จ",
  "๐ง",
  "๐ฆ",
  "โ",
  "โ",
  "๐",
  "๐ซ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ซ",
  "๐",
  "๐",
  "๐",
  "๐ฅญ",
  "๐",
  "๐ฅฅ",
  "๐ฅ",
  "๐",
  "๐",
  "๐ฅ",
  "๐ฅฆ",
  "๐ฅฌ",
  "๐ฅ",
  "๐ถ",
  "๐ซ",
  "๐ฝ",
  "๐ฅ",
  "๐ซ",
  "๐ง",
  "๐ง",
  "๐ฅ",
  "๐ ",
  "๐ฅ",
  "๐ฅฏ",
  "๐",
  "๐ฅ",
  "๐ฅจ",
  "๐ง",
  "๐ฅ",
  "๐ณ",
  "๐ง",
  "๐ฅ",
  "๐ง",
  "๐ฅ",
  "๐ฅฉ",
  "๐",
  "๐",
  "๐ฆด",
  "๐ญ",
  "๐",
  "๐",
  "๐",
  "๐ซ",
  "๐ฅช",
  "๐ฅ",
  "๐ง",
  "๐ฎ",
  "๐ฏ",
  "๐ซ",
  "๐ฅ",
  "๐ฅ",
  "๐ซ",
  "๐ฅซ",
  "๐",
  "๐",
  "๐ฒ",
  "๐",
  "๐ฃ",
  "๐ฑ",
  "๐ฅ",
  "๐ฆช",
  "๐ค",
  "๐",
  "๐",
  "๐",
  "๐ฅ",
  "๐ฅ ",
  "๐ฅฎ",
  "๐ข",
  "๐ก",
  "๐ง",
  "๐จ",
  "๐ฆ",
  "๐ฅง",
  "๐ง",
  "๐ฐ",
  "๐",
  "๐ฎ",
  "๐ญ",
  "๐ฌ",
  "๐ซ",
  "๐ฟ",
  "๐ฉ",
  "๐ช",
  "๐ฐ",
  "๐ฅ",
  "๐ฏ",
  "๐ฅ",
  "๐ผ",
  "๐ซ",
  "โ",
  "๐ต",
  "๐ง",
  "๐ฅค",
  "๐ง",
  "๐ถ",
  "๐บ",
  "๐ป",
  "๐ฅ",
  "๐ท",
  "๐ฅ",
  "๐ธ",
  "๐น",
  "๐ง",
  "๐พ",
  "๐ง",
  "๐ฅ",
  "๐ด",
  "๐ฝ",
  "๐ฅฃ",
  "๐ฅก",
  "๐ฅข",
  "๐ง",
  "โฝ",
  "๐",
  "๐",
  "โพ",
  "๐ฅ",
  "๐พ",
  "๐",
  "๐",
  "๐ฅ",
  "๐ฑ",
  "๐ช",
  "๐",
  "๐ธ",
  "๐",
  "๐",
  "๐ฅ",
  "๐",
  "๐ช",
  "๐ฅ",
  "โณ",
  "๐ช",
  "๐น",
  "๐ฃ",
  "๐คฟ",
  "๐ฅ",
  "๐ฅ",
  "๐ฝ",
  "๐น",
  "๐ผ",
  "๐ท",
  "โธ",
  "๐ฅ",
  "๐ฟ",
  "โท",
  "๐",
  "๐ช",
  "๐โโ",
  "๐",
  "๐โโ",
  "๐คผโโ",
  "๐คผ",
  "๐คผโโ",
  "๐คธโโ",
  "๐คธ",
  "๐คธโโ",
  "โนโโ",
  "โน",
  "โนโโ",
  "๐คบ",
  "๐คพโโ",
  "๐คพ",
  "๐คพโโ",
  "๐โโ",
  "๐",
  "๐โโ",
  "๐",
  "๐งโโ",
  "๐ง",
  "๐งโโ",
  "๐โโ",
  "๐",
  "๐โโ",
  "๐โโ",
  "๐",
  "๐โโ",
  "๐คฝโโ",
  "๐คฝ",
  "๐คฝโโ",
  "๐ฃโโ",
  "๐ฃ",
  "๐ฃโโ",
  "๐งโโ",
  "๐ง",
  "๐งโโ",
  "๐ตโโ",
  "๐ต",
  "๐ตโโ",
  "๐ดโโ",
  "๐ด",
  "๐ดโโ",
  "๐",
  "๐ฅ",
  "๐ฅ",
  "๐ฅ",
  "๐",
  "๐",
  "๐ต",
  "๐",
  "๐ซ",
  "๐",
  "๐ช",
  "๐คน",
  "๐คนโโ",
  "๐คนโโ",
  "๐ญ",
  "๐ฉฐ",
  "๐จ",
  "๐ฌ",
  "๐ค",
  "๐ง",
  "๐ผ",
  "๐น",
  "๐ฅ",
  "๐ช",
  "๐ท",
  "๐บ",
  "๐ช",
  "๐ธ",
  "๐ช",
  "๐ป",
  "๐ฒ",
  "โ",
  "๐ฏ",
  "๐ณ",
  "๐ฎ",
  "๐ฐ",
  "๐งฉ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ป",
  "๐",
  "๐",
  "๐",
  "๐ฆฏ",
  "๐ฆฝ",
  "๐ฆผ",
  "๐ด",
  "๐ฒ",
  "๐ต",
  "๐",
  "๐บ",
  "๐จ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ก",
  "๐ ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "โ",
  "๐ซ",
  "๐ฌ",
  "๐ฉ",
  "๐บ",
  "๐ฐ",
  "๐",
  "๐ธ",
  "๐",
  "๐ถ",
  "โต",
  "๐ค",
  "๐ฅ",
  "๐ณ",
  "โด",
  "๐ข",
  "โ",
  "๐ช",
  "โฝ",
  "๐ง",
  "๐ฆ",
  "๐ฅ",
  "๐",
  "๐บ",
  "๐ฟ",
  "๐ฝ",
  "๐ผ",
  "๐ฐ",
  "๐ฏ",
  "๐",
  "๐ก",
  "๐ข",
  "๐ ",
  "โฒ",
  "โฑ",
  "๐",
  "๐",
  "๐",
  "๐",
  "โฐ",
  "๐",
  "๐ป",
  "๐",
  "โบ",
  "๐",
  "๐ ",
  "๐ก",
  "๐",
  "๐",
  "๐",
  "๐ญ",
  "๐ข",
  "๐ฌ",
  "๐ฃ",
  "๐ค",
  "๐ฅ",
  "๐ฆ",
  "๐จ",
  "๐ช",
  "๐ซ",
  "๐ฉ",
  "๐",
  "๐",
  "โช",
  "๐",
  "๐",
  "๐",
  "๐",
  "โฉ",
  "๐ค",
  "๐ฃ",
  "๐พ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "โ",
  "๐ฑ",
  "๐ฒ",
  "๐ป",
  "โจ",
  "๐ฅ",
  "๐จ",
  "๐ฑ",
  "๐ฒ",
  "๐น",
  "๐",
  "๐ฝ",
  "๐พ",
  "๐ฟ",
  "๐",
  "๐ผ",
  "๐ท",
  "๐ธ",
  "๐น",
  "๐ฅ",
  "๐ฝ",
  "๐",
  "๐",
  "โ",
  "๐",
  "๐ ",
  "๐บ",
  "๐ป",
  "๐",
  "๐",
  "๐",
  "๐งญ",
  "โฑ",
  "โฒ",
  "โฐ",
  "๐ฐ",
  "โ",
  "โณ",
  "๐ก",
  "๐",
  "๐",
  "๐ก",
  "๐ฆ",
  "๐ฏ",
  "๐ช",
  "๐งฏ",
  "๐ข",
  "๐ธ",
  "๐ต",
  "๐ด",
  "๐ถ",
  "๐ท",
  "๐ช",
  "๐ฐ",
  "๐ณ",
  "๐",
  "โ",
  "๐ช",
  "๐งฐ",
  "๐ช",
  "๐ง",
  "๐จ",
  "โ",
  "๐ ",
  "โ",
  "๐ช",
  "๐ฉ",
  "โ",
  "๐ชค",
  "๐งฑ",
  "โ",
  "๐งฒ",
  "๐ซ",
  "๐ฃ",
  "๐งจ",
  "๐ช",
  "๐ช",
  "๐ก",
  "โ",
  "๐ก",
  "๐ฌ",
  "โฐ",
  "๐ชฆ",
  "โฑ",
  "๐บ",
  "๐ฎ",
  "๐ฟ",
  "๐งฟ",
  "๐",
  "โ",
  "๐ญ",
  "๐ฌ",
  "๐ณ",
  "๐ฉน",
  "๐ฉบ",
  "๐",
  "๐",
  "๐ฉธ",
  "๐งฌ",
  "๐ฆ ",
  "๐งซ",
  "๐งช",
  "๐ก",
  "๐งน",
  "๐ช ",
  "๐งบ",
  "๐งป",
  "๐ฝ",
  "๐ฐ",
  "๐ฟ",
  "๐",
  "๐",
  "๐งผ",
  "๐ชฅ",
  "๐ช",
  "๐งฝ",
  "๐ชฃ",
  "๐งด",
  "๐",
  "๐",
  "๐",
  "๐ช",
  "๐ช",
  "๐",
  "๐",
  "๐",
  "๐งธ",
  "๐ช",
  "๐ผ",
  "๐ช",
  "๐ช",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ช",
  "๐ช",
  "๐",
  "๐",
  "๐",
  "๐ฎ",
  "๐",
  "๐งง",
  "โ",
  "๐ฉ",
  "๐จ",
  "๐ง",
  "๐",
  "๐ฅ",
  "๐ค",
  "๐ฆ",
  "๐ท",
  "๐ชง",
  "๐ช",
  "๐ซ",
  "๐ฌ",
  "๐ญ",
  "๐ฎ",
  "๐ฏ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐งพ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ณ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ฐ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐งท",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐งฎ",
  "๐",
  "๐",
  "โ",
  "๐",
  "๐",
  "โ",
  "๐",
  "๐",
  "๐",
  "โ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "โค",
  "๐งก",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ค",
  "๐ค",
  "๐ค",
  "๐",
  "โฃ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "โฎ",
  "โ",
  "โช",
  "๐",
  "โธ",
  "โก",
  "๐ฏ",
  "๐",
  "โฏ",
  "โฆ",
  "๐",
  "โ",
  "โ",
  "โ",
  "โ",
  "โ",
  "โ",
  "โ",
  "โ",
  "โ",
  "โ",
  "โ",
  "โ",
  "โ",
  "๐",
  "โ",
  "๐",
  "โข",
  "โฃ",
  "๐ด",
  "๐ณ",
  "๐ถ",
  "๐",
  "๐ธ",
  "๐บ",
  "๐ท",
  "โด",
  "๐",
  "๐ฎ",
  "๐",
  "ใ",
  "ใ",
  "๐ด",
  "๐ต",
  "๐น",
  "๐ฒ",
  "๐ฐ",
  "๐ฑ",
  "๐",
  "๐",
  "๐พ",
  "๐",
  "โ",
  "โญ",
  "๐",
  "โ",
  "๐",
  "๐ซ",
  "๐ฏ",
  "๐ข",
  "โจ",
  "๐ท",
  "๐ฏ",
  "๐ณ",
  "๐ฑ",
  "๐",
  "๐ต",
  "๐ญ",
  "โ",
  "โ",
  "โ",
  "โ",
  "โผ",
  "โ",
  "๐",
  "๐",
  "ใฝ",
  "โ ",
  "๐ธ",
  "๐ฑ",
  "โ",
  "๐ฐ",
  "โป",
  "โ",
  "๐ฏ",
  "๐น",
  "โ",
  "โณ",
  "โ",
  "๐",
  "๐ ",
  "โ",
  "๐",
  "๐ค",
  "๐ง",
  "๐พ",
  "โฟ",
  "๐ฟ",
  "๐",
  "๐ณ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐น",
  "๐บ",
  "๐ผ",
  "โง",
  "๐ป",
  "๐ฎ",
  "๐ฆ",
  "๐ถ",
  "๐",
  "๐ฃ",
  "โน",
  "๐ค",
  "๐ก",
  "๐ ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ข",
  "โ",
  "โถ",
  "โธ",
  "โฏ",
  "โน",
  "โบ",
  "โญ",
  "โฎ",
  "โฉ",
  "โช",
  "โซ",
  "โฌ",
  "โ",
  "๐ผ",
  "๐ฝ",
  "โก",
  "โฌ",
  "โฌ",
  "โฌ",
  "โ",
  "โ",
  "โ",
  "โ",
  "โ",
  "โ",
  "โช",
  "โฉ",
  "โคด",
  "โคต",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ต",
  "๐ถ",
  "โ",
  "โ",
  "โ",
  "โ",
  "โพ",
  "๐ฒ",
  "๐ฑ",
  "โข",
  "ยฉ",
  "ยฎ",
  "ใฐ",
  "โฐ",
  "โฟ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "โ",
  "โ",
  "๐",
  "๐ด",
  "๐ ",
  "๐ก",
  "๐ข",
  "๐ต",
  "๐ฃ",
  "โซ",
  "โช",
  "๐ค",
  "๐บ",
  "๐ป",
  "๐ธ",
  "๐น",
  "๐ถ",
  "๐ท",
  "๐ณ",
  "๐ฒ",
  "โช",
  "โซ",
  "โพ",
  "โฝ",
  "โผ",
  "โป",
  "๐ฅ",
  "๐ง",
  "๐จ",
  "๐ฉ",
  "๐ฆ",
  "๐ช",
  "โฌ",
  "โฌ",
  "๐ซ",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ฃ",
  "๐ข",
  "๐โ๐จ",
  "๐ฌ",
  "๐ญ",
  "๐ฏ",
  "โ ",
  "โฃ",
  "โฅ",
  "โฆ",
  "๐",
  "๐ด",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐",
  "๐ ",
  "๐ก",
  "๐ข",
  "๐ฃ",
  "๐ค",
  "๐ฅ",
  "๐ฆ",
  "๐ง"
];
