#!/usr/bin/env bash

interface_ipv4(){ ip -4 addr show ${1:?No interface provided} | awk '/inet /{print $2}' | head -1; }
interface_ipv6() { ip -6 addr show ${1:?No interface provided} | awk '/inet6 /{print $2}' | head -1; }
