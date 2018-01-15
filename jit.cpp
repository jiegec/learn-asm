#include <stdio.h>
#include <string.h>
#include <vector>
#include <string_view>
#include <unistd.h>
#include <sys/mman.h>

using namespace std;

size_t round_up_page_size(size_t needed_size) {
    size_t page_size = getpagesize();
    return size_t((needed_size + page_size - 1) / page_size) * page_size;
}

void print(const string_view &str) {
    std::vector<uint8_t> machine_code {
                                       // push rbp
                                       0x55,
                                       // mov rbp, rsp
                                       0x48, 0x89, 0xe5,
                                       // mov rax, 0x20000004 ; syscall write
                                       0x48, 0xc7, 0xc0, 0x04, 0x00, 0x00, 0x02,
                                       // mov rdi, 0x1 ; stdout
                                       0x48, 0xc7, 0xc7, 0x01, 0x00, 0x00, 0x00,
                                       // lea rsi, [rip+0xb] ; string begin
                                       0x48, 0x8d, 0x35, 0x0b, 0x00, 0x00, 0x00,
                                       // mov rdx, len_to_be_filled
                                       0x48, 0xc7, 0xc2, 0x00, 0x00, 0x00, 0x00,
                                       // syscall
                                       0x0f, 0x05,
                                       // pop rbp
                                       0x5d,
                                       // ret
                                       0xc3
    };
    auto size = str.size();
    machine_code[28] = (size & 0x000000FF) >> 0;
    machine_code[29] = (size & 0x0000FF00) >> 8;
    machine_code[30] = (size & 0x00FF0000) >> 16;
    machine_code[31] = (size & 0xFF000000) >> 24;

    for (auto ch : str) {
        machine_code.emplace_back(ch);
    }

    size_t real_size = round_up_page_size(size);
    uint8_t *mem =
        (uint8_t *)mmap(nullptr, real_size, PROT_WRITE,
                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    for (size_t i = 0;i < machine_code.size();i++) {
        mem[i] = machine_code[i];
    }

    mprotect(mem, real_size, PROT_EXEC);

    void (*func)();
    func = (void (*)())mem;
    func();

    munmap(mem, real_size);
}

int main() {
    print("Hello, world!");
    return 0;
}
