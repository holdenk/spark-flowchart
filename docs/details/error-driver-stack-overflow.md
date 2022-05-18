#Driver ran out of memory

Note that it is very rare to run into this error. You may see this error when you are using too many filters(in your sql/dataframe/dataset). Workaround is to increase spark driver JVM stack size by setting below config to something higher than the default

* ```spark.driver.extraJavaOptions: "-Xss512M"```    #Sets the stack size to 512 MB