#Coding-Question 1

filelist <- c('mallika_1.jpg', 'dog005.jpg', 'grandson_2018_01_01.png', 'dog008.jpg', 
              'mallika_6.jpg', 'grandson_2018_5_23.png', 'dog01.png', 'mallika_11.jpg', 
              'mallika2.jpg', 'grandson_2018_02_5.png', 'grandson_2019_08_23.jpg', 'dog9.jpg', 
              'mallika05.jpg' )


filenames <- data.frame(filelist)
View(filenames)

install.packages("naturalsort")
library(naturalsort)
Sorted_file <- naturalsort(filenames$filelist)
View(Sorted_file)

#Case Study-Question 2

library(sqldf)
library(dplyr)
#SQL Syntax- MySQL
#---1a-------------
sqldf("WITH CTE AS
      (SELECT USER_ID,MERCHANT_NAME,TRANSACTION_DATE,
      ROW_NUMBER() OVER(PARTITION BY USER_ID ORDER BY TRANSACTION_DATE) AS ROWNUM 
      FROM transactions)
      SELECT * FROM CTE WHERE ROWNUM=1")



#----1b-----------

sqldf("WITH CTE AS
      (SELECT *,WEEKDAY(TRANSACTION_DATE) AS Weekday,
      ROW_NUMBER() OVER(PARTITION BY USER_ID ORDER BY TRANSACTION_DATE) AS Rownum
      FROM transactions)
      SELECT MERCHANT_NAME,COUNT(USER_ID) FROM CTE
      WHERE Rownum=1 AND Weekday=0
      GROUP BY MERCHANT_NAME")   #Weekday 0=Monday, 1=Tuesday,......

#----2------------
sqldf("WITH CTE AS
      (SELECT TRANSACTION_ID,USER_ID,MERCHANT_NAME,TRANSACTION_DATE,AMOUNT,
      ROW_NUMBER() OVER(PARTITION BY USER_ID ORDER BY TRANSACTION_DATE) AS ROWNUM 
      FROM transactions)
      SELECT * FROM CTE WHERE ROWNUM%2=1")

#-----3-----------
sqldf("SELECT USER_ID,SUM(AMOUNT) AS TOTAL
      FROM transactions
      GROUP BY USER_ID
      ORDER BY TOTAL DESC
      TOP 25 PERCENT")


#------4-----------

sqldf("WITH CTE AS
      (SELECT USER_ID,TRANSACTION_ID,MERCHANT_NAME,TRANSACTION_DATE,
      LAG(TRANSACTION_DATE) OVER(PARTITION BY USER_ID ORDER BY TRANSACTION_DATE) AS DATE2,
      TRANSACTION_DATE - LAG(TRANSACTION_DATE) OVER(PARTITION BY USER_ID ORDER BY TRANSACTION_DATE) AS timeinDays
      FROM transactions)
      SELECT *,AVG(timeinDays) OVER(PARTITION BY USER_ID) AS Avgtimediff
      FROM CTE")


#------5----------



      
