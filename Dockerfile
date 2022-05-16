# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM gradle:jdk11 as builder
COPY . .
RUN ./gradlew shadowJar
RUN ls /home/gradle/build/libs/patient-population-simulator-latest-all.jar

FROM openjdk:11.0.15-jre
COPY --from=builder /home/gradle/build/libs/patient-population-simulator-latest-all.jar app.jar
ENTRYPOINT ["java", "-Djava.security.edg=file:/dev/./urandom","-jar","/app.jar"]