# 🚀 Mac Developer Setup Kurulum Kılavuzu

Bu kılavuz, Mac Developer Setup scriptlerini nasıl kullanacağınızı adım adım anlatır.

## 📋 İçerik

- [Hızlı Kurulum](#-hızlı-kurulum)
- [Detaylı Kurulum](#-detaylı-kurulum)
- [Modüler Kullanım](#-modüler-kullanım)
- [Özelleştirme](#-özelleştirme)
- [Sorun Giderme](#-sorun-giderme)

## ⚡ Hızlı Kurulum

### Yeni Mac için (Önerilen)

```bash
# Terminal açın ve şu komutu çalıştırın:
git clone https://github.com/drs-team/mac-developer-setup.git
cd mac-developer-setup
chmod +x *.sh
./setup.sh
```

Menüden **"1 - Full Setup"** seçin ve bekleyin!

### Tek Komutla Kurulum

```bash
curl -sSL https://raw.githubusercontent.com/drs-team/mac-developer-setup/main/setup.sh | bash
```

## 📖 Detaylı Kurulum

### 1. Dosyaları İndirin

**GitHub'dan:**
```bash
git clone https://github.com/drs-team/mac-developer-setup.git
cd mac-developer-setup
```

**Zip olarak:**
- GitHub'dan "Code → Download ZIP" ile indirin
- Zip'i açın ve klasöre girin

### 2. İzinleri Ayarlayın

```bash
chmod +x *.sh
```

### 3. Ana Script'i Çalıştırın

```bash
./setup.sh
```

### 4. Kurulum Tipini Seçin

```
1. Full Setup (Önerilen) - Her şeyi kurar
2. Selective Setup - İstediğinizi seçin
3. Quick Setup - Sadece temel araçlar
```

## 🧩 Modüler Kullanım

İstediğiniz bileşenleri ayrı ayrı kurabilirsiniz:

### Temel Araçlar
```bash
./install-homebrew.sh      # Homebrew paket yöneticisi
./install-cli-tools.sh     # Git, Docker, AWS CLI, vs.
```

### Development Ortamı
```bash
./setup-development.sh     # Node.js, npm, yarn, pnpm
./configure-shell.sh       # oh-my-zsh, aliases, plugins
```

### Desktop Uygulamaları
```bash
./install-desktop-apps.sh  # VS Code, WebStorm, Postman, vs.
```

## 🛠️ Özelleştirme

### Kendi Araçlarınızı Ekleyin

`install-cli-tools.sh` dosyasını düzenleyin:
```bash
CLI_TOOLS=(
    "git"
    "docker"
    "kendi-aracınız"  # Buraya ekleyin
)
```

`install-desktop-apps.sh` dosyasını düzenleyin:
```bash
PRODUCTIVITY_APPS=(
    "notion"
    "figma"
    "kendi-uygulamanız"  # Buraya ekleyin
)
```

### Shell Konfigürasyonunu Değiştirin

`configure-shell.sh` dosyasında:
- Kendi alias'larınızı ekleyin
- oh-my-zsh plugin'lerini değiştirin
- Tema seçiminizi yapın

## 📋 Kurulum Sonrası Yapılacaklar

### 1. Git Konfigürasyonu
```bash
git config --global user.name "Adınız"
git config --global user.email "email@domain.com"
```

### 2. AWS Konfigürasyonu
```bash
aws configure
# AWS credentials girin
```

### 3. SSH Anahtarı Oluşturun
```bash
ssh-keygen -t ed25519 -C "email@domain.com"
# GitHub/GitLab'a ekleyin
```

### 4. Terminal'i Yeniden Başlatın
```bash
source ~/.zshrc
# veya terminali kapatıp açın
```

## 🎯 Yararlı Komutlar

Kurulum sonrası kullanabileceğiniz kısayollar:

### Development
```bash
ni          # npm install
ns          # npm start
nrd         # npm run dev
```

### Git
```bash
gs          # git status
ga          # git add
gc          # git commit
gp          # git push
```

### System
```bash
ll          # ls -alF (detaylı liste)
cat file    # bat ile syntax highlighting
reload      # zshrc'yi yeniden yükle
```

## 🔧 Sorun Giderme

### Homebrew İzin Sorunu
```bash
sudo chown -R $(whoami) /opt/homebrew/
```

### "Command not found" Hatası
```bash
# Shell'i yeniden yükleyin
source ~/.zshrc

# veya terminali yeniden başlatın
```

### NVM Çalışmıyor
```bash
# ~/.zshrc dosyasını kontrol edin
echo $NVM_DIR
# Boşsa tekrar kurun:
./setup-development.sh
```

### Docker Desktop Problemi
- Docker.com'dan manuel indirin
- Sistem Ayarları'ndan izinleri verin

## 📤 Başkalarıyla Paylaşma

### GitHub Repository Oluşturma
```bash
cd mac-developer-setup
git init
git add .
git commit -m "Mac developer setup scripts"
git remote add origin https://github.com/drs-team/mac-developer-setup.git
git push -u origin main
```

### Paylaşım Linkleri
Başkalarına vereceğiniz linkler:

**GitHub Repo:**
```
https://github.com/drs-team/mac-developer-setup
```

**Tek komut kurulum:**
```bash
curl -sSL https://raw.githubusercontent.com/username/mac-developer-setup/main/setup.sh | bash
```

## 🔒 Güvenlik Notları

- Scriptleri çalıştırmadan önce içeriğini kontrol edin
- Sadece güvendiğiniz kaynaklardan indirin
- Kendi repo'nuzda değişiklik yapabilirsiniz

## ❓ Sık Sorulan Sorular

**Q: Hangi macOS versiyonlarında çalışır?**
A: macOS Ventura, Sonoma ve Sequoia'da test edildi.

**Q: Apple Silicon ve Intel Mac'lerde çalışır mı?**
A: Evet, otomatik olarak doğru sürümü indirir.

**Q: Mevcut kurulumlarımı bozar mı?**
A: Hayır, mevcut araçları kontrol eder ve sadece eksikleri kurar.

**Q: Lisanslı uygulamalar için ne yapmalıyım?**
A: WebStorm, Typora gibi uygulamalar için ayrıca lisans almanız gerekir.

## 🤝 Katkıda Bulunma

Bu scriptleri geliştirmek isterseniz:
1. Fork yapın
2. Değişikliklerinizi test edin
3. Pull request gönderin

---

**🎉 İyi kodlamalar!**

*Bu kurulum ile backend development için hazır bir Mac ortamınız olacak.*