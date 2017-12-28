# batch-ati-flash
Batch script to save and flash up to 10 AMD GPUs using PolarisBIOSeditor. No error handling.

This script when combined with PolarisBIOSeditor and ATIflash will save all AMD BIOSes and flash them all. You need to manually make timing patches using PolarisBIOSeditor, found below.

https://github.com/jaschaknack/PolarisBiosEditor

https://www.techpowerup.com/download/ati-atiflash/

Can be made fully automatic if you change the code in PolarisBIOSeditor and call the *apply_timing* function and pass in the filenames as runtime variables to make it truly automated.

Steps to flash all cards:

1) Put this script in your atiflash directory and run it, it will request admin rights
2) Run it and input how many GPUs you have
3) It'll enumerate and save all ROMs to gpu0.rom, gpu1.rom, etc.
4) Open PolarisBIOSeditor and overwrite the gpu files (improvement, of sorts: save to gpu0-patched.rom and loop over the patched files)
5) Get through the timeouts and it'll patch every card individually

Again, no error handling, so don't put nonsense in the number of cards list. Or do, whatever.
