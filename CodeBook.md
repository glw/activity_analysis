run_analysis
========================================================

```r
sessionInfo()
```

```
## R version 3.1.0 (2014-04-10)
## Platform: i686-pc-linux-gnu (32-bit)
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
## [1] markdown_0.7 knitr_1.6    RMySQL_0.9-3 DBI_0.2-6   
## 
## loaded via a namespace (and not attached):
## [1] evaluate_0.5.5 formatR_0.10   httr_0.3       RCurl_1.95-4.1
## [5] stringr_0.6.2  tools_3.1.0
```

This script is for the Coursera course "Getting and Cleaning Data"

Please see readme.md and codebook.md for further details

Created by Garret Wais https://github.com/glw/activity_analysis


# Part 1 of 2 - Download and extract data.

### Large file to be downloaded into a temporary folder within users computer and unzipped into ./data folder


```r
fileurl = "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
```

### create temporary directory to hold temporary file


```r
tempdir = tempdir()
```
 
### create temporary zip file


```r
temp <- tempfile(tmpdir = tempdir, fileext = ".zip")
```

### download file into temp folder


```r
download.file(fileurl, destfile = temp, method = "curl")
```

### create a list of files within zip


```r
files <- unzip(temp, list=TRUE)
files
```

```
##                                                            Name   Length
## 1                           UCI HAR Dataset/activity_labels.txt       80
## 2                                  UCI HAR Dataset/features.txt    15785
## 3                             UCI HAR Dataset/features_info.txt     2809
## 4                                    UCI HAR Dataset/README.txt     4453
## 5                                         UCI HAR Dataset/test/        0
## 6                        UCI HAR Dataset/test/Inertial Signals/        0
## 7     UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt  6041350
## 8     UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt  6041350
## 9     UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt  6041350
## 10   UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt  6041350
## 11   UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt  6041350
## 12   UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt  6041350
## 13   UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt  6041350
## 14   UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt  6041350
## 15   UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt  6041350
## 16                        UCI HAR Dataset/test/subject_test.txt     7934
## 17                              UCI HAR Dataset/test/X_test.txt 26458166
## 18                              UCI HAR Dataset/test/y_test.txt     5894
## 19                                       UCI HAR Dataset/train/        0
## 20                      UCI HAR Dataset/train/Inertial Signals/        0
## 21  UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt 15071600
## 22  UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt 15071600
## 23  UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt 15071600
## 24 UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt 15071600
## 25 UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt 15071600
## 26 UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt 15071600
## 27 UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt 15071600
## 28 UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt 15071600
## 29 UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt 15071600
## 30                      UCI HAR Dataset/train/subject_train.txt    20152
## 31                            UCI HAR Dataset/train/X_train.txt 66006256
## 32                            UCI HAR Dataset/train/y_train.txt    14704
##                   Date
## 1  2012-10-10 15:55:00
## 2  2012-10-11 13:41:00
## 3  2012-10-15 15:44:00
## 4  2012-12-10 10:38:00
## 5  2012-11-29 17:01:00
## 6  2012-11-29 17:01:00
## 7  2012-11-29 15:08:00
## 8  2012-11-29 15:08:00
## 9  2012-11-29 15:08:00
## 10 2012-11-29 15:09:00
## 11 2012-11-29 15:09:00
## 12 2012-11-29 15:09:00
## 13 2012-11-29 15:08:00
## 14 2012-11-29 15:09:00
## 15 2012-11-29 15:09:00
## 16 2012-11-29 15:09:00
## 17 2012-11-29 15:25:00
## 18 2012-11-29 15:09:00
## 19 2012-11-29 17:01:00
## 20 2012-11-29 17:01:00
## 21 2012-11-29 15:08:00
## 22 2012-11-29 15:08:00
## 23 2012-11-29 15:08:00
## 24 2012-11-29 15:09:00
## 25 2012-11-29 15:09:00
## 26 2012-11-29 15:09:00
## 27 2012-11-29 15:08:00
## 28 2012-11-29 15:08:00
## 29 2012-11-29 15:08:00
## 30 2012-11-29 15:09:00
## 31 2012-11-29 15:25:00
## 32 2012-11-29 15:09:00
```

