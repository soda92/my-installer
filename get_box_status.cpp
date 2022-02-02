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

int main(int argc, char **argv)
{
    auto result = get_config();
    if (argc < 2)
    {
        return EXIT_FAILURE;
    }
    auto i = std::stoi(argv[1]);
    cout << result[i];
    return EXIT_SUCCESS;
}
