# Regular Expression Tips

Spark function `regexp_extract` and `regexp_replace` can transform data using regular expressions.
The regular expression pattern follows [Java regex pattern](https://docs.oracle.com/javase/8/docs/api/java/util/regex/Pattern.html).

## Task Running Very Slowly

Stack trace shows:

```
java.lang.Character.codePointAt(Character.java:4884)
java.util.regex.Pattern$CharProperty.match(Pattern.java:3789)
java.util.regex.Pattern$Curly.match1(Pattern.java:4307)
java.util.regex.Pattern$Curly.match(Pattern.java:4250)
java.util.regex.Pattern$GroupHead.match(Pattern.java:4672)
java.util.regex.Pattern$BmpCharProperty.match(Pattern.java:3812)
java.util.regex.Pattern$Curly.match0(Pattern.java:4286)
java.util.regex.Pattern$Curly.match(Pattern.java:4248)
java.util.regex.Pattern$BmpCharProperty.match(Pattern.java:3812)
java.util.regex.Pattern$Curly.match0(Pattern.java:4286)
java.util.regex.Pattern$Curly.match(Pattern.java:4248)
java.util.regex.Pattern$BmpCharProperty.match(Pattern.java:3812)
java.util.regex.Pattern$Curly.match0(Pattern.java:4286)
java.util.regex.Pattern$Curly.match(Pattern.java:4248)
java.util.regex.Pattern$BmpCharProperty.match(Pattern.java:3812)
java.util.regex.Pattern$Curly.match0(Pattern.java:4286)
java.util.regex.Pattern$Curly.match(Pattern.java:4248)
java.util.regex.Pattern$Start.match(Pattern.java:3475)
java.util.regex.Matcher.search(Matcher.java:1248)
java.util.regex.Matcher.find(Matcher.java:637)
org.apache.spark.sql.catalyst.expressions.GeneratedClass$SpecificUnsafeProjection.RegExpExtract_2$(Unknown Source)
```

Certain values in the dataset cause `regexp_extract` with a certain regex pattern to run very slowly.
See https://stackoverflow.com/questions/5011672/java-regular-expression-running-very-slow.

## Match Special Character in PySpark

You will need 4 backslashes to match any special character,
2 required by Python string escaping and 2 by Java regex parsing.

```
df = spark.sql("SELECT regexp_replace('{{template}}', '\\\\{\\\\{', '#')")
```
