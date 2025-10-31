# add user
adduser --system --shell /bin/bash --gecos 'Git Version Control' --group --disabled-password --home /home/gitea gitea

# create required directories
mkdir -p /var/lib/gitea/{custom,data,indexers,public,log}
chmod -R 750 /var/lib/gitea
chown -R gitea:gitea /var/lib/gitea

mkdir -p /etc/gitea
chown root:gitea /etc/gitea
chmod 770 /etc/gitea

# Download Gitea
VERSION=1.24.0
wget -O /tmp/gitea https://dl.gitea.io/gitea/${VERSION}/gitea-${VERSION}-linux-amd64
sudo mv /tmp/gitea /usr/local/bin/gitea
sudo chmod +x /usr/local/bin/gitea

# Create systemd service
cat <<'EOF' | sudo tee /etc/systemd/system/gitea.service >/dev/null
[Unit]
Description=Gitea Git Service
After=network.target
Wants=network-online.target

[Service]
# User & Group
User=gitea
Group=gitea

# Directories
WorkingDirectory=/var/lib/gitea/

# Execute Gitea binary
ExecStart=/usr/local/bin/gitea web
Environment=USER=gitea HOME=/home/gitea GITEA_WORK_DIR=/var/lib/gitea

# Restart on failure
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

# start the server
systemctl daemon-reload
systemctl enable gitea
systemctl start gitea


# access the server : <server_ip>:3000
# follow the setup, choose sqlite as DB for gitea to keep it lightweight and fast/simple
# if you want set mysql then check file 3-gitea-db.txt


