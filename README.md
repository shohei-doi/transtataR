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
-   `gen`
-   `reg`
-   `logit`
-   `probit`

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

-   ちなみに、読み込んだデータはR上では`temp`で保存されています。

記述統計を見ます。

``` r
stata2r("sum")
```

|                                                  |      |
|:-------------------------------------------------|:-----|
| Name                                             | temp |
| Number of rows                                   | 1309 |
| Number of columns                                | 14   |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |      |
| Column type frequency:                           |      |
| character                                        | 7    |
| numeric                                          | 7    |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |      |
| Group variables                                  | None |

Data summary

**Variable type: character**

| skim\_variable | n\_missing | complete\_rate | min | max | empty | n\_unique | whitespace |
|:---------------|-----------:|---------------:|----:|----:|------:|----------:|-----------:|
| name           |          0 |           1.00 |  12 |  82 |     0 |      1307 |          0 |
| sex            |          0 |           1.00 |   4 |   6 |     0 |         2 |          0 |
| ticket         |          0 |           1.00 |   3 |  18 |     0 |       929 |          0 |
| cabin          |       1014 |           0.23 |   1 |  15 |     0 |       186 |          0 |
| embarked       |          2 |           1.00 |   1 |   1 |     0 |         3 |          0 |
| boat           |        823 |           0.37 |   1 |   7 |     0 |        27 |          0 |
| home.dest      |        564 |           0.57 |   5 |  50 |     0 |       369 |          0 |

**Variable type: numeric**

| skim\_variable | n\_missing | complete\_rate |   mean |    sd |   p0 |  p25 |    p50 |    p75 |   p100 | hist  |
|:---------------|-----------:|---------------:|-------:|------:|-----:|-----:|-------:|-------:|-------:|:------|
| pclass         |          0 |           1.00 |   2.29 |  0.84 | 1.00 |  2.0 |   3.00 |   3.00 |   3.00 | ▃▁▃▁▇ |
| survived       |          0 |           1.00 |   0.38 |  0.49 | 0.00 |  0.0 |   0.00 |   1.00 |   1.00 | ▇▁▁▁▅ |
| age            |        263 |           0.80 |  29.88 | 14.41 | 0.17 | 21.0 |  28.00 |  39.00 |  80.00 | ▂▇▅▂▁ |
| sibsp          |          0 |           1.00 |   0.50 |  1.04 | 0.00 |  0.0 |   0.00 |   1.00 |   8.00 | ▇▁▁▁▁ |
| parch          |          0 |           1.00 |   0.39 |  0.87 | 0.00 |  0.0 |   0.00 |   0.00 |   9.00 | ▇▁▁▁▁ |
| fare           |          1 |           1.00 |  33.30 | 51.76 | 0.00 |  7.9 |  14.45 |  31.27 | 512.33 | ▇▁▁▁▁ |
| body           |       1188 |           0.09 | 160.81 | 97.70 | 1.00 | 72.0 | 155.00 | 256.00 | 328.00 | ▇▇▇▅▇ |

変数を作ります（試しに、18歳以下の女性を表す`fchild`を作ります）。

``` r
stata2r("gen fchild = 0")
stata2r("gen fchild = 1 if age <= 18 & sex == 'female'")
```

-   文字列はシングルクオート`'`で囲んでください。

回帰分析を行います。

``` r
stata2r("reg survived c.sex age")
```

    ## # A tibble: 3 x 7
    ##   term                estimate std.error statistic  p.value conf.low conf.high
    ##   <chr>                  <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
    ## 1 (Intercept)         0.773     0.0331      23.3   2.80e-97  0.708     0.839  
    ## 2 as.factor(sex)male -0.546     0.0266     -20.5   6.68e-79 -0.598    -0.494  
    ## 3 age                -0.000729  0.000892    -0.817 4.14e- 1 -0.00248   0.00102
    ## # A tibble: 1 x 12
    ##   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
    ##       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl> <dbl>
    ## 1     0.290         0.289 0.415      213. 2.91e-78     2  -562. 1132. 1152.
    ## # … with 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>

