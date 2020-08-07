#!/usr/bin/env bash

# OpenSSL requires the port number
SERVER=$1
DELAY=1

# Test TLS1.0
protocol="tls1.0"
echo "Testing $protocol..."
result=$(echo -n | openssl s_client -connect $SERVER -tls1 2>&1)
if [[ "$?" -eq "1" ]] ; then
  if [[ "$result" =~ ":error" ]] ; then
    error=$(echo -n $result | cut -d':' -f6)
    echo "$protocol is disabled ($error)"
  elif [[ "$result" =~ ":errno=" ]] ; then
    error=$(echo -n $result | cut -d' ' -f1)
    echo "$protocol is disabled ($error)"
  else
    echo "error running the openssl scan ($result)"
  fi
else
  echo "$protocol is enabled"
fi
sleep $DELAY

# Test TLS1.1
protocol="tls1.1"
echo "Testing $protocol..."
result=$(echo -n | openssl s_client -connect $SERVER -tls1_1 2>&1)
if [[ "$?" -eq "1" ]] ; then
  if [[ "$result" =~ ":error" ]] ; then
    error=$(echo -n $result | cut -d':' -f6)
    echo "$protocol is disabled ($error)"
  elif [[ "$result" =~ ":errno=" ]] ; then
    error=$(echo -n $result | cut -d' ' -f1)
    echo "$protocol is disabled ($error)"
  else
    echo "error running the openssl scan ($result)"
  fi
else
  echo "$protocol is enabled"
fi
sleep $DELAY

# Test TLS1.2
protocol="tls1.2"
echo "Testing $protocol..."
result=$(echo -n | openssl s_client -connect $SERVER -tls1_2 2>&1)
if [[ "$?" -eq "1" ]] ; then
  if [[ "$result" =~ ":error" ]] ; then
    error=$(echo -n $result | cut -d':' -f6)
    echo "$protocol is disabled ($error)"
  elif [[ "$result" =~ ":errno=" ]] ; then
    error=$(echo -n $result | cut -d' ' -f1)
    echo "$protocol is disabled ($error)"
  else
    echo "error running the openssl scan ($result)"
  fi
else
  echo "$protocol is enabled"
fi
sleep $DELAY