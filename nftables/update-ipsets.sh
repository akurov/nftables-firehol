#!/bin/sh

curl -s https://iplists.firehol.org/files/firehol_level1.netset -o /tmp/firehol_level1.netset
curl -s https://iplists.firehol.org/files/firehol_level2.netset -o /tmp/firehol_level2.netset
curl -s https://iplists.firehol.org/files/firehol_level3.netset -o /tmp/firehol_level3.netset

echo 'define firehol_level1 = {' > /tmp/firehol.include
sed '/^$/d;/^#/d;s/$/,/' /tmp/firehol_level1.netset >> /tmp/firehol.include
echo "}" >> /tmp/firehol.include

echo 'define firehol_level2 = {' >> /tmp/firehol.include
sed '/^$/d;/^#/d;s/$/,/' /tmp/firehol_level2.netset >> /tmp/firehol.include
echo "}" >> /tmp/firehol.include

echo 'define firehol_level3 = {' >> /tmp/firehol.include
sed '/^$/d;/^#/d;s/$/,/' /tmp/firehol_level3.netset >> /tmp/firehol.include
echo "}" >> /tmp/firehol.include

nft -f /etc/nftables/firehol.nft
