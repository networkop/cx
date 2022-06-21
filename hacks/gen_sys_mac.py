#!/usr/bin/python

import cumulus.platforms
import cumulus.portconfig
import sys

MAX_INTFS=128

if __name__ == '__main__':
    platform = cumulus.platforms.probe()

    pc = cumulus.portconfig.Config(platform)
    pc.system_mac = pc.makemacaddr(pc.macbase, MAX_INTFS)
    pc.write_system_mac()
    sys.exit(0)

