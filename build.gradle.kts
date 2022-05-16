/*
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

plugins {
    java
    id("com.github.johnrengelman.shadow") version "7.1.2"
}

group = "com.google.healthcare.simulator"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
    maven {
        // Required for Beam to resolve kafka dependency
        url = uri("https://packages.confluent.io/maven/")
    }
}

val appName = "simulator"
val packageName = group
val className = "Simulator"
val templateName = appName
val fullClassName = "$packageName.$className"

val autoValueVersion: String by project
val googleAuthVersion: String by project
val googleHealthcareApiVersion: String by project
val gsonVersion: String by project
val guavaVersion: String by project
val jupiterVersion: String by project
val slf4jVersion: String by project
val syntheaVersion: String by project

dependencies {
    implementation("com.google.guava:guava:$guavaVersion")
    implementation("com.google.code.gson:gson:$gsonVersion")
    implementation("org.slf4j:slf4j-simple:$slf4jVersion")
    implementation("org.mitre.synthea:synthea:$syntheaVersion")
    implementation("com.google.apis:google-api-services-healthcare:$googleHealthcareApiVersion")
    implementation("com.google.auth:google-auth-library-oauth2-http:$googleAuthVersion")
    testImplementation("org.junit.jupiter:junit-jupiter:$jupiterVersion")
    testRuntimeOnly("org.junit.jupiter:junit-jupiter-engine")
    compileOnly("com.google.auto.value:auto-value-annotations:$autoValueVersion")
    annotationProcessor("com.google.auto.value:auto-value:$autoValueVersion")
}

tasks.shadowJar {
    isZip64 = true
    manifest {
        attributes("Main-Class" to fullClassName)
    }
    archiveVersion.set("latest")
    mergeServiceFiles()
}
