REROKU_LIB_ROOT ?= /var/lib/reroku
REROKU_ROOT ?= /home/reroku/reroku

all:
	rm -rf build
	mkdir build
	cp -r nginx build/nginx

install: all base_images
	sed -e "s+{{REROKU_ROOT}}+${REROKU_ROOT}+g" nginx/reroku.conf > /etc/nginx/conf.d/reroku.conf
	cp -r build ${REROKU_LIB_ROOT}
	cp reroku /usr/local/bin/reroku
	echo "%reroku ALL=(ALL) NOPASSWD:/etc/init.d/nginx reload, /usr/sbin/nginx -t" > /etc/sudoers.d/reroku-nginx
	
base_images: base_python_image

base_python_image:
	cd images/python && docker build -t reroku/python .	

uninstall:
	rm -f /etc/nginx/conf.d/reroku.conf
	rm -rf ${REROKU_LIB_ROOT}
	rm -f /usr/local/bin/reroku
	rm -f /etc/sudoers.d/reroku-nginx
