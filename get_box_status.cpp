#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <array>
#include <vector>
#include <string>
#include <fstream>

using namespace std;

std::array<std::string, 2> get_config()
{
#ifndef DEBUG
    system("fbwfmgr /displayconfig > config.txt");
#else
    if (is_first)
    {
        is_first = false;
        return std::array<std::string, 2>{"enabled", "enabled"};
    }
    else
    {
        return std::array<std::string, 2>{"enabled", "disabled"};
    }
#endif
    std::ifstream in;
    in.open("config.txt");
    std::string word;
    std::string state1, state2;
    bool first = true;
    while (!in.eof())
    {
        in >> word;
        if (word == "filter")
        {
            in >> word;
            if (word == "state:")
            {
                in >> word;
                if (first)
                {
                    state1 = word.substr(0, word.size() - 1);
                    first = false;
                }
                else
                {
                    state2 = word.substr(0, word.size() - 1);
                }
            }
        }
    }

    std::ofstream out;
    out.open("log.txt", std::ios::app);
    out << state1 << "\n"
        << state2 << "\n";

    return std::array<std::string, 2>{state1, state2};
}

void set_disabled()
{
    system("fbwfmgr /disable");
}

// 参考：https://baike.baidu.com/item/FBWF/6616467
void set_enabled()
{
    system("fbwfmgr /enable");
    system("fbwfmgr /addvolume C:");
    system("fbwfmgr /addvolume D:");
    system("fbwfmgr /addexclusion C:\\Temp");
    system("fbwfmgr /addexclusion D:\\Temp");
}

int main(int argc, char **argv)
{
    if (argc < 3)
    {
        return EXIT_FAILURE;
    }
    std::string command{argv[1]};
    if (command == "get")
    {
        auto i = std::stoi(argv[2]);
        auto result = get_config();
        cout << result[i];
        return EXIT_SUCCESS;
    }
    if (command == "set")
    {
        command = argv[2];
        if (command == "enabled")
        {
            set_enabled();
        }
        if (command == "disabled")
        {
            set_disabled();
        }
    }

    return EXIT_FAILURE;
}
