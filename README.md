CKB minimal UDT
===============

## Prepare

### Pull `ckb-riscv-gnu-toolchain` image

```
docker pull nervos/ckb-riscv-gnu-toolchain:xenial
```

## Develop

### Build

```bash
cd src
docker run --rm -it -v `pwd`:/code nervos/ckb-riscv-gnu-toolchain:xenial bash
root@3ede059e304b:/# cd /code
root@3ede059e304b:/code# riscv64-unknown-elf-gcc -Os udt_info.c -o udt-info
root@3ede059e304b:/code# riscv64-unknown-elf-gcc -Os udt_data.c -o udt-data
root@3ede059e304b:/code# riscv64-unknown-elf-gcc -Os udt.c -o udt
root@3ede059e304b:/code# exit
```

### Deploy

**before deploy udt script you need to run ckb node.**

```bash
cd ../deploy
go build deployer.go
./deployer
```

### Get udt script code hash

```bash
go build deployer-codehash.go
./deployer-codehash
```
