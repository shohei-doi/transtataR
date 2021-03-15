transtataR
================

StataユーザーのためのRパッケージです。

  - 作成者：[土井翔平](https://shohei-doi.github.io/)
  - 連絡先：[shohei.doi0504@gmail.com](shohei.doi0504@gmail.com)

開発者はStataユーザーではないので、バグや要望を報告していただけると幸いです。

## インストール

`{devtools}`などを使ってGitHubからインストールをしてください。

``` r
devtools::install_github("shohei-doi/transtataR")
```

  - `{devtools}`をインストールしていない人は、まずこちらからインストールしてください。

<!-- end list -->

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

`stata2r()`という関数にStataのコードを入れて実行できます。 現在、対応しているStataのコマンドは以下の通りです。

  - `pwd`
  - `cd`
  - `use`
  - `insheet using`
  - `import excel`
  - `browse`
  - `sum`
  - `keep`
  - `drop`
  - `gen`
  - `reg`
  - `logit`
  - `probit`

### 具体例

例として[Tableau Public](https://public.tableau.com/s/resources)のSample
Dataから[Titanic Passenger
List](https://public.tableau.com/s/sites/default/files/media/titanic%20passenger%20list.csv)をダウンロードして、適当な場所に保存をします。

このようにしてStataのコマンド`use`でデータを読み込むことができます。

``` r
stata2r("insheet using 'data/titanic passenger list.csv'")
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

  - `.csv`

  - `.tsv`

  - `.xls[x]`

  - `.dta`

  - 文字列はシングルクオート`'`で囲んでください。

記述統計を見ます。

``` r
stata2r("sum")
```

|                                                  |      |
| :----------------------------------------------- | :--- |
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

**Variable type:
character**

| skim\_variable | n\_missing | complete\_rate | min | max | empty | n\_unique | whitespace |
| :------------- | ---------: | -------------: | --: | --: | ----: | --------: | ---------: |
| name           |          0 |           1.00 |  12 |  82 |     0 |      1307 |          0 |
| sex            |          0 |           1.00 |   4 |   6 |     0 |         2 |          0 |
| ticket         |          0 |           1.00 |   3 |  18 |     0 |       929 |          0 |
| cabin          |       1014 |           0.23 |   1 |  15 |     0 |       186 |          0 |
| embarked       |          2 |           1.00 |   1 |   1 |     0 |         3 |          0 |
| boat           |        823 |           0.37 |   1 |   7 |     0 |        27 |          0 |
| home.dest      |        564 |           0.57 |   5 |  50 |     0 |       369 |          0 |

**Variable type:
numeric**

| skim\_variable | n\_missing | complete\_rate |   mean |    sd |   p0 |  p25 |    p50 |    p75 |   p100 | hist  |
| :------------- | ---------: | -------------: | -----: | ----: | ---: | ---: | -----: | -----: | -----: | :---- |
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

回帰分析を行います。

``` r
stata2r("reg survived c.sex age")
```

<table class="kable_wrapper">

<tbody>

<tr>

<td>

| term               |    estimate | std.error |    statistic |   p.value |    conf.low |   conf.high |
| :----------------- | ----------: | --------: | -----------: | --------: | ----------: | ----------: |
| (Intercept)        |   0.7734799 | 0.0331389 |   23.3405257 | 0.0000000 |   0.7084534 |   0.8385065 |
| as.factor(sex)male | \-0.5460271 | 0.0266030 | \-20.5250524 | 0.0000000 | \-0.5982285 | \-0.4938257 |
| age                | \-0.0007286 | 0.0008920 |  \-0.8168609 | 0.4141945 | \-0.0024790 |   0.0010217 |

</td>

<td>

| r.squared | adj.r.squared |    sigma | statistic | p.value | df |    logLik |     AIC |      BIC | deviance | df.residual | nobs |
| --------: | ------------: | -------: | --------: | ------: | -: | --------: | ------: | -------: | -------: | ----------: | ---: |
| 0.2898984 |     0.2885368 | 0.414774 |   212.902 |       0 |  2 | \-562.205 | 1132.41 | 1152.221 | 179.4351 |        1043 | 1046 |

</td>

</tr>

</tbody>

</table>

``` r
stata2r("reg survived c.sex#age")
```

<table class="kable_wrapper">

<tbody>

<tr>

<td>

| term                   |    estimate | std.error |  statistic |   p.value |    conf.low |   conf.high |
| :--------------------- | ----------: | --------: | ---------: | --------: | ----------: | ----------: |
| (Intercept)            |   0.6376443 | 0.0461651 |  13.812273 | 0.0000000 |   0.5470573 |   0.7282314 |
| as.factor(sex)male     | \-0.3213069 | 0.0597572 | \-5.376873 | 0.0000001 | \-0.4385651 | \-0.2040487 |
| age                    |   0.0040064 | 0.0014350 |   2.791848 | 0.0053366 |   0.0011905 |   0.0068223 |
| as.factor(sex)male:age | \-0.0076412 | 0.0018230 | \-4.191583 | 0.0000301 | \-0.0112184 | \-0.0040641 |

</td>

<td>

| r.squared | adj.r.squared |     sigma | statistic | p.value | df |     logLik |     AIC |      BIC | deviance | df.residual | nobs |
| --------: | ------------: | --------: | --------: | ------: | -: | ---------: | ------: | -------: | -------: | ----------: | ---: |
| 0.3016731 |     0.2996625 | 0.4115181 |  150.0459 |       0 |  3 | \-553.4601 | 1116.92 | 1141.684 | 176.4597 |        1042 | 1046 |

</td>

</tr>

</tbody>

</table>

``` r
stata2r("logit survived c.sex age if age > 20")
```

<table class="kable_wrapper">

<tbody>

<tr>

<td>

| term               |    estimate | std.error |    statistic |   p.value |    conf.low |   conf.high |
| :----------------- | ----------: | --------: | -----------: | --------: | ----------: | ----------: |
| (Intercept)        |   1.0989882 | 0.2982265 |    3.6850786 | 0.0002286 |   0.5234534 |   1.6941716 |
| as.factor(sex)male | \-2.7380086 | 0.1832337 | \-14.9427117 | 0.0000000 | \-3.1040388 | \-2.3851325 |
| age                |   0.0044011 | 0.0075084 |    0.5861617 | 0.5577668 | \-0.0104175 |   0.0190546 |

</td>

<td>

| null.deviance | df.null |     logLik |      AIC |      BIC | deviance | df.residual | nobs |
| ------------: | ------: | ---------: | -------: | -------: | -------: | ----------: | ---: |
|      1068.898 |     797 | \-396.1391 | 798.2782 | 812.3245 | 792.2782 |         795 |  798 |

</td>

</tr>

</tbody>

</table>

``` r
stata2r("probit survived c.sex age if age <= 20")
```

<table class="kable_wrapper">

<tbody>

<tr>

<td>

| term               |    estimate | std.error |  statistic |   p.value |    conf.low |   conf.high |
| :----------------- | ----------: | --------: | ---------: | --------: | ----------: | ----------: |
| (Intercept)        |   1.0244842 | 0.2102965 |   4.871618 | 0.0000011 |   0.6291244 |   1.4291668 |
| as.factor(sex)male | \-1.0720972 | 0.1718239 | \-6.239511 | 0.0000000 | \-1.4107643 | \-0.7384901 |
| age                | \-0.0429378 | 0.0128453 | \-3.342690 | 0.0008297 | \-0.0679808 | \-0.0182344 |

</td>

<td>

| null.deviance | df.null |     logLik |      AIC |      BIC | deviance | df.residual | nobs |
| ------------: | ------: | ---------: | -------: | -------: | -------: | ----------: | ---: |
|      342.1863 |     247 | \-144.2955 | 294.5911 | 305.1314 | 288.5911 |         245 |  248 |

</td>

</tr>

</tbody>

</table>

## 発展的な使い方

### 内部の処理

`stata2r()`はStataのコマンドをRコードに変換して実行をしていますが、実はStataコマンドと同じ名前の関数を定義しています。
例えば、回帰分析を行う際には`reg()`を内部で呼び出しています。
なので、明示的に`reg()`を呼び出すことも可能です。

``` r
reg("survived sex age")
```

<table class="kable_wrapper">

<tbody>

<tr>

<td>

| term        |    estimate | std.error |    statistic |   p.value |    conf.low |   conf.high |
| :---------- | ----------: | --------: | -----------: | --------: | ----------: | ----------: |
| (Intercept) |   0.7734799 | 0.0331389 |   23.3405257 | 0.0000000 |   0.7084534 |   0.8385065 |
| sexmale     | \-0.5460271 | 0.0266030 | \-20.5250524 | 0.0000000 | \-0.5982285 | \-0.4938257 |
| age         | \-0.0007286 | 0.0008920 |  \-0.8168609 | 0.4141945 | \-0.0024790 |   0.0010217 |

</td>

<td>

| r.squared | adj.r.squared |    sigma | statistic | p.value | df |    logLik |     AIC |      BIC | deviance | df.residual | nobs |
| --------: | ------------: | -------: | --------: | ------: | -: | --------: | ------: | -------: | -------: | ----------: | ---: |
| 0.2898984 |     0.2885368 | 0.414774 |   212.902 |       0 |  2 | \-562.205 | 1132.41 | 1152.221 | 179.4351 |        1043 | 1046 |

</td>

</tr>

</tbody>

</table>

## 動作環境

``` r
sessionInfo()
```

    ## R version 4.0.4 (2021-02-15)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 18.04.5 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.7.1
    ## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.7.1
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
    ##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
    ##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
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
