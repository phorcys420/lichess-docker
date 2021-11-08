TZ = $(cat /etc/timezone)
LC = $(locale | grep LANG -m 1 | cut -d= -f2)

if ! command -v docker &> /dev/null
then
    echo "[!] Docker is not installed on your system"
    exit 1
fi

if ! command -v docker-compose &> /dev/null
then
    echo "[!] Compose is not installed on your system"
    exit 1
fi

if [ -z "$TZ" ]
then
    read -p "[?] TZ is not set, please input your Timezone (i.e Europe/Paris) : " TZ
fi

if [ -z "$LC" ]
then
    read -p "[?] LC is not set, please input your locale (i.e fr_FR.UTf-8) : " LC
fi

echo [+] Cloning git repository
git clone https://github.com/phorcys420/lichess-docker.git
cd lichess-docker

echo [+] Building lila_base
docker build -t phorcys420/lila_base lila_base/

echo [+] Building every image required by the Compose configuration
docker-compose build