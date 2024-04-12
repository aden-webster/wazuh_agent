#       https://documentation.wazuh.com/current/installation-guide/wazuh-agent/wazuh-agent-package-linux.html#deploying-wazuh-agents-on-linux-endpoints
download_wazuh_agent:
  cmd.run:
    - name: wget -O /root/wazuh-agent_4.7.3-1_amd64.deb https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.7.3-1_amd64.deb
    - unless: dpkg -l | grep wazuh

{% set wazuh_server = salt['pillar.get']('wazuh:server') %}

install_wazuh_agent:
  cmd.run:
    - name: WAZUH_MANAGER='{{ wazuh_server }}' dpkg -i /root/wazuh-agent_4.7.3-1_amd64.deb
    - require:
      - cmd: download_wazuh_agent
    - unless: dpkg -l | grep wazuh

reload_systemctl:
  cmd.run:
    - name: systemctl daemon-reload
    - require:
      - cmd: install_wazuh_agent

enable_wazuh_agent:
  service.running:
    - enable: True
    - name: wazuh-agent
    - require:
      - cmd: reload_systemctl

start_wazuh_agent:
  service.running:
    - name: wazuh-agent
    - enable: True
