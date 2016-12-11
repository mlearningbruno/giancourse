# install the necessay tools for lab 4
# V1.01 12/12/2016 BP


# for lab 8
#cd amunmt
#mkdir build
#cd build
#cmake ..
#make -j 3
chmod +x /home/smt/Icon2016/labs/*.perl /home/smt/Icon2016/labs/*.pl /home/smt/Icon2016/labs/*.sh

if ! test -f ~/joshua/bin/lmplz; then
    cd ~/joshua
    export JOSHUA=$(pwd)
    # add this to your ~/.bashrc, too
    echo "export JOSHUA=$JOSHUA" >> ~/.bashrc
# compile Joshua, run tests, and build the jar file
#    mvn package
#    sudo apt-get install -y openjdk-8-jdk-headless
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
    echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> ~/.bashrc

  
    # Download dependencies used for building and running models
    bash download-deps.sh
fi

cd
if ! test -d parallel-corpora; then
    tar -xvzf indic-corpora.tar.gz
fi

if ! test -f ~/parallel-corpora/hi-en/trainMoses; then

  # Launch Moses training on one language:
  bash ~/Icon2016/labs/trainMoses.sh hi en
fi

