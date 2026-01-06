# jq -n \
#   --slurpfile old old.json \
#   --slurpfile new new.json '
#   $old[0].data
#   | to_entries
#   | map(
#       select(.value.version != $new[0].data[.key].version)
#       | {
#           name: .key,
#           old: .value,
#           new: $new[0].data[.key]
#         }
#     )
# '

# jq -n \
#   --slurpfile old old.json \
#   --slurpfile new new.json '.data | to_entries | map(select(.value.version != $old.data[.key].version)) | map(.key)'


jq --compact-output --raw-output --monochrome-output --argjson old "$(<old.json)" \
  '.data | to_entries | map(select(.value.version != $old.data[.key].version)) | map(.key)' \
  new.json
