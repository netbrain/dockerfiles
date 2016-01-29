FROM netbrain/go

RUN sudo apt-get update 
RUN sudo apt-get install -y wget unzip libxext6 libxrender1 libxtst6 

WORKDIR $TOOLS_PATH

#IDEA
RUN wget --progress=bar:force --no-check-certificate --no-cookies https://download.jetbrains.com/idea/ideaIC-15.0.2.tar.gz
RUN tar xzvf ideaIC-15.0.2.tar.gz
ENV PATH $PATH:$TOOLS_PATH/idea-IC-143.1184.17/bin

#JAVA
RUN wget --progress=bar:force --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz
RUN tar xzvf jdk-7u79-linux-x64.tar.gz
RUN rm jdk-7u79-linux-x64.tar.gz
ENV JAVA_HOME $TOOLS_PATH/jdk1.7.0_79
ENV PATH $PATH:$JAVA_HOME/bin

#Install GO plugin
RUN mkdir -p $HOME/.IdeaIC15/config/plugins
RUN wget \
	--trust-server-names  \
	--progress=bar:force \
	--no-check-certificate \
	--no-cookies \
	"https://plugins.jetbrains.com/plugin/download?pr=&updateId=22602"
RUN ls -1 Go*.zip | head -n 1 | xargs unzip -d $HOME/.IdeaIC15/config/plugins

WORKDIR $HOME

CMD $TOOLS_PATH/idea-IC-143.1184.17/bin/idea.sh

