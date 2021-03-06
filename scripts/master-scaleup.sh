#!/usr/bin/env bash
set -euxo pipefail

source ansible/hacking/env-setup

source build_options.sh

${PYTHON} $(which ansible) --version

${PYTHON} $(which ansible-inventory) -i inventory/hosts --list --yaml

playbook_base='openshift-ansible/playbooks'

echo "### Running OpenShift-Ansible Master Scaleup ###"
if [[ -s "${playbook_base}/openshift-master/scaleup.yml" ]]; then
    playbook="${playbook_base}/openshift-master/scaleup.yml"
else
    playbook="${playbook_base}/byo/openshift-master/scaleup.yml"
fi

time ${PYTHON} $(which ansible-playbook) -i inventory/hosts ${playbook} -vvv
