transtataR
================

StataユーザーのためのRパッケージです。

  - 作成者：[土井翔平](https://shohei-doi.github.io/)
  - 連絡先：[shohei.doi0504@gmail.com](shohei.doi0504@gmail.com)

趣味の範囲内なので、それをご理解の上、ご利用して下さい。 開発者はStataユーザーではないので、バグや要望を報告していただけると幸いです。

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

`stata2r()`という関数にStataのコードを入れて実行できます。 現在、対応しているStataのコマンドは以下の通りです。

  - `pwd`
  - `cd`
  - `use`
  - `save`
  - `insheet using`
  - `import excel`
  - `browse`
  - `list`
  - `sum`
  - `rename`
  - `keep`
  - `drop`
  - `gen`
  - `replace`
  - `reg`
  - `logit`
  - `probit`

### 具体例

例として[Tableau Public](https://public.tableau.com/s/resources)のSample
Dataから[Titanic Passenger
List](https://public.tableau.com/s/sites/default/files/media/titanic%20passenger%20list.csv)をダウンロードして、適当な場所に保存をします。

#### データの読み込み

このようにしてStataのコマンド`use`でデータを読み込むことができます。

``` r
stata2r("insheet using 'data/titanic passenger list.csv'")
```

    ## Stata code:
    ## insheet using 'data/titanic passenger list.csv'

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

  - 文字列はシングルクオート`'`で囲んでください。

#### データの閲覧

生データを見ます。

``` r
stata2r("browse")
stata2r("browse if age > 20")
stata2r("browse sex age")
```

生データの一部を見ます。

``` r
stata2r("list if age > 20")
```

    ## Stata code:
    ## list if age > 20
    ## 
    ## # A tibble: 6 x 14
    ##   pclass survived name       sex     age sibsp parch ticket  fare cabin embarked
    ##    <dbl>    <dbl> <chr>      <chr> <dbl> <dbl> <dbl> <chr>  <dbl> <chr> <chr>   
    ## 1      1        1 Allen, Mi… fema…    29     0     0 24160  211.  B5    S       
    ## 2      1        0 Allison, … male     30     1     2 113781 152.  C22 … S       
    ## 3      1        0 Allison, … fema…    25     1     2 113781 152.  C22 … S       
    ## 4      1        1 Anderson,… male     48     0     0 19952   26.6 E12   S       
    ## 5      1        1 Andrews, … fema…    63     1     0 13502   78.0 D7    S       
    ## 6      1        0 Andrews, … male     39     0     0 112050   0   A36   S       
    ## # … with 3 more variables: boat <chr>, body <dbl>, home.dest <chr>

``` r
stata2r("list sex age")
```

    ## Stata code:
    ## list sex age
    ## 
    ## # A tibble: 6 x 2
    ##   sex      age
    ##   <chr>  <dbl>
    ## 1 female 29   
    ## 2 male    0.92
    ## 3 female  2   
    ## 4 male   30   
    ## 5 female 25   
    ## 6 male   48

#### 記述統計

記述統計を見ます。

``` r
stata2r("sum")
```

    ## Stata code:
    ## sum
    ## 
    ## ── Data Summary ────────────────────────
    ##                            Values
    ## Name                       dat   
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

#### 変数の作成、加工

変数を作ります（試しに、18歳以下の女性を表す`fchild`を作ります）。

``` r
stata2r("gen fchild = 0")
```

    ## Stata code:
    ## gen fchild = 0

``` r
stata2r("replace fchild = 1 if age <= 18 & sex == 'female'")
```

    ## Stata code:
    ## replace fchild = 1 if age <= 18 & sex == 'female'

#### 回帰分析

回帰分析を行います。

``` r
stata2r("reg survived c.sex age")
```

    ## Stata code:
    ## reg survived c.sex age
    ## 
    ## Coefficitnes:
    ## # A tibble: 3 x 7
    ##   term                estimate std.error statistic  p.value conf.low conf.high
    ##   <chr>                  <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
    ## 1 (Intercept)         0.773     0.0331      23.3   2.80e-97  0.708     0.839  
    ## 2 as.factor(sex)male -0.546     0.0266     -20.5   6.68e-79 -0.598    -0.494  
    ## 3 age                -0.000729  0.000892    -0.817 4.14e- 1 -0.00248   0.00102
    ## 
    ## Model summaries:
    ## # A tibble: 1 x 12
    ##   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
    ##       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl> <dbl>
    ## 1     0.290         0.289 0.415      213. 2.91e-78     2  -562. 1132. 1152.
    ## # … with 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>

``` r
stata2r("reg survived c.sex#age")
```

    ## Stata code:
    ## reg survived c.sex#age
    ## 
    ## Coefficitnes:
    ## # A tibble: 4 x 7
    ##   term                  estimate std.error statistic  p.value conf.low conf.high
    ##   <chr>                    <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
    ## 1 (Intercept)            0.638     0.0462      13.8  5.67e-40  0.547     0.728  
    ## 2 as.factor(sex)male    -0.321     0.0598      -5.38 9.35e- 8 -0.439    -0.204  
    ## 3 age                    0.00401   0.00144      2.79 5.34e- 3  0.00119   0.00682
    ## 4 as.factor(sex)male:a… -0.00764   0.00182     -4.19 3.01e- 5 -0.0112   -0.00406
    ## 
    ## Model summaries:
    ## # A tibble: 1 x 12
    ##   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
    ##       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl> <dbl>
    ## 1     0.302         0.300 0.412      150. 8.06e-81     3  -553. 1117. 1142.
    ## # … with 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>

``` r
stata2r("logit survived c.sex age if age > 20")
```

    ## Stata code:
    ## logit survived c.sex age if age > 20
    ## 
    ## Coefficitnes:
    ## # A tibble: 3 x 7
    ##   term               estimate std.error statistic  p.value conf.low conf.high
    ##   <chr>                 <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
    ## 1 (Intercept)         1.24      0.192       6.43  1.25e-10   0.865    1.62   
    ## 2 as.factor(sex)male -2.46      0.152     -16.2   1.04e-58  -2.76    -2.17   
    ## 3 age                -0.00425   0.00521    -0.817 4.14e- 1  -0.0145   0.00592
    ## 
    ## Model summaries:
    ## # A tibble: 1 x 8
    ##   null.deviance df.null logLik   AIC   BIC deviance df.residual  nobs
    ##           <dbl>   <int>  <dbl> <dbl> <dbl>    <dbl>       <int> <int>
    ## 1         1415.    1045  -551. 1107. 1122.    1101.        1043  1046

``` r
stata2r("probit survived c.sex age if age <= 20")
```

    ## Stata code:
    ## probit survived c.sex age if age <= 20
    ## 
    ## Coefficitnes:
    ## # A tibble: 3 x 7
    ##   term               estimate std.error statistic  p.value conf.low conf.high
    ##   <chr>                 <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
    ## 1 (Intercept)         0.756     0.112       6.78  1.22e-11  0.542     0.972  
    ## 2 as.factor(sex)male -1.50      0.0888    -16.9   4.13e-64 -1.68     -1.33   
    ## 3 age                -0.00259   0.00302    -0.859 3.91e- 1 -0.00848   0.00327
    ## 
    ## Model summaries:
    ## # A tibble: 1 x 8
    ##   null.deviance df.null logLik   AIC   BIC deviance df.residual  nobs
    ##           <dbl>   <int>  <dbl> <dbl> <dbl>    <dbl>       <int> <int>
    ## 1         1415.    1045  -551. 1107. 1122.    1101.        1043  1046

## 発展的な使い方

### 複数行の実行

`stata2r()`には複数のStataコードを入力することができます。

``` r
stata2r(
  "insheet using 'data/titanic passenger list.csv'",
  "list age sex",
  "reg survived c.sex age"
)
```

    ## Stata code:
    ## insheet using 'data/titanic passenger list.csv'

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

    ## Stata code:
    ## list age sex
    ## 
    ## # A tibble: 6 x 2
    ##     age sex   
    ##   <dbl> <chr> 
    ## 1 29    female
    ## 2  0.92 male  
    ## 3  2    female
    ## 4 30    male  
    ## 5 25    female
    ## 6 48    male  
    ## 
    ## Stata code:
    ## reg survived c.sex age
    ## 
    ## Coefficitnes:
    ## # A tibble: 3 x 7
    ##   term                estimate std.error statistic  p.value conf.low conf.high
    ##   <chr>                  <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
    ## 1 (Intercept)         0.773     0.0331      23.3   2.80e-97  0.708     0.839  
    ## 2 as.factor(sex)male -0.546     0.0266     -20.5   6.68e-79 -0.598    -0.494  
    ## 3 age                -0.000729  0.000892    -0.817 4.14e- 1 -0.00248   0.00102
    ## 
    ## Model summaries:
    ## # A tibble: 1 x 12
    ##   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
    ##       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>  <dbl> <dbl> <dbl>
    ## 1     0.290         0.289 0.415      213. 2.91e-78     2  -562. 1132. 1152.
    ## # … with 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>

### Rコードの表示

オプション`show.code`を`TRUE`にするとコマンドを実行する代わりにRコードとパッケージを表示します。

``` r
stata2r("reg survived c.sex#age", show.code = TRUE)
```

    ## Stata code:
    ## reg survived c.sex#age
    ## 
    ## R code:
    ## model <- lm(survived ~ as.factor(sex)*age, data = dat)
    ## tidy(model, conf.int = TRUE)
    ## glance(model)
    ## 
    ## R packages:
    ## # A tibble: 2 x 2
    ##   package `function`
    ##   <chr>   <chr>     
    ## 1 broom   tidy      
    ## 2 broom   glance

``` r
stata2r(
  "insheet using 'data/titanic passenger list.csv'",
  "list age sex",
  "reg survived c.sex age",
  show.code = TRUE
)
```

    ## Stata code:
    ## insheet using 'data/titanic passenger list.csv'
    ## 
    ## R code:
    ## dat <- read_csv("data/titanic passenger list.csv")
    ## names(dat) <- str_replace_all(names(dat), " +", "_")
    ## 
    ## R packages:
    ## # A tibble: 2 x 2
    ##   package `function`     
    ##   <chr>   <chr>          
    ## 1 readr   read_csv       
    ## 2 stringr str_replace_all
    ## 
    ## Stata code:
    ## list age sex
    ## 
    ## R code:
    ## temp <- dat
    ## temp <- select(temp, age, sex)
    ## head(temp)
    ## 
    ## R packages:
    ## # A tibble: 1 x 2
    ##   package `function`
    ##   <chr>   <chr>     
    ## 1 dplyr   select    
    ## 
    ## Stata code:
    ## reg survived c.sex age
    ## 
    ## R code:
    ## model <- lm(survived ~ as.factor(sex) + age, data = dat)
    ## tidy(model, conf.int = TRUE)
    ## glance(model)
    ## 
    ## R packages:
    ## # A tibble: 2 x 2
    ##   package `function`
    ##   <chr>   <chr>     
    ## 1 broom   tidy      
    ## 2 broom   glance

### doファイルの変換

関数`transtataR()`はdoファイルのパスを引数に取り、Rコードに翻訳します。
例えば、[サンプルdoファイル](code/sample.do)を[Rコード](code/sample.R)にしてみます。

``` r
transtataR("code/sample.do")
```

`execute`を`TRUE`にするとコードの変換の代わりに実行します。

``` r
transtataR("code/sample.do", execute = TRUE)
```

    ## Stata code:
    ## insheet using 'data/titanic passenger list.csv'

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

    ## Stata code:
    ## list age sex if age > 20
    ## 
    ## # A tibble: 6 x 2
    ##     age sex   
    ##   <dbl> <chr> 
    ## 1    29 female
    ## 2    30 male  
    ## 3    25 female
    ## 4    48 male  
    ## 5    63 female
    ## 6    39 male  
    ## 
    ## Stata code:
    ## reg survived c.sex age
    ## 
    ## Coefficitnes:
    ## # A tibble: 3 x 7
    ##   term                estimate std.error statistic  p.value conf.low conf.high
    ##   <chr>                  <dbl>     <dbl>     <dbl>    <dbl>    <dbl>     <dbl>
    ## 1 (Intercept)         0.773     0.0331      23.3   2.80e-97  0.708     0.839  
    ## 2 as.factor(sex)male -0.546     0.0266     -20.5   6.68e-79 -0.598    -0.494  
    ## 3 age                -0.000729  0.000892    -0.817 4.14e- 1 -0.00248   0.00102
    ## 
    ## Model summaries:
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
    ##  [1] pillar_1.5.1      compiler_4.0.4    base64enc_0.1-3   tools_4.0.4      
    ##  [5] digest_0.6.27     jsonlite_1.7.2    evaluate_0.14     lifecycle_1.0.0  
    ##  [9] tibble_3.1.0      pkgconfig_2.0.3   rlang_0.4.10      cli_2.3.1        
    ## [13] DBI_1.1.1         rstudioapi_0.13   yaml_2.2.1        xfun_0.22        
    ## [17] repr_1.1.3        withr_2.4.1       stringr_1.4.0     dplyr_1.0.5      
    ## [21] knitr_1.31        generics_0.1.0    vctrs_0.3.6       hms_1.0.0        
    ## [25] tidyselect_1.1.0  glue_1.4.2        R6_2.5.0          fansi_0.4.2      
    ## [29] rmarkdown_2.7     readr_1.4.0       purrr_0.3.4       tidyr_1.1.3      
    ## [33] skimr_2.1.3       magrittr_2.0.1    MASS_7.3-53.1     backports_1.2.1  
    ## [37] ellipsis_0.3.1    htmltools_0.5.1.1 assertthat_0.2.1  utf8_1.2.1       
    ## [41] stringi_1.5.3     broom_0.7.5       crayon_1.4.1
