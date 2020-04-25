FROM ubuntu:latest

ENV GODOT_VERSION "3.2.1"
ENV GODOT_V_TYPE "server"

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    unzip \
    wget 

RUN wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_linux_${GODOT_V_TYPE}.64.zip \
    && unzip Godot_v${GODOT_VERSION}-stable_linux_${GODOT_V_TYPE}.64.zip 

COPY Server.pck Server.pck

COPY Server.x86_64 Server.x86_64

CMD ["./Godot_v3.2.1-stable_linux_server.64","Server.x86_64","--main-pack","Server.pck"]

