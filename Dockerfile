FROM ac1965/archlinux:latest
MAINTAINER ac1965 <https://github.com/ac1965>

# 
COPY ["packages/", "/tmp/packages/"]
USER root
WORKDIR /root
RUN pacman -Syu --noconfirm --needed $(egrep -v '^#|^$' /tmp/packages/base.txt) && pacman -Scc --noconfirm
ADD startup.sh /home/pwner/startup.sh
RUN chown pwner:pwner /home/pwner/startup.sh && chmod 0755 /home/pwner/startup.sh

USER pwner
WORKDIR /home/pwner/
RUN git clone https://github.com/kanaka/noVNC.git && \
	cd noVNC/utils && git clone https://github.com/kanaka/websockify websockify
CMD /home/pwner/startup.sh
