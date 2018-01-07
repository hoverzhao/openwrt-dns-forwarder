#
# Copyright (C) 2015 OpenWrt-dist
# Copyright (C) 2015 Jian Chang <hoverzhao@live.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dns-forwarder
PKG_VERSION:=1.2.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/hoverzhao/hev-dns-forwarder.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE)
PKG_SOURCE_VERSION:=495af5931755499b3cad515755157886b16f2fbc
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=hoverzhao <painton@tom.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_SOURCE_SUBDIR)

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/dns-forwarder
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Forwarding DNS queries on TCP transport
	URL:=https://github.com/hoverzhao/hev-dns-forwarder
endef

define Package/dns-forwarder/description
Forwarding DNS queries on TCP transport.
endef

define Package/dns-forwarder/conffiles
/etc/config/dns-forwarder
endef

define Package/dns-forwarder/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/hev-dns-forwarder $(1)/usr/bin/dns-forwarder
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/dns-forwarder.config $(1)/etc/config/dns-forwarder
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/dns-forwarder.init $(1)/etc/init.d/dns-forwarder
endef

$(eval $(call BuildPackage,dns-forwarder))
