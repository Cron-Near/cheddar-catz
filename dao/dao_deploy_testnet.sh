MASTER_ACC=ion.testnet
DAO_ROOT_ACC=sputnikv2.testnet
DAO_NAME=cheddar_catz_v4
DAO_ACCOUNT=$DAO_NAME.$DAO_ROOT_ACC

export NEAR_ENV=testnet

COUNCIL='["croncat.sputnikv2.testnet", "in.testnet"]'

#DAO Policy
export POLICY='{
  "roles": [
    {
      "name": "council",
      "kind": { "Group": '$COUNCIL' },
      "permissions": [
        "*:Finalize",
        "*:AddProposal",
        "*:VoteApprove",
        "*:VoteReject",
        "*:VoteRemove"
      ],
      "vote_policy": {}
    }
  ],
  "default_vote_policy": {
    "weight_kind": "RoleWeight",
    "quorum": "0",
    "threshold": [1, 1]
  },
  "proposal_bond": "100000000000000000000000",
  "proposal_period": "604800000000000",
  "bounty_bond": "100000000000000000000000",
  "bounty_forgiveness_period": "604800000000000"
}'

#Args for creating DAO in sputnik-factory2
# ARGS=`echo "{\"config\":  {\"name\": \"$DAO_NAME\", \"purpose\": \"Ephemeral DAO for a contest\", \"metadata\":\"\"}, \"policy\": $POLICY}" | base64`
ARGS=`echo "{\"config\":  {\"name\": \"$DAO_NAME\", \"purpose\": \"Ephemeral DAO for a contest\", \"metadata\":\"\"}, \"policy\": $COUNCIL}" | base64`
FIXED_ARGS=`echo $ARGS | tr -d '\r' | tr -d ' '`

# Call sputnik factory for deploying new dao with custom policy
near call $DAO_ROOT_ACC create "{\"name\": \"$DAO_NAME\", \"args\": \"$FIXED_ARGS\"}" --accountId $MASTER_ACC --amount 5 --gas 150000000000000
near view $DAO_ACCOUNT get_policy
echo "'$NEAR_ENV' Deploy Complete!"