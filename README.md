# Wazuh Agent Salt State

Simple salt state that installs selfhosted Wazuh Agent v4.7.3-1 on Debian based machines. 

Uses Pillar to set the WAZUH_MANAGER environment variable so you will need to add your Wazuh server domain in a Pillar file and apply it to your state. 