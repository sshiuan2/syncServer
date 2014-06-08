#!/bin/bash

create_cert(){
local args
local type=rsa:2048
local keyf=key.pem
local outf=cert.pem
local days=1000

local to=/root

cd $to
openssl req -x509 -newkey $type -keyout $keyf -out $outf -days $days
}

create_cert
