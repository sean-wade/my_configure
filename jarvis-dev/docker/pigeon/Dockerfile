FROM ubuntu:focal

# Setup environment
WORKDIR /root
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Change APT server
RUN echo "deb http://nexus.cambricon.com/repository/ubuntu-ports focal main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://nexus.cambricon.com/repository/ubuntu-ports focal-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://nexus.cambricon.com/repository/ubuntu-ports focal-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://nexus.cambricon.com/repository/ubuntu-ports focal-security main restricted universe multiverse" >> /etc/apt/sources.list \

# Setup timezone
RUN echo "Asia/Shanghai" > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    apt-get update && \
    apt-get install -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# Install OpenSSH
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server && \
    rm -rf /var/lib/apt/lists/* && \
    sed -i "s/#Port 22/Port 30022/g" /etc/ssh/sshd_config && \
    sed -i "s/^#\(PermitRootLogin\)/\1/" /etc/ssh/sshd_config && \
    sed -i "s/^#\(PubkeyAuthentication\)/\1/" /etc/ssh/sshd_config && \
    sed -i "s/#X11UseLocalhost yes/X11UseLocalhost no/g" /etc/ssh/sshd_config && \
    sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config

# Change to ZSH
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl git git-lfs gnupg2 zsh && \
    rm -rf /var/lib/apt/lists/* && \
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    sed -i "s/robbyrussell/ys/g" /root/.zshrc && \
    sed -i "s/^# \(DISABLE_AUTO_UPDATE\)/\1/" /root/.zshrc && \
    chsh -s /bin/zsh

# Install ROS
RUN echo "deb http://nexus.cambricon.com/repository/ubuntu-ros focal main" > /etc/apt/sources.list.d/ros1-latest.list && \
    apt-key adv --fetch-keys https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        ros-noetic-desktop-full \
        ros-noetic-plotjuggler-ros && \
    rm -rf /var/lib/apt/lists/* && \
    echo "\nsource /opt/ros/noetic/setup.zsh" >> /root/.zshrc

# Install NodeJS
RUN echo "deb http://nexus.cambricon.com/repository/ubuntu-nodejs focal main" > /etc/apt/sources.list.d/nodesource.list && \
    apt-key adv --fetch-keys http://deb.nodesource.com/gpgkey/nodesource.gpg.key && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install offical packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        # System utils
        chrony file gnome-icon-theme htop less lm-sensors tree whiptail xauth \
        # Network utils
        hping3 iproute2 iputils-ping nginx wget \
        # Development
        build-essential clang-format cppcheck gdb jq tmux valgrind vim \
        # Libraries
        libpcap0.8-dev libnlopt-cxx-dev \
        # Python utils
        python3-autopep8 python3-pcl python3-pip python3-tk && \
    rm -rf /var/lib/apt/lists/*

# Install jarvis packages
COPY ./repo.asc /tmp/repo.asc
COPY ./config/jarvis.conf /etc/apt/auth.conf.d/jarvis.conf
RUN echo "deb http://nexus.cambricon.com/repository/jarvis-auto-focal focal main" > /etc/apt/sources.list.d/jarvis.list && \
    cat /tmp/repo.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        # System
        jarvis-linter=23.01.31-r1917+f3a5c0f && \
    rm -rf /var/lib/apt/lists/*

# Up to date all debian packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    apt-get autopurge -y && \
    rm -rf /var/lib/apt/lists/*

# Install pip packages
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple \
    whiptail-dialogs xmlschema

# Setup environment
COPY ./config/nginx.conf /etc/nginx/sites-available/default
COPY ./scripts /usr/local/bin
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["zsh"]
