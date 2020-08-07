# README
There are two scripts here to perform some tls scan to see if a webserver is using weak SSL protocol and weak cipher suite. This is intended for testing if a web server harderning is done correctly.

## Usage of cipherscan.sh:
This is a bash script fthat relies on openssl. If you have a mac, you can run it directly from your laptop. If you are on a windows laptop, you need to run it from a linux box or a machine that has bash and openssl installed.
This script expect one parameter which is the server:port, see example below
```bash
./cipherscan.sh computer01.yourdomain.com:443
```
Example output of the script
```bash
[blo@laptop tlsscan]$ ./cipherscan.sh computer01.yourdomain.com:443
Obtaining cipher list from OpenSSL 1.1.1g FIPS  21 Apr 2020.
Testing TLS_AES_256_GCM_SHA384...NO (SSL_CTX_set_cipher_list)
Testing TLS_CHACHA20_POLY1305_SHA256...NO (SSL_CTX_set_cipher_list)
Testing TLS_AES_128_GCM_SHA256...NO (SSL_CTX_set_cipher_list)
Testing TLS_AES_128_CCM_SHA256...NO (SSL_CTX_set_cipher_list)
Testing ECDHE-ECDSA-AES256-GCM-SHA384...NO (sslv3 alert handshake failure)
Testing ECDHE-RSA-AES256-GCM-SHA384...YES
Testing DHE-DSS-AES256-GCM-SHA384...NO (sslv3 alert handshake failure)
Testing DHE-RSA-AES256-GCM-SHA384...YES
```
To interpet the output, you need to know which cipher and hashing algo we are consider weak. In most of the case, you only want to enable AES and SHA2, the rest should be disabled. If thats the case, I am expecting any ciphersuit thats not using AES or SHA2 will result in ssl handshake failure.


## Usage of tlsscan.sh:
This is a bash script fthat relies on openssl. If you have a mac, you can run it directly from your laptop. If you are on a windows laptop, you need to run it from a linux box or a machine that has bash and openssl installed.
This script expect one parameter which is the server:port, see example below
```bash
./tlsscan.sh computer01.yourdomain.com:443
```
Example output of the script
```bash
[blo@laptop tlsscan]$ ./tlsscan.sh computer01.yourdomain.com:443
Testing tls1.0...
tls1.0 is disabled (Connection refused)
Testing tls1.1...
tls1.1 is disabled (Connection refused)
Testing tls1.2...
tls1.2 is enabled
```
This output is pretty straight forward to read. Our goal is to disable TLS1.0 and 1.1. So if you see the result is not matching the example output, means the harderning is not done correctly.

