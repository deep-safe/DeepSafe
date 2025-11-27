# 🚀 Deployment & Distribution Strategy

This document outlines the complete roadmap for deploying, scaling, and distributing **Deepsafe**. It covers the infrastructure journey from a low-cost MVP to a high-scale architecture, as well as the strategy for user acquisition via PWA.

---

## 📈 Infrastructure Scaling Roadmap

### Phase 1: The MVP (0 - 1,000 Users)
**Goal**: Minimize costs while ensuring stability for early adopters.

*   **Compute**: Single VPS (2 vCPU, 4GB RAM).
    *   *Provider*: Hetzner (CPX31) or DigitalOcean (Basic Droplet).
    *   *Cost*: ~€5-10/month.
*   **Database**: Supabase (Free Tier or Pro Plan).
    *   *Why*: Managed PostgreSQL, Auth, and Storage out of the box. No devops overhead.
*   **Caching**: In-memory (Node.js).
*   **Architecture**: Monolithic. Next.js app handles both API and Frontend on the same server.

### Phase 2: Growth (1,000 - 50,000 Users)
**Goal**: Handle concurrent traffic and ensure zero downtime during deployments.

*   **Compute**: Vertical Scaling -> Upgrade VPS to 4-8 vCPUs, 16GB RAM.
*   **Database**: Supabase Pro + Point-in-Time Recovery (PITR).
*   **Caching**: Redis (External).
    *   *Use Case*: Cache leaderboard calculations and user session data to reduce DB load.
*   **CDN**: Cloudflare (Free/Pro).
    *   *Why*: Cache static assets (images, JS, CSS) at the edge to reduce server bandwidth.

### Phase 3: High Scale (50,000+ Users)
**Goal**: Horizontal scaling and high availability.

*   **Compute**: Load Balancer + Multiple App Servers.
    *   *Setup*: 1 Nginx Load Balancer distributing traffic to 3+ App Servers (2 vCPU each).
    *   *Tooling*: Docker Swarm or Kubernetes (K8s).
*   **Database**: Supabase Enterprise / Dedicated Instance.
    *   *Read Replicas*: Offload read-heavy queries (Leaderboards, Feed) to replicas.
*   **Storage**: S3 Compatible Object Storage (for massive user uploads).

---

## 🌐 Domain & DNS Configuration

To connect your domain (e.g., `deepsafe.app`) to your VPS:

### 1. Purchase Domain
Buy your domain from a registrar (Namecheap, GoDaddy, Google Domains).

### 2. Configure Cloudflare (Recommended)
We strongly recommend using Cloudflare for DNS management due to its free SSL and DDoS protection.

1.  Create a Cloudflare account and add your site.
2.  Change your domain's Nameservers to the ones provided by Cloudflare.

### 3. DNS Records
In the Cloudflare Dashboard (DNS settings), add the following records:

| Type | Name | Content (Value) | Proxy Status | TTL |
| :--- | :--- | :--- | :--- | :--- |
| **A** | `@` | `YOUR_VPS_IP_ADDRESS` | Proxied (Orange Cloud) | Auto |
| **CNAME** | `www` | `deepsafe.app` | Proxied (Orange Cloud) | Auto |

*Note: The "Proxied" status ensures your real server IP is hidden and traffic is accelerated.*

---

## 📲 PWA Distribution Strategy

**Deepsafe** is a Progressive Web App (PWA). This means it can be installed on devices without going through the App Store or Play Store. This reduces friction and avoids the 30% store tax.

### 1. The "Install" Experience
To ensure users download the app, we must guide them effectively:

*   **iOS (Safari)**:
    *   iOS does not support a native "Install" button prompt.
    *   **Strategy**: Detect iOS users and show a custom "Tooltip" pointing to the "Share" button with instructions: *"Tap Share -> Add to Home Screen"*.
*   **Android (Chrome)**:
    *   Android supports the native `beforeinstallprompt` event.
    *   **Strategy**: Show a custom "Install Deepsafe" button in the UI. When clicked, trigger the native browser prompt.

### 2. Marketing the App
*   **QR Codes**: Place QR codes on physical marketing materials or desktop landing pages that link directly to `deepsafe.app`.
*   **"App-First" Messaging**: Don't call it a "website". Refer to it as the "Web App" or simply "The App".
*   **Push Notifications**: Once installed, prompt users to enable notifications for "Streak Reminders". This is a key retention driver.

### 3. Technical PWA Checklist
Ensure these files are correctly configured in the codebase:
*   `manifest.json`: Defines the app name, icons, and theme color.
*   `service-worker.js`: Handles offline caching and push notifications.
*   `viewport`: Ensure `user-scalable=no` is set to prevent accidental zooming, making it feel like a native app.

---

## 🛠️ Server Provisioning (Phase 1)

### 1. Initial Setup
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js (via NVM) & PM2
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs nginx certbot python3-certbot-nginx
npm install -g pm2
```

### 2. Deploy Code
```bash
git clone https://github.com/your-org/deepsafe.git
cd deepsafe
npm install
npm run build
```

### 3. Start Process
```bash
pm2 start npm --name "deepsafe" -- start
pm2 save
pm2 startup
```

### 4. Nginx Config (`/etc/nginx/sites-available/deepsafe`)
```nginx
server {
    server_name deepsafe.app www.deepsafe.app;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

### 5. SSL (HTTPS)
```bash
sudo certbot --nginx -d deepsafe.app -d www.deepsafe.app
```
