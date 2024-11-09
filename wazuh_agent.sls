# https://documentation.wazuh.com/current/installation-guide/wazuh-agent/wazuh-agent-package-linux.html#deploying-wazuh-agents-on-linux-endpoints
# Make sure to set Pillar data to include the Wazuh server hostname
{% set wazuh_server = salt['pillar.get']('wazuh:server') %}
{% set wazuh_version = '4.9.2' %}

wazuh-agent:
  pkg.installed:
    - sources:
      - wazuh-agent: https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_{{ wazuh_version }}-1_amd64.deb
    - env:
      - WAZUH_MANAGER: {{ wazuh_server }}

wazuh-agent-service:
  service.running:
    - name: wazuh-agent
    - enable: True
    - require:
      - pkg: wazuh-agent