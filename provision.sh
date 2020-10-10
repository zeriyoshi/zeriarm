#!/bin/sh

__SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"

if [ ! "$(whoami)" = "root" ]; then
    echo "Require root priviledges."
    exit 2
fi

if [ ! -e "${__SCRIPT_DIR}/secure/.git" ]; then
    echo "Require secure submodule initialize."
    exit 3
fi

__CURRENT_PROVISIONER=""
prvecho()
{
    echo "[${__CURRENT_PROVISIONER}]" ${@}
}

apt-get update && apt-get upgrade -y

__INSTALLED_PACKAGES="$(dpkg-query --show --showformat='${Package}\t${Status}\n' | awk 'BEGIN{FS="\t"}{if($2=="install ok installed") print $1}')"
for PACKAGE_NAME in $(ls "${__SCRIPT_DIR}/install_packages"); do
    echo "[${PACKAGE_NAME}] check install status..."
    if [ "$(echo "${__INSTALLED_PACKAGES}" | grep "^${PACKAGE_NAME}\$")" = "" ]; then
        echo "[${PACKAGE_NAME}] is not installed. install..."
        apt-get install -qy "${PACKAGE_NAME}"
        echo "[${PACKAGE_NAME}] installed."

        echo "[${PACKAGE_NAME}] provisioning start."
        ROOT_DIR="${__SCRIPT_DIR}"
        RESOURCE_DIR="${__SCRIPT_DIR}/resources"
        SHELLS_DIR="${__SCRIPT_DIR}/shells"
        SECURE_DIR="${__SCRIPT_DIR}/secure"
        __CURRENT_PROVISIONER="${PACKAGE_NAME}"
        . "${__SCRIPT_DIR}/install_packages/${PACKAGE_NAME}"

        echo "[${PACKAGE_NAME}] provisioning finished."
    fi
done

for PROVISION_SCRIPT in $(ls "${__SCRIPT_DIR}/provisions"); do
    echo "[provision] start \"${PROVISION_SCRIPT}\" ..."
    ROOT_DIR="${__SCRIPT_DIR}"
    RESOURCE_DIR="${__SCRIPT_DIR}/resources"
    SHELLS_DIR="${__SCRIPT_DIR}/shells"
    SECURE_DIR="${__SCRIPT_DIR}/secure"
    __CURRENT_PROVISIONER="${PROVISION_SCRIPT}"
    . "${__SCRIPT_DIR}/provisions/${PROVISION_SCRIPT}"
done

apt-get update && apt-get autoremove -y

echo '[provision] rebooting...'
reboot
