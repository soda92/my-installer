#include <boost/asio.hpp>
#include <thread>
#include <chrono>
#include <array>
using namespace std::literals;
using namespace std::chrono_literals;
using namespace std::literals::chrono_literals;

// https://gist.github.com/kaliatech/427d57cb1a8e9a8815894413be337cf9
int main()
{
    boost::asio::io_service ioc;
    boost::asio::serial_port port(ioc);
    // https://stackoverflow.com/a/13997758/12291425
    port.set_option(boost::asio::serial_port_base::baud_rate(9600));
    try
    {
        port.open("COM1");
    }
    catch(std::exception)
    {
        return EXIT_FAILURE;
    }
    std::array<uint8_t, 3> bytes{0x55, 0x88, 0x99};
    for (;;)
    {
        boost::asio::write(port, boost::asio::buffer(bytes.data(), bytes.size()));
        std::this_thread::sleep_for(10s);
    }
}