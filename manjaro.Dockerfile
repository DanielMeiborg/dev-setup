FROM manjarolinux/base

# Install base-devel
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm base-devel git yay

# set password "password" for root
RUN echo "root:password" | chpasswd

# Add user "manjaro" with password "password" with sudo privileges
RUN useradd -m manjaro
RUN echo "manjaro:password" | chpasswd
RUN echo 'manjaro ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo

# Execute setup.sh
COPY setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh
RUN /usr/local/bin/setup.sh manjarou

# Set the default user
USER manjaro
WORKDIR /home/manjaro