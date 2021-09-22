# file generation
./build/hello.img : hello.asm
	nasm.exe -f bin -o ./build/hello.img hello.asm

run : ./build/hello.img
	qemu-system-x86_64.exe ./build/hello.img

clean:
	rm -r ./build/*