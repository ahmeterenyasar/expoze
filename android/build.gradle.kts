allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    pluginManager.withPlugin("com.android.library") {
        extensions.findByName("android")?.let { androidExt ->
            val extClass = androidExt.javaClass
            val getNamespace = extClass.methods.firstOrNull {
                it.name == "getNamespace" && it.parameterCount == 0
            }
            val setNamespace = extClass.methods.firstOrNull {
                it.name == "setNamespace" && it.parameterCount == 1
            }
            val currentNamespace = getNamespace?.invoke(androidExt) as? String
            if (currentNamespace.isNullOrBlank()) {
                // Fallback for old Android library dependencies that don't declare namespace.
                setNamespace?.invoke(
                    androidExt,
                    "dev.pub.${project.name.replace('-', '_')}",
                )
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
