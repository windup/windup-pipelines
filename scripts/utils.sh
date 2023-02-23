#!/usr/bin/env bash

function setReleaseVersion() {
    mvn clean install -DskipTests -s $SETTINGS_XML
    mvn -B versions:set versions:commit -DnewVersion="$NEXT_VERSION" -DprocessAllModules
}

function release() {
    mvn verify \
    source:jar javadoc:jar \
    gpg:sign install:install deploy:deploy \
    -Dgpg.executable="$GPG_SCRIPT" \
    -DskipTests \
    -s $SETTINGS_XML \
    -gs /home/runner/.m2/settings.xml
}

function setNextDevelopmentVersion() {
    mvn -B versions:set versions:commit -DnewVersion="$NEXT_VERSION" -DprocessAllModules
    mvn clean install -DskipTests -s $SETTINGS_XML
}
