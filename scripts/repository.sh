function setNextVersion_windupRulesets() {
  sed -i -e "s/<version.windup>.*<\/version.windup>/<version.windup>${NEXT_VERSION}<\/version.windup>/g" pom.xml
  git add pom.xml
}

function setNextVersion_windupDistribution() {
  sed -i -e "s/<version.windup>.*<\/version.windup>/<version.windup>${NEXT_VERSION}<\/version.windup>/g" pom.xml
  sed -i -e "s/<version.windup-rulesets>.*<\/version.windup-rulesets>/<version.windup-rulesets>${NEXT_VERSION}<\/version.windup-rulesets>/g" pom.xml
  git add pom.xml
}

function setNextVersion_windupWeb() {
  sed -i -e "s/<version.windup>.*<\/version.windup>/<version.windup>${NEXT_VERSION}<\/version.windup>/g" pom.xml
  sed -i -e "s/<version.windup.cli>.*<\/version.windup.cli>/<version.windup.cli>${NEXT_VERSION}<\/version.windup.cli>/g" pom.xml
  git add pom.xml

  sed -i -e "s/<version.windup.core>.*<\/version.windup.core>/<version.windup.core>${NEXT_VERSION}<\/version.windup.core>/g" tsmodelsgen-invocation/pom.xml
  sed -i -e "s/<version.windup.ruleset>.*<\/version.windup.ruleset>/<version.windup.ruleset>${NEXT_VERSION}<\/version.windup.ruleset>/g" tsmodelsgen-invocation/pom.xml
  git add tsmodelsgen-invocation/pom.xml

  sed -i -e "s/<version.windup.core>.*<\/version.windup.core>/<version.windup.core>${NEXT_VERSION}<\/version.windup.core>/g" tsmodelsgen-maven-plugin/pom.xml
  sed -i -e "s/<version.windup.ruleset>.*<\/version.windup.ruleset>/<version.windup.ruleset>${NEXT_VERSION}<\/version.windup.ruleset>/g" tsmodelsgen-maven-plugin/pom.xml
  git add tsmodelsgen-maven-plugin/pom.xml
}

function setNextVersion_windupOpenshift() {
  sed -i -e "s/<version.windup.cli>.*<\/version.windup.cli>/<version.windup.cli>${NEXT_VERSION}<\/version.windup.cli>/g" pom.xml
  sed -i -e "s/<version.windup.web>.*<\/version.windup.web>/<version.windup.web>${NEXT_VERSION}<\/version.windup.web>/g" pom.xml
  git add pom.xml
  
  git add templates/src/main/resources/web-template-empty-dir-executor.json
  git add templates/src/main/resources/web-template-empty-dir-executor-shared-storage.json
}

function setNextVersion_windupWebDistribution() {
  sed -i -e "s/<version.windup.web>.*<\/version.windup.web>/<version.windup.web>${NEXT_VERSION}<\/version.windup.web>/g" pom.xml
  sed -i -e "s/<version.windup.openshift>.*<\/version.windup.openshift>/<version.windup.openshift>${NEXT_VERSION}<\/version.windup.openshift>/g" pom.xml
  git add pom.xml
}

function setNextVersion_windupMavenPlugin() {
  sed -i -e "s/<version.windupcore>.*<\/version.windupcore>/<version.windupcore>${NEXT_VERSION}<\/version.windupcore>/g" pom.xml
  sed -i -e "s/<version.windup-rulesets>.*<\/version.windup-rulesets>/<version.windup-rulesets>${NEXT_VERSION}<\/version.windup-rulesets>/g" pom.xml
  git add pom.xml

  for theme in windup-plugin mta-plugin mtr-plugin
  do
  sed -i -e "s/<version.windupcore>.*<\/version.windupcore>/<version.windupcore>${NEXT_VERSION}<\/version.windupcore>/g" ${theme}/src/it/simple-it/pom.xml
  sed -i -e "s/<version>.*<\/version>/<version>${NEXT_VERSION}<\/version>/g" ${theme}/src/it/simple-it/pom.xml
  git add ${theme}/src/it/simple-it/pom.xml
  
  sed -i -e "s/<version>.*<\/version>/<version>${NEXT_VERSION}<\/version>/g" ${theme}/src/test/resources/mojoTestConfig.xml
  git add ${theme}/src/test/resources/mojoTestConfig.xml
  
  sed -i -e "s/assertEquals(mojo2.getWindupVersion(), \".*\");/assertEquals(mojo2.getWindupVersion(), \"${NEXT_VERSION}\");/g" ${theme}/src/test/java/org/jboss/windup/plugin/WindupMojoTest.java
  git add ${theme}/src/test/java/org/jboss/windup/plugin/WindupMojoTest.java
  done
  
  sed -i -e "s/<windupVersion>.*<\/windupVersion>/<windupVersion>${NEXT_VERSION}<\/windupVersion>/g" windup-plugin/src/test/resources/mojoTestConfigWithWindupVersion.xml
  git add windup-plugin/src/test/resources/mojoTestConfigWithWindupVersion.xml
}

function setNextVersion_windupQuickstarts() {
  MVN_VERSION=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec)
  find . -name pom.xml -exec sed -i -e "s/${MVN_VERSION}/${NEXT_VERSION}/g" {} \;
  git add \*.xml
}