transtataR
================

StataユーザーのためのRパッケージです。

-   作成者：[土井翔平](https://shohei-doi.github.io/)
-   連絡先：[shohei.doi0504@gmail.com](shohei.doi0504@gmail.com)

開発者はStataユーザーではないので、バグや要望を報告していただけると幸いです。

## インストール

`{devtools}`などを使ってGitHubからインストールをしてください。

``` r
devtools::install_github("shohei-doi/transtataR")
```

-   `{devtools}`をインストールしていない人は、まずこちらからインストールしてください。

``` r
install.packages("devtools")
```

## 基本的な使い方

まずはパッケージを読み込みます。

``` r
library(transtataR)
```

    ## 
    ## Attaching package: 'transtataR'

    ## The following objects are masked from 'package:base':
    ## 
    ##     drop, sum

`stata2r()`という関数にStataのコードを入れて実行できます。
現在、対応しているStataのコマンドは以下の通りです。

-   `pwd`
-   `cd`
-   `use`
-   `browse`
-   `sum`
-   `keep`
-   `drop`
-   `reg`

### 具体例

例として[Tableau Public](https://public.tableau.com/s/resources)のSample
Dataから[Titanic Passenger
List](https://public.tableau.com/s/sites/default/files/media/titanic%20passenger%20list.csv)をダウンロードして、適当な場所に保存をします。

このようにしてStataのコマンド`use`でデータを読み込むことができます。

``` r
stata2r("use data/titanic passenger list.csv")
```

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   pclass = col_double(),
    ##   survived = col_double(),
    ##   name = col_character(),
    ##   sex = col_character(),
    ##   age = col_double(),
    ##   sibsp = col_double(),
    ##   parch = col_double(),
    ##   ticket = col_character(),
    ##   fare = col_double(),
    ##   cabin = col_character(),
    ##   embarked = col_character(),
    ##   boat = col_character(),
    ##   body = col_double(),
    ##   home.dest = col_character()
    ## )

現在、対応しているファイル形式は以下の通りです。

-   `.csv`
-   `.tsv`
-   `.xls[x]`
-   `.dta`

ちなみに、読み込んだデータはR上では`temp`で保存されています。

``` r
stata2r("sum")
```

    ## ── Data Summary ────────────────────────
    ##                            Values
    ## Name                       temp  
    ## Number of rows             1309  
    ## Number of columns          14    
    ## _______________________          
    ## Column type frequency:           
    ##   character                7     
    ##   numeric                  7     
    ## ________________________         
    ## Group variables            None  
    ## 
    ## ── Variable type: character ────────────────────────────────────────────────────
    ##   skim_variable n_missing complete_rate   min   max empty n_unique whitespace
    ## 1 name                  0         1        12    82     0     1307          0
    ## 2 sex                   0         1         4     6     0        2          0
    ## 3 ticket                0         1         3    18     0      929          0
    ## 4 cabin              1014         0.225     1    15     0      186          0
    ## 5 embarked              2         0.998     1     1     0        3          0
    ## 6 boat                823         0.371     1     7     0       27          0
    ## 7 home.dest           564         0.569     5    50     0      369          0
    ## 
    ## ── Variable type: numeric ──────────────────────────────────────────────────────
    ##   skim_variable n_missing complete_rate    mean     sd    p0   p25   p50   p75
    ## 1 pclass                0        1        2.29   0.838  1     2      3     3  
    ## 2 survived              0        1        0.382  0.486  0     0      0     1  
    ## 3 age                 263        0.799   29.9   14.4    0.17 21     28    39  
    ## 4 sibsp                 0        1        0.499  1.04   0     0      0     1  
    ## 5 parch                 0        1        0.385  0.866  0     0      0     0  
    ## 6 fare                  1        0.999   33.3   51.8    0     7.90  14.5  31.3
    ## 7 body               1188        0.0924 161.    97.7    1    72    155   256  
    ##    p100 hist 
    ## 1    3  ▃▁▃▁▇
    ## 2    1  ▇▁▁▁▅
    ## 3   80  ▂▇▅▂▁
    ## 4    8  ▇▁▁▁▁
    ## 5    9  ▇▁▁▁▁
    ## 6  512. ▇▁▁▁▁
    ## 7  328  ▇▇▇▅▇

``` r
stata2r("reg survived sex age")
```

    ## # A tibble: 3 x 7
    ##   term         estimate std.error statistic  p.value conf.low conf.high
    ##   <chr>           <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
    ## 1 (Intercept)  0.773     0.0331      23.3   2.80e-97  0.708     0.839  
    ## 2 sexmale     -0.546     0.0266     -20.5   6.68e-79 -0.598    -0.494  
    ## 3 age         -0.000729  0.000892    -0.817 4.14e- 1 -0.00248   0.00102
    ## # A tibble: 1 x 12
    ##   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
    ##       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl> <dbl>
    ## 1     0.290         0.289 0.415      213. 2.91e-78     2  -562. 1132. 1152.
    ## # … with 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>

``` r
stata2r("reg survived sex age if age > 20")
```

    ## # A tibble: 3 x 7
    ##   term         estimate std.error statistic  p.value conf.low conf.high
    ##   <chr>           <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
    ## 1 (Intercept)  0.753      0.0483     15.6   5.44e-48  0.658     0.848  
    ## 2 sexmale     -0.593      0.0296    -20.0   1.46e-72 -0.651    -0.535  
    ## 3 age          0.000700   0.00120     0.585 5.59e- 1 -0.00165   0.00305
    ## # A tibble: 1 x 12
    ##   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
    ##       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl> <dbl>
    ## 1     0.335         0.334 0.399      201. 2.78e-71     2  -397.  802.  821.
    ## # … with 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>

## 発展的な使い方

### 内部の処理

`stata2r()`はStataのコマンドをRコードに変換して実行をしていますが、実はStataコマンドと同じ名前の関数を定義しています。
例えば、回帰分析を行う際には`reg()`を内部で呼び出しています。
なので、明示的に`reg()`を呼び出すことも可能です。

``` r
reg("survived sex age")
```

    ## # A tibble: 3 x 7
    ##   term         estimate std.error statistic  p.value conf.low conf.high
    ##   <chr>           <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
    ## 1 (Intercept)  0.773     0.0331      23.3   2.80e-97  0.708     0.839  
    ## 2 sexmale     -0.546     0.0266     -20.5   6.68e-79 -0.598    -0.494  
    ## 3 age         -0.000729  0.000892    -0.817 4.14e- 1 -0.00248   0.00102
    ## # A tibble: 1 x 12
    ##   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
    ##       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl> <dbl>
    ## 1     0.290         0.289 0.415      213. 2.91e-78     2  -562. 1132. 1152.
    ## # … with 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>

## 動作環境

``` r
sessionInfo()
```

    ## R version 4.0.4 (2021-02-15)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 20.04.2 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.9.0
    ## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.9.0
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=ja_JP.UTF-8        LC_COLLATE=en_US.UTF-8    
    ##  [5] LC_MONETARY=ja_JP.UTF-8    LC_MESSAGES=en_US.UTF-8   
    ##  [7] LC_PAPER=ja_JP.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=ja_JP.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] transtataR_0.0.1
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] pillar_1.5.1      compiler_4.0.4    base64enc_0.1-3   tools_4.0.4      
    ##  [5] digest_0.6.27     jsonlite_1.7.2    evaluate_0.14     lifecycle_1.0.0  
    ##  [9] tibble_3.1.0      pkgconfig_2.0.3   rlang_0.4.10      cli_2.3.1        
    ## [13] DBI_1.1.1         rstudioapi_0.13   yaml_2.2.1        xfun_0.22        
    ## [17] repr_1.1.3        withr_2.4.1       stringr_1.4.0     dplyr_1.0.5      
    ## [21] knitr_1.31        generics_0.1.0    vctrs_0.3.6       hms_1.0.0        
    ## [25] tidyselect_1.1.0  glue_1.4.2        R6_2.5.0          fansi_0.4.2      
    ## [29] rmarkdown_2.7     readr_1.4.0       purrr_0.3.4       tidyr_1.1.3      
    ## [33] skimr_2.1.3       magrittr_2.0.1    backports_1.2.1   ellipsis_0.3.1   
    ## [37] htmltools_0.5.1.1 assertthat_0.2.1  utf8_1.2.1        stringi_1.5.3    
    ## [41] broom_0.7.5       crayon_1.4.1
