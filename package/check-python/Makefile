include $(TOPDIR)/rules.mk

PKG_NAME:=check-python
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/check-python
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Python 3.9 version checker
endef

define Package/check-python/description
  Simple C utility to check Python 3.9 version and log output to /tmp/python_ver.log.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Configure
endef

define Build/Compile
	$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) \
		-o $(PKG_BUILD_DIR)/check_python \
		$(PKG_BUILD_DIR)/check_python.c
endef

define Package/check-python/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/check_python $(1)/usr/bin/check_python
endef

$(eval $(call BuildPackage,check-python))
