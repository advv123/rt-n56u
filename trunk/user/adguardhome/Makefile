# AdGuardHome for Padavan
# 自动下载并打包 mipsle 软浮点版二进制

ADGUARDHOME_VER := 0.107.56
ADGUARDHOME_URL := https://github.com/AdguardTeam/AdGuardHome/releases/download/v$(ADGUARDHOME_VER)/AdGuardHome_linux_mipsle_softfloat.tar.gz

all:
    @echo "Nothing to build for AdGuardHome"

download:
    @echo "Downloading AdGuardHome v$(ADGUARDHOME_VER)..."
    @mkdir -p dl
    @[ -f dl/AdGuardHome_linux_mipsle_softfloat.tar.gz ] || \
        wget -O dl/AdGuardHome_linux_mipsle_softfloat.tar.gz $(ADGUARDHOME_URL)

romfs: download
    @echo "Installing AdGuardHome into firmware..."
    @tar -xzf dl/AdGuardHome_linux_mipsle_softfloat.tar.gz -C dl
    @mkdir -p $(ROMFSDIR)/usr/bin
    @cp -f dl/AdGuardHome/AdGuardHome $(ROMFSDIR)/usr/bin/adguardhome
    @chmod 755 $(ROMFSDIR)/usr/bin/adguardhome
    # 安装启动脚本
    @mkdir -p $(ROMFSDIR)/etc/init.d
    @cp -f $(THISDIR)/adguardhome.sh $(ROMFSDIR)/etc/init.d/S99adguardhome
    @chmod 755 $(ROMFSDIR)/etc/init.d/S99adguardhome

clean:
    @rm -rf dl
