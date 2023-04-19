FROM nexus.cambricon.com/jarvis-auto-docker/jarvis-dev:base-noetic-cuda11.1.1-trt8.0.1

# Change APT server
RUN echo "deb http://nexus.cambricon.com/repository/ubuntu focal main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://nexus.cambricon.com/repository/ubuntu focal-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://nexus.cambricon.com/repository/ubuntu focal-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://nexus.cambricon.com/repository/ubuntu focal-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://nexus.cambricon.com/repository/ubuntu-ros focal main" > /etc/apt/sources.list.d/ros1-latest.list && \
    echo "deb http://nexus.cambricon.com/repository/nvidia-cuda-focal focal main" > /etc/apt/sources.list.d/cuda-repos.list && \
    echo "deb http://nexus.cambricon.com/repository/nvidia-trt-focal focal main" > /etc/apt/sources.list.d/trt-repos.list

# Install NodeJS
RUN echo "deb http://nexus.cambricon.com/repository/ubuntu-nodejs focal main" > /etc/apt/sources.list.d/nodesource.list && \
    apt-key adv --fetch-keys https://deb.nodesource.com/gpgkey/nodesource.gpg.key && \
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
        clang-format cppcheck gdb jq tmux valgrind vim \
        # Libraries
        libpcap0.8-dev libnlopt-cxx-dev \
        # Python utils
        python3-autopep8 python3-libnvinfer-dev python3-pcl python3-pip python3-tk && \
    rm -rf /var/lib/apt/lists/*

# Install ros packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends ros-noetic-plotjuggler-ros && \
    rm -rf /var/lib/apt/lists/*

# Install jarvis packages
COPY ./config/jarvis.conf /etc/apt/auth.conf.d/jarvis.conf
RUN echo "deb http://nexus.cambricon.com/repository/jarvis-auto-focal focal main" > /etc/apt/sources.list.d/jarvis.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        # System
        cmake=3.16.3-1ubuntu1.1 \
        jarvis-linter=22.10.13-r1128+a555a2b \
        # Perception
        libopencv-dev=4.2.0+dfsg-5cuda11 \
        # PnC
        coinor-libqpoases-dev=3.2.1-1 \
        libgtsam-dev=4.0.3-1ubuntu1 \
        libgtsam-unstable-dev=4.0.3-1ubuntu1 && \
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