### if data folder does not exist within the working directory create it, in current working directory.


```r
if (!file.exists("data")){dir.create("data")}
```

### Unzip contents into new data folder within working directory


```r
unzip(temp, exdir = "./data", overwrite = TRUE)
```

### unlink temporary files and directory

```r
unlink(temp)
unlink(tempdir)
```

# Part 2 of 2 - Read data and merge test and training sets

    Read tables

```r
ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = F)
xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = F)
xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = F)
ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = F)
subjtrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = F)
colnames(sub)
```

```
## NULL
```

```r
subjtest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = F)
features <- read.table("./data/UCI HAR Dataset/features.txt", header = F)
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = F)
```

    Merging datasets

```r
X.df <- rbind(xtest, xtrain)

Y.df <- rbind(ytest, ytrain)

Subj.df <- rbind(subjtest, subjtrain)
```

    Keep Columns with "-mean" or "-std"

```r
keep_feat <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
```

    User activities to label Y.df

```r
Y.df[,1] = activities[Y.df[,1], 2]
names(Y.df) <- "activity"
```

    Subset X.df with keep_feat and label columns *Used* headers from features to label Final tidy dataset headers 

```r
X.df <- X.df[, keep_feat]
names(X.df) <- features[keep_feat, 2]
names(X.df) <- gsub("\\(|\\)", "", names(X.df))
```

    Bind data sets and eport to tidy data file

```r
names(Subj.df) <- "Subject"
final_set <- cbind(Subj.df, Y.df, X.df)
write.table(final_set, "tidy_dataset.txt")
```

    Summary: tidy_dataset.txt

```r
tidy <- read.table("tidy_dataset.txt")
summary(tidy)
```

