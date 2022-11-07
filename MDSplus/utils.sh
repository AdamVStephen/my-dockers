#!/usr/bin/env bash
#
# Common shell utilities for the install scripts

export MDSPLUS_KEY_SIGNATURE=5009E3F8CED51C1B

get_distro() {
	distro_id=$(grep "^ID=" /etc/os-release)
	# V1: fragile : Extract name from inside quotes
	#distro_id=${distro_id#*\"}
	#distro_id=${distro_id%*\"}
	# V2 more explicit : strip ID= prefix and any quotes
	distro_id=${distro_id#"ID="}
	distro_id=$(echo "$distro_id" | tr -d '"')
	# V1: Likewise for version
	distro_version=$(grep "^VERSION_ID" /etc/os-release)
	#distro_version=${distro_version#*\"}
	#distro_version=${distro_version%*\"}
	# V2 more explicit
	distro_version=${distro_version#"VERSION_ID="}
	distro_version=$(echo "$distro_version" | tr -d '"')
	distro_version=$(echo "$distro_version" | tr -d '[:punct:]')
	echo "${distro_id}${distro_version}"
}
	

# Install the correct MDSplus repo data in /etc/apt/sources.list.d/mdsplus.list

configure_mdsplus_list(){
  distro=$(get_distro)
  case "$distro" in
    ubuntu1804)
      sh -c "echo 'deb [arch=amd64] http://www.mdsplus.org/dist/Ubuntu18/repo MDSplus stable' > /etc/apt/sources.list.d/mdsplus.list"
      ;;
    ubuntu2004)
      sh -c "echo 'deb [arch=amd64] http://www.mdsplus.org/dist/Ubuntu20/repo MDSplus stable' > /etc/apt/sources.list.d/mdsplus.list"
      ;;
    ubuntu2204)
      sh -c "echo 'deb [arch=amd64] http://www.mdsplus.org/dist/Ubuntu22/repo MDSplus stable' > /etc/apt/sources.list.d/mdsplus.list"
      ;;
    *)
      ;;
  esac

}

if [ $# -ge 1 ]
then
  cmd="$1"
  case "$cmd" in
    configure_mdsplus_list)
      configure_mdsplus_list
      ;;
    *)
      ;;
  esac
fi

