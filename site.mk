##	gluon site.mk makefile example

##	GLUON_SITE_PACKAGES
#		specify gluon/openwrt packages to include here
#		The gluon-mesh-batman-adv-* package must come first because of the dependency resolution

GLUON_SITE_PACKAGES := \
	gluon-autoupdater \
	gluon-config-mode-hostname \
	gluon-config-mode-autoupdater \
	gluon-config-mode-mesh-vpn \
	gluon-config-mode-geo-location \
	gluon-config-mode-contact-info \
	gluon-ebtables-filter-multicast \
	gluon-ebtables-filter-ra-dhcp \
	gluon-web-admin \
	gluon-web-autoupdater \
	gluon-web-network \
	gluon-web-private-wifi \
	gluon-mesh-batman-adv-15 \
	gluon-mesh-vpn-fastd \
	gluon-radvd \
	gluon-respondd \
	gluon-status-page \
	haveged \
	iwinfo \
	iptables

# add offline ssid only if the target has wifi device
ifeq "$(GLUON_TARGET)" "ar71xx-generic"
ADD_WIFI_PKGS = yes
endif

ifeq "$(GLUON_TARGET)" "ar71xx-nand"
ADD_WIFI_PKGS = yes
endif

ifeq "$(GLUON_TARGET)" "mpc85xx-generic"
ADD_WIFI_PKGS = yes
endif

ifeq "$(ADD_WIFI_PKGS)" "yes"
GLUON_SITE_PACKAGES += \
	gluon-web-wifi-config \
	gluon-ssid-changer \
	ffffm-additional-wifi-json-info
endif

# RaspberryPi Model 1B
ifeq ($(GLUON_TARGET),brcm2708-bcm2708)
GLUON_SITE_PACKAGES += \
	gluon-web-wifi-config \
	gluon-ssid-changer \
	iw \
	kmod-ath \
	kmod-ath9k-common \
	kmod-ath9k-htc \
	kmod-cfg80211 \
	kmod-crypto-aes \
	kmod-crypto-arc4 \
	kmod-gpio-button-hotplug \
	kmod-mac80211 \
	kmod-usb-core \
	kmod-usb2 \
	kmod-usb-hid \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-usb-net-dm9601-ether \
	kmod-rtlwifi-usb \
	kmod-rtlwifi \
	swconfig
endif

# add network drivers and usb stuff only to x86-generic
# (where disk space probably doesn't matter)
ifeq ($(GLUON_TARGET),x86-generic)
GLUON_SITE_PACKAGES += \
	kmod-forcedeth \
	kmod-sky2 \
	kmod-r8169 \
	kmod-usb-core \
	kmod-usb2 \
	kmod-usb-hid \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-usb-net-dm9601-ether \
	kmod-8139too
endif

##	DEFAULT_GLUON_RELEASE
#		version string to use for images
#		gluon relies on
#			opkg compare-versions "$1" '>>' "$2"
#		to decide if a version is newer or not.

DEFAULT_GLUON_RELEASE := v2018.1

##	GLUON_RELEASE
#		call make with custom GLUON_RELEASE flag, to use your own release version scheme.
#		e.g.:
#			$ make images GLUON_RELEASE=23.42+5
#		would generate images named like this:
#			gluon-ff%site_code%-23.42+5-%router_model%.bin

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

# Default priority for updates.
GLUON_PRIORITY ?= 0

# Languages to include
GLUON_LANGS ?= de en fr

# Turn on building for ATH10K Devices by specifying mesh type
GLUON_ATH10K_MESH ?= 11s