```
##     Subject                   activity    tBodyAcc.mean.X 
##  Min.   : 1.0   LAYING            :1944   Min.   :-1.000  
##  1st Qu.: 9.0   SITTING           :1777   1st Qu.: 0.263  
##  Median :17.0   STANDING          :1906   Median : 0.277  
##  Mean   :16.1   WALKING           :1722   Mean   : 0.274  
##  3rd Qu.:24.0   WALKING_DOWNSTAIRS:1406   3rd Qu.: 0.288  
##  Max.   :30.0   WALKING_UPSTAIRS  :1544   Max.   : 1.000  
##  tBodyAcc.mean.Y   tBodyAcc.mean.Z   tBodyAcc.std.X   tBodyAcc.std.Y   
##  Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.000   Min.   :-1.0000  
##  1st Qu.:-0.0249   1st Qu.:-0.1210   1st Qu.:-0.992   1st Qu.:-0.9770  
##  Median :-0.0172   Median :-0.1086   Median :-0.943   Median :-0.8350  
##  Mean   :-0.0177   Mean   :-0.1089   Mean   :-0.608   Mean   :-0.5102  
##  3rd Qu.:-0.0106   3rd Qu.:-0.0976   3rd Qu.:-0.250   3rd Qu.:-0.0573  
##  Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.000   Max.   : 1.0000  
##  tBodyAcc.std.Z   tGravityAcc.mean.X tGravityAcc.mean.Y tGravityAcc.mean.Z
##  Min.   :-1.000   Min.   :-1.000     Min.   :-1.000     Min.   :-1.0000   
##  1st Qu.:-0.979   1st Qu.: 0.812     1st Qu.:-0.243     1st Qu.:-0.1167   
##  Median :-0.851   Median : 0.922     Median :-0.144     Median : 0.0368   
##  Mean   :-0.613   Mean   : 0.669     Mean   : 0.004     Mean   : 0.0922   
##  3rd Qu.:-0.279   3rd Qu.: 0.955     3rd Qu.: 0.119     3rd Qu.: 0.2162   
##  Max.   : 1.000   Max.   : 1.000     Max.   : 1.000     Max.   : 1.0000   
##  tGravityAcc.std.X tGravityAcc.std.Y tGravityAcc.std.Z tBodyAccJerk.mean.X
##  Min.   :-1.000    Min.   :-1.000    Min.   :-1.000    Min.   :-1.0000    
##  1st Qu.:-0.995    1st Qu.:-0.991    1st Qu.:-0.987    1st Qu.: 0.0630    
##  Median :-0.982    Median :-0.976    Median :-0.967    Median : 0.0760    
##  Mean   :-0.965    Mean   :-0.954    Mean   :-0.939    Mean   : 0.0789    
##  3rd Qu.:-0.962    3rd Qu.:-0.946    3rd Qu.:-0.930    3rd Qu.: 0.0913    
##  Max.   : 1.000    Max.   : 1.000    Max.   : 1.000    Max.   : 1.0000    
##  tBodyAccJerk.mean.Y tBodyAccJerk.mean.Z tBodyAccJerk.std.X
##  Min.   :-1.0000     Min.   :-1.0000     Min.   :-1.000    
##  1st Qu.:-0.0186     1st Qu.:-0.0316     1st Qu.:-0.991    
##  Median : 0.0108     Median :-0.0012     Median :-0.951    
##  Mean   : 0.0079     Mean   :-0.0047     Mean   :-0.640    
##  3rd Qu.: 0.0335     3rd Qu.: 0.0246     3rd Qu.:-0.291    
##  Max.   : 1.0000     Max.   : 1.0000     Max.   : 1.000    
##  tBodyAccJerk.std.Y tBodyAccJerk.std.Z tBodyGyro.mean.X  tBodyGyro.mean.Y 
##  Min.   :-1.000     Min.   :-1.000     Min.   :-1.0000   Min.   :-1.0000  
##  1st Qu.:-0.985     1st Qu.:-0.989     1st Qu.:-0.0458   1st Qu.:-0.1040  
##  Median :-0.925     Median :-0.954     Median :-0.0278   Median :-0.0748  
##  Mean   :-0.608     Mean   :-0.763     Mean   :-0.0310   Mean   :-0.0747  
##  3rd Qu.:-0.222     3rd Qu.:-0.548     3rd Qu.:-0.0106   3rd Qu.:-0.0511  
##  Max.   : 1.000     Max.   : 1.000     Max.   : 1.0000   Max.   : 1.0000  
##  tBodyGyro.mean.Z  tBodyGyro.std.X  tBodyGyro.std.Y  tBodyGyro.std.Z 
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.: 0.0648   1st Qu.:-0.987   1st Qu.:-0.982   1st Qu.:-0.985  
##  Median : 0.0863   Median :-0.902   Median :-0.911   Median :-0.882  
##  Mean   : 0.0884   Mean   :-0.721   Mean   :-0.683   Mean   :-0.654  
##  3rd Qu.: 0.1104   3rd Qu.:-0.482   3rd Qu.:-0.446   3rd Qu.:-0.338  
##  Max.   : 1.0000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##  tBodyGyroJerk.mean.X tBodyGyroJerk.mean.Y tBodyGyroJerk.mean.Z
##  Min.   :-1.0000      Min.   :-1.0000      Min.   :-1.0000     
##  1st Qu.:-0.1172      1st Qu.:-0.0587      1st Qu.:-0.0794     
##  Median :-0.0982      Median :-0.0406      Median :-0.0546     
##  Mean   :-0.0967      Mean   :-0.0423      Mean   :-0.0548     
##  3rd Qu.:-0.0793      3rd Qu.:-0.0252      3rd Qu.:-0.0317     
##  Max.   : 1.0000      Max.   : 1.0000      Max.   : 1.0000     
##  tBodyGyroJerk.std.X tBodyGyroJerk.std.Y tBodyGyroJerk.std.Z
##  Min.   :-1.000      Min.   :-1.000      Min.   :-1.000     
##  1st Qu.:-0.991      1st Qu.:-0.992      1st Qu.:-0.993     
##  Median :-0.935      Median :-0.955      Median :-0.950     
##  Mean   :-0.731      Mean   :-0.786      Mean   :-0.740     
##  3rd Qu.:-0.486      3rd Qu.:-0.627      3rd Qu.:-0.510     
##  Max.   : 1.000      Max.   : 1.000      Max.   : 1.000     
##  tBodyAccMag.mean tBodyAccMag.std  tGravityAccMag.mean tGravityAccMag.std
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000      Min.   :-1.000    
##  1st Qu.:-0.982   1st Qu.:-0.982   1st Qu.:-0.982      1st Qu.:-0.982    
##  Median :-0.875   Median :-0.844   Median :-0.875      Median :-0.844    
##  Mean   :-0.548   Mean   :-0.591   Mean   :-0.548      Mean   :-0.591    
##  3rd Qu.:-0.120   3rd Qu.:-0.242   3rd Qu.:-0.120      3rd Qu.:-0.242    
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000      Max.   : 1.000    
##  tBodyAccJerkMag.mean tBodyAccJerkMag.std tBodyGyroMag.mean
##  Min.   :-1.000       Min.   :-1.000      Min.   :-1.000   
##  1st Qu.:-0.990       1st Qu.:-0.991      1st Qu.:-0.978   
##  Median :-0.948       Median :-0.929      Median :-0.822   
##  Mean   :-0.649       Mean   :-0.628      Mean   :-0.605   
##  3rd Qu.:-0.296       3rd Qu.:-0.273      3rd Qu.:-0.245   
##  Max.   : 1.000       Max.   : 1.000      Max.   : 1.000   
##  tBodyGyroMag.std tBodyGyroJerkMag.mean tBodyGyroJerkMag.std
##  Min.   :-1.000   Min.   :-1.000        Min.   :-1.000      
##  1st Qu.:-0.978   1st Qu.:-0.992        1st Qu.:-0.992      
##  Median :-0.826   Median :-0.956        Median :-0.940      
##  Mean   :-0.662   Mean   :-0.762        Mean   :-0.778      
##  3rd Qu.:-0.394   3rd Qu.:-0.550        3rd Qu.:-0.609      
##  Max.   : 1.000   Max.   : 1.000        Max.   : 1.000      
##  fBodyAcc.mean.X  fBodyAcc.mean.Y  fBodyAcc.mean.Z  fBodyAcc.std.X  
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.991   1st Qu.:-0.979   1st Qu.:-0.983   1st Qu.:-0.993  
##  Median :-0.946   Median :-0.864   Median :-0.895   Median :-0.942  
##  Mean   :-0.623   Mean   :-0.537   Mean   :-0.665   Mean   :-0.603  
##  3rd Qu.:-0.265   3rd Qu.:-0.103   3rd Qu.:-0.366   3rd Qu.:-0.249  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##  fBodyAcc.std.Y    fBodyAcc.std.Z   fBodyAccJerk.mean.X
##  Min.   :-1.0000   Min.   :-1.000   Min.   :-1.000     
##  1st Qu.:-0.9769   1st Qu.:-0.978   1st Qu.:-0.991     
##  Median :-0.8326   Median :-0.840   Median :-0.952     
##  Mean   :-0.5284   Mean   :-0.618   Mean   :-0.657     
##  3rd Qu.:-0.0922   3rd Qu.:-0.302   3rd Qu.:-0.327     
##  Max.   : 1.0000   Max.   : 1.000   Max.   : 1.000     
##  fBodyAccJerk.mean.Y fBodyAccJerk.mean.Z fBodyAccJerk.std.X
##  Min.   :-1.000      Min.   :-1.000      Min.   :-1.000    
##  1st Qu.:-0.985      1st Qu.:-0.987      1st Qu.:-0.992    
##  Median :-0.926      Median :-0.948      Median :-0.956    
##  Mean   :-0.629      Mean   :-0.744      Mean   :-0.655    
##  3rd Qu.:-0.264      3rd Qu.:-0.513      3rd Qu.:-0.320    
##  Max.   : 1.000      Max.   : 1.000      Max.   : 1.000    
##  fBodyAccJerk.std.Y fBodyAccJerk.std.Z fBodyGyro.mean.X fBodyGyro.mean.Y
##  Min.   :-1.000     Min.   :-1.000     Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.987     1st Qu.:-0.990     1st Qu.:-0.985   1st Qu.:-0.985  
##  Median :-0.928     Median :-0.959     Median :-0.892   Median :-0.920  
##  Mean   :-0.612     Mean   :-0.781     Mean   :-0.672   Mean   :-0.706  
##  3rd Qu.:-0.236     3rd Qu.:-0.590     3rd Qu.:-0.384   3rd Qu.:-0.473  
##  Max.   : 1.000     Max.   : 1.000     Max.   : 1.000   Max.   : 1.000  
##  fBodyGyro.mean.Z fBodyGyro.std.X  fBodyGyro.std.Y  fBodyGyro.std.Z 
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000   Min.   :-1.000  
##  1st Qu.:-0.985   1st Qu.:-0.988   1st Qu.:-0.981   1st Qu.:-0.986  
##  Median :-0.888   Median :-0.905   Median :-0.906   Median :-0.891  
##  Mean   :-0.644   Mean   :-0.739   Mean   :-0.674   Mean   :-0.690  
##  3rd Qu.:-0.323   3rd Qu.:-0.522   3rd Qu.:-0.439   3rd Qu.:-0.417  
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000   Max.   : 1.000  
##  fBodyAccMag.mean fBodyAccMag.std  fBodyBodyAccJerkMag.mean
##  Min.   :-1.000   Min.   :-1.000   Min.   :-1.000          
##  1st Qu.:-0.985   1st Qu.:-0.983   1st Qu.:-0.990          
##  Median :-0.875   Median :-0.855   Median :-0.929          
##  Mean   :-0.586   Mean   :-0.659   Mean   :-0.621          
##  3rd Qu.:-0.217   3rd Qu.:-0.382   3rd Qu.:-0.260          
##  Max.   : 1.000   Max.   : 1.000   Max.   : 1.000          
##  fBodyBodyAccJerkMag.std fBodyBodyGyroMag.mean fBodyBodyGyroMag.std
##  Min.   :-1.000          Min.   :-1.000        Min.   :-1.000      
##  1st Qu.:-0.991          1st Qu.:-0.983        1st Qu.:-0.978      
##  Median :-0.925          Median :-0.876        Median :-0.828      
##  Mean   :-0.640          Mean   :-0.697        Mean   :-0.700      
##  3rd Qu.:-0.308          3rd Qu.:-0.451        3rd Qu.:-0.471      
##  Max.   : 1.000          Max.   : 1.000        Max.   : 1.000      
##  fBodyBodyGyroJerkMag.mean fBodyBodyGyroJerkMag.std
##  Min.   :-1.000            Min.   :-1.000          
##  1st Qu.:-0.992            1st Qu.:-0.993          
##  Median :-0.945            Median :-0.938          
##  Mean   :-0.780            Mean   :-0.792          
##  3rd Qu.:-0.612            3rd Qu.:-0.644          
##  Max.   : 1.000            Max.   : 1.000
```

    Head: tidy_dataset.txt

