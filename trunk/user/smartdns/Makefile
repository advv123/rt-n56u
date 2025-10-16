# SmartDNS for Padavan
# 升级到 Release47

SRC_NAME = smartdns-Release47
SRC_URL  = https://github.com/pymumu/smartdns/archive/refs/tags/Release47.tar.gz

all:
    @echo "Nothing to build for SmartDNS"# SmartDNS for Padavan
# 使用 Release47，直接打包 mipsel 二进制

SMARTDNS_VER := Release47
SMARTDNS_URL := https://github.com/pymumu/smartdns/releases/download/$(SMARTDNS_VER)/smartdns-mipsel

all:
    @echo "Nothing to build for SmartDNS"

download:
    @echo "Downloading SmartDNS $(SMARTDNS_VER) for mipsel..."
    @mkdir -p dl
    @[ -f dl/smartdns-mipsel ] || \
        wget -O dl/smartdns-mipsel $(SMARTDNS_URL)

romfs: download
    @echo "Installing SmartDNS into firmware..."
    @mkdir -p $(ROMFSDIR)/usr/bin
    @cp -f dl/smartdns-mipsel $(ROMFSDIR)/usr/bin/smartdns
    @chmod 755 $(ROMFSDIR)/usr/bin/smartdns
    # 安装启动脚本和默认配置
    @cp -f $(THISDIR)/smartdns.sh $(ROMFSDIR)/usr/bin/smartdns.sh
    @chmod 755 $(ROMFSDIR)/usr/bin/smartdns.sh
    @$(ROMFSINST) /etc_ro/smartdns_address.conf
    @$(ROMFSINST) /etc_ro/smartdns_blacklist-ip.conf
    @$(ROMFSINST) /etc_ro/smartdns_custom.conf
    @$(ROMFSINST) /etc_ro/smartdns_whitelist-ip.conf

clean:
    @rm -rf dl


download:
    @echo "Downloading SmartDNS $(SRC_NAME)..."
    @mkdir -p dl
    @[ -f dl/$(SRC_NAME).tar.gz ] || \
        wget -O dl/$(SRC_NAME).tar.gz $(SRC_URL)

romfs: download
    @echo "Installing SmartDNS into firmware..."
    @tar -xzf dl/$(SRC_NAME).tar.gz -C dl
    @mkdir -p $(ROMFSDIR)/usr/bin
    @cp -f dl/$(SRC_NAME)/src/smartdns $(ROMFSDIR)/usr/bin/smartdns
    @chmod 755 $(ROMFSDIR)/usr/bin/smartdns
    # 安装启动脚本和默认配置
    @cp -f $(THISDIR)/smartdns.sh $(ROMFSDIR)/usr/bin/smartdns.sh
    @chmod 755 $(ROMFSDIR)/usr/bin/smartdns.sh
    @$(ROMFSINST) /etc_ro/smartdns_address.conf
    @$(ROMFSINST) /etc_ro/smartdns_blacklist-ip.conf
    @$(ROMFSINST) /etc_ro/smartdns_custom.conf
    @$(ROMFSINST) /etc_ro/smartdns_whitelist-ip.conf

clean:
    @rm -rf dl
