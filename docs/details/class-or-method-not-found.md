# Class or method not found

When your compile-time class path differs from the runtime class path, you may encounter errors that signal that a class or method could not be found (e.g., NoClassDefFoundError, NoSuchMethodError).

```
java.lang.NoSuchMethodError: com.fasterxml.jackson.dataformat.avro.AvroTypeResolverBuilder.subTypeValidator(Lcom/fasterxml/jackson/databind/cfg/MapperConfig;)Lcom/fasterxml/jackson/databind/jsontype/PolymorphicTypeValidator;
    at com.fasterxml.jackson.dataformat.avro.AvroTypeResolverBuilder.buildTypeDeserializer(AvroTypeResolverBuilder.java:43)
    at com.fasterxml.jackson.databind.deser.BasicDeserializerFactory.findTypeDeserializer(BasicDeserializerFactory.java:1598)
    at com.fasterxml.jackson.databind.deser.BasicDeserializerFactory.findPropertyContentTypeDeserializer(BasicDeserializerFactory.java:1766)
    at com.fasterxml.jackson.databind.deser.BasicDeserializerFactory.resolveMemberAndTypeAnnotations(BasicDeserializerFactory.java:2092)
    at com.fasterxml.jackson.databind.deser.BasicDeserializerFactory.constructCreatorProperty(BasicDeserializerFactory.java:1069)
    at com.fasterxml.jackson.databind.deser.BasicDeserializerFactory._addExplicitPropertyCreator(BasicDeserializerFactory.java:703)
    at com.fasterxml.jackson.databind.deser.BasicDeserializerFactory._addDeserializerConstructors(BasicDeserializerFactory.java:476)
    ...
```

This may be due to packaging a fat JAR with dependency versions that are in conflict with those provided by the Spark environment. When there are multiple versions of the same library in the runtime class path under the same package, Java's class loader hierarchy kicks in, which can lead to unintended behaviors.

There are a few options to get around this.

1. Identify the version of the problematic library within your Spark environment and pin the dependency to that version in your build file. To identify the version used in your Spark environment, in the Spark UI go to the Environment tab, scroll down to Classpath Entries, and find the corresponding library.
2. Exclude the transient dependency of the problematic library from imported libraries in your build file.
3. Shade the problematic library under a different package.

If options (1) and (2) result in more dependency conflicts, it may be that the version of the problematic library in the Spark environment is incompatible with your application code. Therefore, it makes sense to shade the problematic library so that your application can run with a version of the library isolated from the rest of the Spark environment.

If you are using the [shadow plugin](https://github.com/johnrengelman/shadow) in Gradle, you can shade using:
```
shadowJar {
    ...
    relocate 'com.fasterxml.jackson', 'shaded.fasterxml.jackson'
}
```
In this example, Jackson libraries used by your application will be available in the `shaded.fasterxml.jackson` package at runtime.
