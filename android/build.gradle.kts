// buildscript {
//     ext.kotlin_version = "1.9.0"
//     ext.android_gradle_plugin_version = "8.1.2" // Compatible with Flutter
//     ext.google_services_version = "4.3.15"
//     ext.firebase_crashlytics_version = "2.10.1"
//     ext.firebase_perf_version = "1.5.4"

//     repositories {
//         google()
//         mavenCentral()
//     }

//     dependencies {
//         classpath("com.android.tools.build:gradle:$androidGradlePluginVersion")
//         classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
//         classpath("com.google.gms:google-services:$googleServicesVersion")
//         classpath("com.google.firebase:firebase-crashlytics-gradle:$firebaseCrashlyticsVersion")
//         classpath("com.google.firebase:perf-plugin:$firebasePerfVersion")
//     }
// }

// allprojects {
//     buildDir = "../build"
//     subprojects {
//         buildDir = "${rootProject.buildDir}/${project.name}"
//         evaluationDependsOn(":app")

//         afterEvaluate {
//             if (project.plugins.hasPlugin("com.android.application") || project.plugins.hasPlugin("com.android.library")) {
//                 android {
//                     compileSdkVersion(33) // Replace 33 with the desired SDK version
//                 }
//             }
//         }
//     }

//     // Ensure the Flutter plugin is applied
//     plugins.apply("com.android.application")
//     plugins.apply("org.jetbrains.kotlin.android")
//     plugins.apply("com.google.gms.google-services")
// }

//     repositories {
//         google()
//         mavenCentral()
//     }

// task clean(type: Delete) {
//     delete rootProject.buildDir
// }


buildscript {
    ext {
        kotlin_version = "1.9.24"
        android_gradle_plugin_version = "8.5.2"
        google_services_version = "4.4.2"
        firebase_crashlytics_version = "3.0.2"
        firebase_perf_version = "1.5.6"
    }

    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:${ext.android_gradle_plugin_version}")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:${ext.kotlin_version}")
        classpath("com.google.gms:google-services:${ext.google_services_version}")
        classpath("com.google.firebase:firebase-crashlytics-gradle:${ext.firebase_crashlytics_version}")
        classpath("com.google.firebase:perf-plugin:${ext.firebase_perf_version}")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}