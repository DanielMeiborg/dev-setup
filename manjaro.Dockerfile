FROM manjarolinux/base

# Install base-devel
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm base-devel git yay

# set password "password" for root
RUN echo "root:password" | chpasswd

# Add user "manjaro" with password "password" with sudo privileges
RUN useradd -m manjaro
RUN echo "manjaro:password" | chpasswd
RUN echo 'manjaro ALL=(ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo

COPY install.sh /usr/local/bin/install.sh
RUN chmod +x /usr/local/bin/install.sh
RUN chown manjaro:manjaro /usr/local/bin/install.sh

# Set the default user
USER manjaro
WORKDIR /home/manjaro

RUN /usr/local/bin/install.sh pacman y

ENV LANG C.UTF-8

CMD ["zsh"]