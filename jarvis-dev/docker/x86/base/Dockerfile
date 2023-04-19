FROM ubuntu:focal

# Setup environment
WORKDIR /root
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Change APT server
RUN sed -i "s/archive.ubuntu.com/jarvis.singgo.com:18001/g" /etc/apt/sources.list && \
    sed -i "s/security.ubuntu.com/jarvis.singgo.com:18001/g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

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

# Install CUDA
RUN echo "deb http://jarvis.singgo.com:18001/nvidia focal cuda" > /etc/apt/sources.list.d/cuda-repos.list && \
    apt-key adv --fetch-keys http://jarvis.singgo.com:18001/repo.asc && \
    apt-get update && \
    apt-get install -y --no-install-recommends cuda-toolkit-11-1 && \
    rm -rf /var/lib/apt/lists/*

# Install TensorRT
RUN echo "deb http://jarvis.singgo.com:18001/nvidia focal tensorrt" > /etc/apt/sources.list.d/trt-repos.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends tensorrt && \
    rm -rf /var/lib/apt/lists/*

# Install ROS
RUN echo "deb http://jarvis.singgo.com:18001/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros1-latest.list && \
    apt-key adv --fetch-keys https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc && \
    apt-get update && \
    apt-get install -y --no-install-recommends ros-noetic-desktop-full && \
    rm -rf /var/lib/apt/lists/* && \
    echo "\nsource /opt/ros/noetic/setup.zsh" >> /root/.zshrc
