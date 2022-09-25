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

# Download sourcemod
ENV SOURCEMOD_VERSION=1.11
RUN curl -sqL https://sm.alliedmods.net/smdrop/$SOURCEMOD_VERSION/$(curl https://sm.alliedmods.net/smdrop/$SOURCEMOD_VERSION/sourcemod-latest-linux) | tar zxvf - -C csgo/csgo

# Download get5
ENV GET5_VERSION=v0.10.0
RUN curl -sqL https://github.com/splewis/get5/releases/download/$GET5_VERSION/get5-$GET5_VERSION.tar.gz | tar zxvf - -C csgo/csgo

ENV SRCDS_FPSMAX=300 \
	SRCDS_TICKRATE=128 \
	SRCDS_PORT=27015 \
	SRCDS_TV_PORT=27020 \
	SRCDS_CLIENT_PORT=27005 \
	SRCDS_NET_PUBLIC_ADDRESS="0" \
	SRCDS_IP="0" \
	SRCDS_LAN="0" \
	SRCDS_MAXPLAYERS=14 \
	SRCDS_TOKEN=0 \
	SRCDS_RCONPW="changeme!" \
	SRCDS_PW="" \
	SRCDS_STARTMAP="de_dust2" \
	SRCDS_REGION=3 \
	SRCDS_MAPGROUP="mg_active" \
	SRCDS_GAMETYPE=0 \
	SRCDS_GAMEMODE=1 \
	SRCDS_HOSTNAME="New \"${STEAMAPP}\" Server" \
	SRCDS_WORKSHOP_START_MAP=0 \
	SRCDS_HOST_WORKSHOP_COLLECTION=0 \
	SRCDS_WORKSHOP_AUTHKEY="" \
	ADDITIONAL_ARGS=""

EXPOSE 27015/tcp 27015/udp 27020/udp

WORKDIR $CSGO_DIR
CMD bash "$STEAMCMD_DIR/steamcmd.sh" +runscript csgo.txt && \
    bash "${CSGO_DIR}/srcds_run" -game "csgo" -console \
	-usercon \
	+fps_max "${SRCDS_FPSMAX}" \
	-tickrate "${SRCDS_TICKRATE}" \
	-port "${SRCDS_PORT}" \
	+tv_port "${SRCDS_TV_PORT}" \
	+clientport "${SRCDS_CLIENT_PORT}" \
	-maxplayers_override "${SRCDS_MAXPLAYERS}" \
	+game_type "${SRCDS_GAMETYPE}" \
	+game_mode "${SRCDS_GAMEMODE}" \
	+mapgroup "${SRCDS_MAPGROUP}" \
	+map "${SRCDS_STARTMAP}" \
	+sv_setsteamaccount "${SRCDS_TOKEN}" \
	+rcon_password "${SRCDS_RCONPW}" \
	+sv_password "${SRCDS_PW}" \
	+sv_region "${SRCDS_REGION}" \
	+net_public_adr "${SRCDS_NET_PUBLIC_ADDRESS}" \
	-ip "${SRCDS_IP}" \
	+sv_lan "${SRCDS_LAN}" \
	+host_workshop_collection "${SRCDS_HOST_WORKSHOP_COLLECTION}" \
	+workshop_start_map "${SRCDS_WORKSHOP_START_MAP}" \
	-authkey "${SRCDS_WORKSHOP_AUTHKEY}" \
	"${ADDITIONAL_ARGS}"	
