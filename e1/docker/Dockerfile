FROM ubuntu:16.04

RUN apt update -y &&      apt install -y wget build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncurses5-dev libncursesw5-dev xz-utils tk-dev rsyslog &&     dpkg --configure -a &&     cd /usr/src &&  \ 
    wget http://python.org/ftp/python/3.6.4/Python-3.6.4.tar.xz &&     tar xf Python-3.6.4.tar.xz && cd Python-3.6.4 &&      ./configure --enable-optimizations &&  \ 
    make altinstall &&      apt install -y python-pip &&  \ 
    python3.6 -m pip install requests &&  \ 
    python3.6 -m pip install pyowm 


COPY python_scripts /

CMD "/bin/bash"

ENTRYPOINT "/bin/bash" "/getweather"