``` r
stata2r("reg survived c.sex#age")
```

    ## # A tibble: 4 x 7
    ##   term                  estimate std.error statistic  p.value conf.low conf.high
    ##   <chr>                    <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
    ## 1 (Intercept)            0.638     0.0462      13.8  5.67e-40  0.547     0.728  
    ## 2 as.factor(sex)male    -0.321     0.0598      -5.38 9.35e- 8 -0.439    -0.204  
    ## 3 age                    0.00401   0.00144      2.79 5.34e- 3  0.00119   0.00682
    ## 4 as.factor(sex)male:a… -0.00764   0.00182     -4.19 3.01e- 5 -0.0112   -0.00406
    ## # A tibble: 1 x 12
    ##   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
    ##       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl> <dbl>
    ## 1     0.302         0.300 0.412      150. 8.06e-81     3  -553. 1117. 1142.
    ## # … with 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>

``` r
stata2r("logit survived c.sex age if age > 20")
```

    ## # A tibble: 3 x 7
    ##   term               estimate std.error statistic  p.value conf.low conf.high
    ##   <chr>                 <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
    ## 1 (Intercept)         1.10      0.298       3.69  2.29e- 4   0.523     1.69  
    ## 2 as.factor(sex)male -2.74      0.183     -14.9   1.74e-50  -3.10     -2.39  
    ## 3 age                 0.00440   0.00751     0.586 5.58e- 1  -0.0104    0.0191
    ## # A tibble: 1 x 8
    ##   null.deviance df.null logLik   AIC   BIC deviance df.residual  nobs
    ##           <dbl>   <int>  <dbl> <dbl> <dbl>    <dbl>       <int> <int>
    ## 1         1069.     797  -396.  798.  812.     792.         795   798

``` r
stata2r("probit survived c.sex age if age <= 20")
```

    ## # A tibble: 3 x 7
    ##   term               estimate std.error statistic  p.value conf.low conf.high
    ##   <chr>                 <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
    ## 1 (Intercept)          1.02      0.210       4.87 1.11e- 6   0.629     1.43  
    ## 2 as.factor(sex)male  -1.07      0.172      -6.24 4.39e-10  -1.41     -0.738 
    ## 3 age                 -0.0429    0.0128     -3.34 8.30e- 4  -0.0680   -0.0182
    ## # A tibble: 1 x 8
    ##   null.deviance df.null logLik   AIC   BIC deviance df.residual  nobs
    ##           <dbl>   <int>  <dbl> <dbl> <dbl>    <dbl>       <int> <int>
    ## 1          342.     247  -144.  295.  305.     289.         245   248

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
    ##  [1] pillar_1.5.1      compiler_4.0.4    highr_0.8         base64enc_0.1-3  
    ##  [5] tools_4.0.4       digest_0.6.27     jsonlite_1.7.2    evaluate_0.14    
    ##  [9] lifecycle_1.0.0   tibble_3.1.0      pkgconfig_2.0.3   rlang_0.4.10     
    ## [13] cli_2.3.1         DBI_1.1.1         rstudioapi_0.13   yaml_2.2.1       
    ## [17] xfun_0.22         repr_1.1.3        stringr_1.4.0     dplyr_1.0.5      
    ## [21] knitr_1.31        generics_0.1.0    vctrs_0.3.6       hms_1.0.0        
    ## [25] tidyselect_1.1.0  glue_1.4.2        R6_2.5.0          fansi_0.4.2      
    ## [29] rmarkdown_2.7     readr_1.4.0       purrr_0.3.4       tidyr_1.1.3      
    ## [33] skimr_2.1.3       magrittr_2.0.1    MASS_7.3-53.1     backports_1.2.1  
    ## [37] ellipsis_0.3.1    htmltools_0.5.1.1 assertthat_0.2.1  utf8_1.2.1       
    ## [41] stringi_1.5.3     broom_0.7.5       crayon_1.4.1
