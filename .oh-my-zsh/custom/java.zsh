export MVN_HOME="/usr/local/mvn/apache-maven-3.3.9"
export ANT_HOME="/usr/local/ant/apache-ant-1.9.6"
#export JAVA_HOME="/usr/lib/jvm/java-openjdk"
#export JAVA_HOME="/usr/lib/jvm/java"
export JAVA_HOME="/usr/java/default"
export JDK_HOME="/usr/java/default"
export ECLIPSE_HOME="/home/xifeng/3rd/eclipse/jee-neon/eclipse"
export GRADLE_HOME="/usr/local/gradle/default/"

export IDEA_HOME="/usr/local/idea"


export PATH="$MVN_HOME/bin:$ANT_HOME/bin:$JAVA_HOME/bin:$ECLIPSE_HOME:$GRADLE_HOME/bin:${IDEA_HOME}/bin:$PATH"
alias idea="$HOME/3rd/idea &"
