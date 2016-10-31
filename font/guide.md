# font 최적화

한글폰트에서 자주 사용하는 한글만 추출하여 용량을 최적화 하는 방법

1. 폰트 subset 추출

   ```
   convert.pe NotoSansKR-DemiLight.otf
   ```

2. otf, woff, woff2 추출

    https://www.fontsquirrel.com/tools/webfont-generator
    EOT Lite 선택
    Subsetting > No Subsetting 으로 설정하고 추출