```r
head(tidy)
```

```
##   Subject activity tBodyAcc.mean.X tBodyAcc.mean.Y tBodyAcc.mean.Z
## 1       2 STANDING          0.2572        -0.02329        -0.01465
## 2       2 STANDING          0.2860        -0.01316        -0.11908
## 3       2 STANDING          0.2755        -0.02605        -0.11815
## 4       2 STANDING          0.2703        -0.03261        -0.11752
## 5       2 STANDING          0.2748        -0.02785        -0.12953
## 6       2 STANDING          0.2792        -0.01862        -0.11390
##   tBodyAcc.std.X tBodyAcc.std.Y tBodyAcc.std.Z tGravityAcc.mean.X
## 1        -0.9384        -0.9201        -0.6677             0.9365
## 2        -0.9754        -0.9675        -0.9450             0.9274
## 3        -0.9938        -0.9699        -0.9627             0.9299
## 4        -0.9947        -0.9733        -0.9671             0.9289
## 5        -0.9939        -0.9674        -0.9783             0.9266
## 6        -0.9945        -0.9704        -0.9653             0.9257
##   tGravityAcc.mean.Y tGravityAcc.mean.Z tGravityAcc.std.X
## 1            -0.2827             0.1153           -0.9254
## 2            -0.2892             0.1526           -0.9891
## 3            -0.2875             0.1461           -0.9959
## 4            -0.2934             0.1429           -0.9931
## 5            -0.3030             0.1383           -0.9956
## 6            -0.3089             0.1306           -0.9988
##   tGravityAcc.std.Y tGravityAcc.std.Z tBodyAccJerk.mean.X
## 1           -0.9370           -0.5643             0.07205
## 2           -0.9839           -0.9648             0.07018
## 3           -0.9883           -0.9816             0.06937
## 4           -0.9704           -0.9916             0.07485
## 5           -0.9710           -0.9681             0.07838
## 6           -0.9907           -0.9712             0.07598
##   tBodyAccJerk.mean.Y tBodyAccJerk.mean.Z tBodyAccJerk.std.X
## 1            0.045754           -0.106043            -0.9067
## 2           -0.017876           -0.001721            -0.9492
## 3           -0.004908           -0.013673            -0.9911
## 4            0.032274            0.012141            -0.9908
## 5            0.022277            0.002748            -0.9921
## 6            0.017519            0.008208            -0.9938
##   tBodyAccJerk.std.Y tBodyAccJerk.std.Z tBodyGyro.mean.X tBodyGyro.mean.Y
## 1            -0.9380            -0.9359         0.119976         -0.09179
## 2            -0.9727            -0.9777        -0.001552         -0.18729
## 3            -0.9714            -0.9729        -0.048213         -0.16628
## 4            -0.9729            -0.9759        -0.056642         -0.12602
## 5            -0.9787            -0.9866        -0.059992         -0.08472
## 6            -0.9791            -0.9876        -0.039698         -0.06683
##   tBodyGyro.mean.Z tBodyGyro.std.X tBodyGyro.std.Y tBodyGyro.std.Z
## 1          0.18963         -0.8831         -0.8162         -0.9409
## 2          0.18071         -0.9256         -0.9296         -0.9676
## 3          0.15417         -0.9730         -0.9785         -0.9756
## 4          0.11834         -0.9678         -0.9751         -0.9632
## 5          0.07866         -0.9747         -0.9780         -0.9676
## 6          0.07055         -0.9799         -0.9765         -0.9635
##   tBodyGyroJerk.mean.X tBodyGyroJerk.mean.Y tBodyGyroJerk.mean.Z
## 1             -0.20490             -0.17449             -0.09339
## 2             -0.13867             -0.02580             -0.07142
## 3             -0.09781             -0.03421             -0.06003
## 4             -0.10223             -0.04471             -0.05344
## 5             -0.09185             -0.02901             -0.06124
## 6             -0.09274             -0.03214             -0.07258
##   tBodyGyroJerk.std.X tBodyGyroJerk.std.Y tBodyGyroJerk.std.Z
## 1             -0.9012             -0.9109             -0.9393
## 2             -0.9623             -0.9563             -0.9813
## 3             -0.9842             -0.9879             -0.9762
## 4             -0.9842             -0.9896             -0.9807
## 5             -0.9885             -0.9919             -0.9820
## 6             -0.9894             -0.9895             -0.9778
##   tBodyAccMag.mean tBodyAccMag.std tGravityAccMag.mean tGravityAccMag.std
## 1          -0.8669         -0.7052             -0.8669            -0.7052
## 2          -0.9690         -0.9539             -0.9690            -0.9539
## 3          -0.9762         -0.9791             -0.9762            -0.9791
## 4          -0.9743         -0.9770             -0.9743            -0.9770
## 5          -0.9758         -0.9769             -0.9758            -0.9769
## 6          -0.9817         -0.9777             -0.9817            -0.9777
##   tBodyAccJerkMag.mean tBodyAccJerkMag.std tBodyGyroMag.mean
## 1              -0.9298             -0.8960           -0.7955
## 2              -0.9737             -0.9410           -0.8984
## 3              -0.9816             -0.9714           -0.9392
## 4              -0.9827             -0.9748           -0.9472
## 5              -0.9869             -0.9889           -0.9574
## 6              -0.9873             -0.9920           -0.9697
##   tBodyGyroMag.std tBodyGyroJerkMag.mean tBodyGyroJerkMag.std
## 1          -0.7621               -0.9252              -0.8943
## 2          -0.9109               -0.9734              -0.9441
## 3          -0.9718               -0.9867              -0.9844
## 4          -0.9704               -0.9888              -0.9856
## 5          -0.9695               -0.9901              -0.9904
## 6          -0.9733               -0.9878              -0.9890
##   fBodyAcc.mean.X fBodyAcc.mean.Y fBodyAcc.mean.Z fBodyAcc.std.X
## 1         -0.9185         -0.9182         -0.7891        -0.9483
## 2         -0.9609         -0.9644         -0.9567        -0.9843
## 3         -0.9919         -0.9650         -0.9669        -0.9948
## 4         -0.9930         -0.9683         -0.9669        -0.9956
## 5         -0.9924         -0.9692         -0.9797        -0.9945
## 6         -0.9938         -0.9707         -0.9756        -0.9946
##   fBodyAcc.std.Y fBodyAcc.std.Z fBodyAccJerk.mean.X fBodyAccJerk.mean.Y
## 1        -0.9251        -0.6363             -0.8996             -0.9375
## 2        -0.9702        -0.9419             -0.9435             -0.9692
## 3        -0.9737        -0.9623             -0.9910             -0.9734
## 4        -0.9769        -0.9690             -0.9905             -0.9725
## 5        -0.9675        -0.9782             -0.9915             -0.9798
## 6        -0.9710        -0.9614             -0.9938             -0.9790
##   fBodyAccJerk.mean.Z fBodyAccJerk.std.X fBodyAccJerk.std.Y
## 1             -0.9236            -0.9244            -0.9432
## 2             -0.9734            -0.9616            -0.9800
## 3             -0.9717            -0.9919            -0.9710
## 4             -0.9703            -0.9920            -0.9754
## 5             -0.9835            -0.9936            -0.9787
## 6             -0.9861            -0.9945            -0.9808
##   fBodyAccJerk.std.Z fBodyGyro.mean.X fBodyGyro.mean.Y fBodyGyro.mean.Z
## 1            -0.9479          -0.8236          -0.8079          -0.9179
## 2            -0.9808          -0.9225          -0.9265          -0.9682
## 3            -0.9723          -0.9728          -0.9808          -0.9721
## 4            -0.9806          -0.9715          -0.9813          -0.9667
## 5            -0.9885          -0.9764          -0.9804          -0.9688
## 6            -0.9876          -0.9797          -0.9805          -0.9602
##   fBodyGyro.std.X fBodyGyro.std.Y fBodyGyro.std.Z fBodyAccMag.mean
## 1         -0.9033         -0.8227         -0.9562          -0.7909
## 2         -0.9271         -0.9320         -0.9701          -0.9541
## 3         -0.9732         -0.9772         -0.9791          -0.9756
## 4         -0.9672         -0.9719         -0.9653          -0.9734
## 5         -0.9744         -0.9766         -0.9700          -0.9777
## 6         -0.9800         -0.9742         -0.9678          -0.9780
##   fBodyAccMag.std fBodyBodyAccJerkMag.mean fBodyBodyAccJerkMag.std
## 1         -0.7111                  -0.8951                 -0.8964
## 2         -0.9597                  -0.9454                 -0.9342
## 3         -0.9838                  -0.9711                 -0.9703
## 4         -0.9821                  -0.9717                 -0.9785
## 5         -0.9788                  -0.9875                 -0.9897
## 6         -0.9799                  -0.9913                 -0.9917
##   fBodyBodyGyroMag.mean fBodyBodyGyroMag.std fBodyBodyGyroJerkMag.mean
## 1               -0.7706              -0.7971                   -0.8902
## 2               -0.9245              -0.9168                   -0.9520
## 3               -0.9752              -0.9740                   -0.9857
## 4               -0.9763              -0.9712                   -0.9856
## 5               -0.9770              -0.9696                   -0.9905
## 6               -0.9770              -0.9751                   -0.9887
##   fBodyBodyGyroJerkMag.std
## 1                  -0.9073
## 2                  -0.9382
## 3                  -0.9833
## 4                  -0.9858
## 5                  -0.9906
## 6                  -0.9898
```

# Make codebook.
  **Data in this dataset has been divided by its range, normalizing the dataset, ie. it has no units.**
  
  CodeBook.md has been produced...
