all: mage.chug

mage:	
	mkdir -p build-mage
	cd build-mage;cmake ../mage;make
mage.chug:mage
	cd src; make linux install MAGE_LIB_PATH=`pwd`/../mage/bin/Release


clean:
	cd build-mage;make clean
	cd src;make clean

.PHONY: mage mage.chug
