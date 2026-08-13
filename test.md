chmod 644 ./ansibletestapp.2026-07-24.private-key.pem

ATLANTIS_GH_APP_ID=4387827
ATLANTIS_GH_APP_KEY_FILE=/atlantis-data/ansibletestapp.2026-07-24.private-key.pem
ATLANTIS_GH_WEBHOOK_SECRET=I95NYL7l318vBNttJEpT
ATLANTIS_GH_APP_SLUG=AnsibleTestApp
ATLANTIS_WRITE_GIT_CREDS=true
ATLANTIS_REPO_ALLOWLIST="github.com/SergioRiveraRios/*"
ATLANTIS_ATLANTIS_URL=http://100.27.35.143



podman run -d \
  --name atlantis \
  --network=host \
  --env-file atlantis.env \
  --security-opt label=disable \
  -v ~/.atlantis/data:/atlantis-data \
  -v "$(pwd)/ansibletestapp.2026-07-24.private-key.pem:/atlantis-data/ansibletestapp.2026-07-24.private-key.pem" \
  ghcr.io/runatlantis/atlantis:v0.27.2 \
  server



server {
    listen 80;
    server_name 100.62.105.253; # Your public Nginx/ALB IP

    access_log /var/log/nginx/atlantis_access.log;
    error_log /var/log/nginx/atlantis_error.log;

    location /events {
        # REPLACE 10.0.0.50 with your Atlantis Machine's Private IP
        proxy_pass http://10.0.21.228:4141;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_http_version 1.1;
        proxy_set_header Connection "";
    }

    location / {
        # REPLACE 10.0.0.50 with your Atlantis Machine's Private IP
        proxy_pass http://10.0.21.228:4141;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}