FROM ubuntu:latest

# Install base-devel
RUN apt-get update
RUN apt-get install -y build-essential git sudo

# set password "password" for root
RUN echo "root:password" | chpasswd

# Add user "ubuntu" with password "password" with sudo privileges
RUN useradd -G sudo -m ubuntu
RUN echo "ubuntu:password" | chpasswd

# Execute setup.sh
COPY setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh
RUN /usr/local/bin/setup.sh ubuntu

# Set the default user
USER ubuntu
WORKDIR /home/ubuntu