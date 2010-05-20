# Java Classpath
for jar in $HOME/.classpath/*.jar; do
	munge CLASSPATH "$jar"
done
export CLASSPATH
