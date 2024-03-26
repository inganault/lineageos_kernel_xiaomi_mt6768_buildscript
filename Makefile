all: boot-ksu.img

download/aik-linux.tar.gz:
	mkdir -p $(dir $@)
	curl -Lo $@ "https://xdaforums.com/attachments/aik-linux-v3-8-all-tar-gz.5300923/"

download/boot.img:
	mkdir -p $(dir $@)
	curl -Lo $@ "https://mirrorbits.lineageos.org/full/lancelot/20240323/boot.img"

aik-linux/extracted.stamp: download/aik-linux.tar.gz
	mkdir -p $(dir $@) && tar xf $< -C $(dir $@) --strip-components=1
	touch $@

image_gz := kernel/out/arch/arm64/boot/Image.gz

$(image_gz):
	./build_kernel.sh

boot-ksu.img: download/boot.img $(image_gz) aik-linux/extracted.stamp
	aik-linux/unpackimg.sh download/boot.img
	cp $(image_gz) aik-linux/split_img/boot.img-kernel
	aik-linux/repackimg.sh
	mv aik-linux/image-new.img boot-ksu.img

clean:
	rm -r aik-linux $(image_gz)
.PHONY: clean
