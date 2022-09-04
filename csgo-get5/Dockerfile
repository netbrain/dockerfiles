FROM debian:bullseye

ENV STEAM_DIR /home/user
ENV STEAMCMD_DIR $STEAM_DIR/steamcmd
ENV CSGO_APP_ID 740
ENV CSGO_DIR $STEAM_DIR/csgo

SHELL ["/bin/bash", "-c"]

RUN set -xo pipefail && \
	apt-get update && \
	apt-get -y install \
		lib32gcc-s1 \
		curl \
		vim \
		locales \
		ca-certificates \
		unzip \
		lib32stdc++6 \
		lib32z1 \
		net-tools && \
	locale-gen en_US.UTF-8 && \
	useradd -m user && \
	mkdir -p $STEAMCMD_DIR && \
	cd $STEAMCMD_DIR && \
	curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - && \
	mkdir -p $STEAM_DIR/.steam/sdk32 && \
	ln -s $STEAMCMD_DIR/linux32/steamclient.so $STEAM_DIR/.steam/sdk32/steamclient.so && \
    	{ \
            echo "@ShutdownOnFailedCommand 1"; \
            echo "@NoPromptForPassword 1"; \
            echo "force_install_dir $CSGO_DIR"; \
            echo "login anonymous"; \
            echo "app_update $CSGO_APP_ID"; \
            echo "quit"; \
        } > $STEAMCMD_DIR/csgo.txt && \
	mkdir $CSGO_DIR && \
	chown -R user:user $STEAM_DIR && \
	rm -rf /var/cache/apt/archives

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

USER user
WORKDIR $STEAM_DIR

# Download CSGO dedicated server
RUN $STEAMCMD_DIR/steamcmd.sh +runscript csgo.txt
ENV LD_LIBRARY_PATH="/home/user/csgo/bin/"

# Download metamod
ENV METAMOD_VERSION=1.11
RUN curl -sqL https://mms.alliedmods.net/mmsdrop/$METAMOD_VERSION/$(curl -qL https://mms.alliedmods.net/mmsdrop/$METAMOD_VERSION/mmsource-latest-linux) | tar zxvf - -C csgo/csgo
#COPY metamod.vdf csgo/addons/metamod.vdf

# Download sourcemod
ENV SOURCEMOD_VERSION=1.11
RUN curl -sqL https://sm.alliedmods.net/smdrop/$SOURCEMOD_VERSION/$(curl https://sm.alliedmods.net/smdrop/$SOURCEMOD_VERSION/sourcemod-latest-linux) | tar zxvf - -C csgo/csgo

# Download get5
ENV GET5_VERSION=v0.10.0
RUN curl -sqL https://github.com/splewis/get5/releases/download/$GET5_VERSION/get5-$GET5_VERSION.tar.gz | tar zxvf - -C csgo

# TODO include steamworks? see get5 documentation
# -insecure

