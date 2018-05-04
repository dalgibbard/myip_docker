<?php
function ip_is_public ($ip) {
    $pri_addrs = array (
                      '10.0.0.0|10.255.255.255', // single class A network
                      '172.16.0.0|172.31.255.255', // 16 contiguous class B network
                      '192.168.0.0|192.168.255.255', // 256 contiguous class C network
                      '169.254.0.0|169.254.255.255', // Link-local address also refered to as Automatic Private IP Addressing
                      '127.0.0.0|127.255.255.255' // localhost
                     );

    $long_ip = ip2long ($ip);
    if ($long_ip != -1) {

        foreach ($pri_addrs AS $pri_addr) {
            list ($start, $end) = explode('|', $pri_addr);

             // IF IS PRIVATE
             if ($long_ip >= ip2long ($start) && $long_ip <= ip2long ($end)) {
                 return false;
             }
        }
    }

    return true;
};

if (isset ($_SERVER["HTTP_X_FORWARDED_FOR"])){
    if (ip_is_private($_SERVER["HTTP_X_FORWARDED_FOR"])){
        $IP = $_SERVER["HTTP_X_FORWARDED_FOR"];
    } else {
        $IP = $_SERVER["REMOTE_ADDR"];
    }
} else {
    $IP = $_SERVER["REMOTE_ADDR"];
}
echo $IP;
?>
