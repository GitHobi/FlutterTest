This is a bried demo to find out how good things could work on a raspberry pi. 

Flutter is supposed to be installed in g:\flutter

# Compile package
cd G:\VSC\Projects\flutter1\mvEmbedded2\flutter_application_1
G:\VSC\Projects\flutter1\mvEmbedded2\flutter_application_1>g:\flutter\bin\cache\dart-sdk\bin\dart.exe g:\flutter\bin\cache\dart-sdk\bin\snapshots\frontend_server.dart.snapshot --sdk-root g:\flutter\bin\cache\artifacts\engine\common\flutter_patched_sdk_product --target=flutter --aot --tfa -Ddart.vm.product=true --packages .dart_tool\package_config.json --output-dill build\kernel_snapshot.dill --verbose --depfile build\kernel_snapshot.d package:flutter_application_1/main.dart

# generate linux binary package

This needs to be done in WSL!

root@hobiI7:/mnt/g/VSC/Projects/flutter1/mvEmbedded2/flutter_application_1# flutter-engine-binaries-for-arm-main/arm/gen_snapshot_linux_x64_release --deterministic --snapshot_kind=app-aot-elf --elf=build/flutter_assets/app.so --strip --sim-use-hardfp build/kernel_snapshot.dill

# transfer to raspi 

root@hobiI7:/mnt/g/VSC/Projects/flutter1/mvEmbedded2/flutter_application_1# scp -r ./build/flutter_assets/ hobi@192.168.20.8:/home/hobi/