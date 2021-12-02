#!/bin/bash
set -e

##############################################################################
### STEP 0. SET YOUR ACCOUNT
##############################################################################
MASTER_ACC=tjtc.near
DAO_ROOT_ACC=sputnik-dao.near
DAO_NAME=croncat
DAO_ACCOUNT=$DAO_NAME.$DAO_ROOT_ACC
CROSS_DAO_ACCOUNT=cheddarcatz.$DAO_ROOT_ACC

export NEAR_ENV=mainnet


# ##############################################################################
# ### STEP 1. Create the Payout Proposals
# ##############################################################################

### --------------------------------
### NEAR PAYOUT AMOUNTS
### --------------------------------
base_zeroes="0000000000000000000000000"
payout_amounts=("2" "1" "1" "1" "1" "1" "1" "1" "1")
token_id=
accounts=("bpc9unit.near" "avula.near" "adam7.near" "raul0287.near" "2bangio.near" "jang13.near" "mayokinney88818.near" "vtv3.near")
descriptions=("Best Use of CheddarCatz" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner")


# Loop All Winners and submit proposals
for (( c=0; c<=${#accounts[@]} - 1; c++ ))
do
  echo "PROPOSAL FOR WINNER: ${accounts[c]} ${payout_amounts[c]}${base_zeroes} ${descriptions[c]}"
  # The payout proposal
  SUB_ADD_PROPOSAL=`echo "{\"proposal\": { \"description\": \"${descriptions[c]}\", \"kind\": { \"Transfer\": { \"token_id\": \"$token_id\", \"receiver_id\": \"${accounts[c]}\", \"amount\": \"${payout_amounts[c]}${base_zeroes}\" } } } }" | base64`
  FIXED_SUB_ARGS=`echo $SUB_ADD_PROPOSAL | tr -d '\r' | tr -d ' '`

  ## Dao can create a payout proposal on another DAO
  near call $DAO_ACCOUNT add_proposal '{
    "proposal": {
      "description": "Add proposal to CheddarCatz for Winner Payout (Winner '${accounts[c]}')",
      "kind": {
        "FunctionCall": {
          "receiver_id": "'$CROSS_DAO_ACCOUNT'",
          "actions": [
            {
              "method_name": "add_proposal",
              "args": "'$FIXED_SUB_ARGS'",
              "deposit": "1000000000000000000000000",
              "gas": "30000000000000"
            }
          ]
        }
      }
    }
  }' --accountId $MASTER_ACC --amount 0.1
done


# ##############################################################################
# ### STEP 2. Create the Action Proposals
# ##############################################################################

# # Loop All Action IDs and submit as proposals
# actions=(0 1 2 3 4 5 6 7)
# for (( d=0; d<=${#actions[@]} - 1; d++ ))
# do
#   action_type="VoteApprove"
#   # action_type="VoteReject"
#   # action_type="VoteRemove"
#   SUB_ACT_PROPOSAL=`echo "{\"id\": ${actions[d]}, \"action\" :\"${action_type}\"}" | base64`
#   FIXED_SUB_ARGS=`echo $SUB_ACT_PROPOSAL | tr -d '\r' | tr -d ' '`
#   echo "Payload ${SUB_ACT_PROPOSAL}"

#   # ## Dao can create a payout proposal on another DAO
#   # near call $DAO_ACCOUNT add_proposal '{
#   #   "proposal": {
#   #     "description": "Add proposal to CheddarCatz for '${action_type}' action",
#   #     "kind": {
#   #       "FunctionCall": {
#   #         "receiver_id": "'$CROSS_DAO_ACCOUNT'",
#   #         "actions": [
#   #           {
#   #             "method_name": "act_proposal",
#   #             "args": "'$FIXED_SUB_ARGS'",
#   #             "deposit": "0",
#   #             "gas": "30000000000000"
#   #           }
#   #         ]
#   #       }
#   #     }
#   #   }
#   # }' --accountId $MASTER_ACC --amount 0.1
# done


# ##############################################################################
# ### STEP 3. Make your personal votes
# ##############################################################################

# # Loop All Action IDs and submit action
# vote_actions=(70 71)
# for (( e=0; e<=${#vote_actions[@]} - 1; e++ ))
# do
#   action="VoteApprove"
#   # action="VoteReject"
#   # action="VoteRemove"
#   SUB_ACT_PROPOSAL=`echo "{\"id\": ${vote_actions[e]}, \"action\" :\"${action}\"}"`
#   echo "Payload ${SUB_ACT_PROPOSAL}"

#   near call $DAO_ACCOUNT act_proposal '{"id": '${vote_actions[e]}', "action" :"'${action}'"}' --accountId $MASTER_ACC  --gas 300000000000000
# done
