#!/bin/bash
WORKDIR=$PWD

build_udt(){
   #docker run -w /code --rm -it -v `pwd`:/code nervos/ckb-riscv-gnu-toolchain:xenial bash
   udt_builder="docker run -w /code --rm -it -v $WORKDIR/src:/code nervos/ckb-riscv-gnu-toolchain:xenial"
   $udt_builder riscv64-unknown-elf-gcc -Os udt_info.c -o udt-info
   $udt_builder riscv64-unknown-elf-gcc -Os udt_data.c -o udt-data
   $udt_builder riscv64-unknown-elf-gcc -Os udt.c -o udt
}

### Deploy

build_deployer(){
   go_builder="docker run --rm -v $WORKDIR/deploy:/usr/src/myapp -w /usr/src/myapp golang "
   $go_builder go build -v deployer.go
   $go_builder go build -v deployer-codehash.go
}

build_udt
build_deployer

docker run --env-file .env --link ckb-node:ckb-node --rm -v $WORKDIR/:/usr/src/myapp -w /usr/src/myapp/deploy golang ./deployer
docker run --link ckb-node:ckb-node --rm -v $WORKDIR/:/usr/src/myapp -w /usr/src/myapp/deploy golang ./deployer-codehash
