#!/bin/bash
# packages = cups

systemctl unmask cups || true
systemctl start cups
systemctl enable cups
