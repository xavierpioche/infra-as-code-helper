#!/bin/bash
mkdir /etc/etcd /var/lib/etcd
cd /tmp
export RELEASE=$(curl -s https://api.github.com/repos/etcd-io/etcd/releases/latest|grep tag_name | cut -d '"' -f 4) 
wget https://github.com/etcd-io/etcd/releases/download/${RELEASE}/etcd-${RELEASE}-linux-amd64.tar.gz
tar xvf etcd-${RELEASE}-linux-amd64.tar.gz
cd etcd-${RELEASE}-linux-amd64
mv etcd etcdctl etcdutl /usr/local/bin
groupadd --system etcd
useradd -s /sbin/nologin --system -g etcd etcd
chown -R etcd:etcd /var/lib/etcd/
mv /tmp/ca.pem /tmp/kubernetes.pem /tmp/kubernetes-key.pem /etc/etcd
