FROM ubuntu:latest

# Install base-devel
RUN apt-get update
RUN apt-get install -y build-essential git sudo curl

# set password "password" for root
RUN echo "root:password" | chpasswd

# Add user "ubuntu" with password "password" with sudo privileges
RUN useradd -G sudo -m ubuntu
RUN echo "ubuntu:password" | chpasswd
RUN echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo

COPY install.sh /usr/local/bin/install.sh
RUN chmod +x /usr/local/bin/install.sh
RUN chown ubuntu:ubuntu /usr/local/bin/install.sh

# Set the default user
USER ubuntu
WORKDIR /home/ubuntu

RUN /usr/local/bin/install.sh apt y

ENV LANG C.UTF-8

CMD ["zsh"]