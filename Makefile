IMAGE := openwrt-sdk-env
SDK_DIR := openwrt-sdk-23.05.3-x86-64_gcc-12.3.0_musl.Linux-x86_64
PKG := check-python
APP := check_python
DOCKER := sudo docker

.PHONY: all run clean package shell

all:
	$(DOCKER) run --rm \
		-v $(PWD):/workspace \
		-w /workspace \
		$(IMAGE) \
		bash -lc "gcc -Wall -Wextra -O2 -o $(APP) package/check-python/src/check_python.c"

run: all
	$(DOCKER) run --rm \
		-v $(PWD):/workspace \
		-w /workspace \
		python:3.9-slim \
		bash -lc "python3.9 --version && ./$(APP) && cat /tmp/python_ver.log"

package:
	$(DOCKER) run --rm \
		-v $(PWD):/workspace \
		-w /workspace/$(SDK_DIR) \
		$(IMAGE) \
		bash -lc "rm -rf package/$(PKG) && cp -r /workspace/package/$(PKG) package/$(PKG) && make defconfig && make package/$(PKG)/compile V=s && mkdir -p /workspace/bin && cp bin/packages/x86_64/base/$(PKG)_1.0-1_x86_64.ipk /workspace/bin/"

clean:
	rm -f $(APP)
	rm -rf test-ipk check-ipk
	@if [ -d "$(SDK_DIR)" ]; then \
		$(DOCKER) run --rm \
			-v $(PWD):/workspace \
			-w /workspace/$(SDK_DIR) \
			$(IMAGE) \
			bash -lc "make package/$(PKG)/clean V=s || true"; \
	fi

shell:
	$(DOCKER) run -it --rm \
		-v $(PWD):/workspace \
		-w /workspace \
		$(IMAGE)
