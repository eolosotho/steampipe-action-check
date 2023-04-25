#!/bin/bash


PLUGIN_NAME=terraform

steampipe query "select 1"

setup_plugin()
{
  steampipe plugin install "$PLUGIN_NAME"

  connection_data="
connection \"terraform\" {
  plugin = \"terraform\"
  paths = [ \"$INPUT_PATHS/**/*.tf\" ]
}
"

  # Add config file
  printf '%s\n' "$connection_data" > "/home/steampipe/.steampipe/config/terraform.spc"
  printf '%s\n' "Wrote connection file:"
  cat /home/steampipe/.steampipe/config/terraform.spc
  printf '%s\n' "<<<<<<<<<<<<<<<<<<<<<<"
}

assoc_array=()
# my_array=("element1" "element2" "element3")


run_infra_check() {
  if [ -z $INPUT_RUN ]
  then
    VAR_ALL = "all"
    assoc_array+= steampipe check control.dynamodb_table_encrypted_with_kms_cmk --output=json --mod-location=/workspace
  else
    while read line; do
      assoc_array+= steampipe check control.dynamodb_table_encrypted_with_kms_cmk --output=json --mod-location=/workspace
    done <<EOF
$INPUT_RUN
EOF
  fi
}





  # if steampipe check $RunList --output=none --export=json --mod-location=$GITHUB_WORKSPACE
  # then
  #   echo "S"
  # else
  #   echo "F"
  # fi

setup_plugin
git clone --depth 1 $INPUT_MOD_URL /workspace
run_infra_check
node /js-app/index.js $assoc_array

# echo $assoc_array
