#!/bin/bash
set -e

##############################################################################
### STEP 0. SET YOUR ACCOUNT (but do not comment this out)
##############################################################################
MASTER_ACC=YOUR_ACCOUNT_HERE.near
DAO_ROOT_ACC=sputnik-dao.near
DAO_NAME=cheddar
DAO_ACCOUNT=$DAO_NAME.$DAO_ROOT_ACC
CROSS_DAO_ACCOUNT=cheddarcatz.$DAO_ROOT_ACC

export NEAR_ENV=mainnet


# DONE!!!!!!!
# ##############################################################################
# ### STEP 1. Create the $NEAR Payout Proposals
# ##############################################################################

# ### --------------------------------
# ### NEAR PAYOUT AMOUNTS
# ### --------------------------------
# base_zeroes="0000000000000000000000000"
# payout_amounts=("5" "2" "2" "1" "1" "1" "1" "1" "1" "1" "1" "1" "1" "1")
# token_id=
# accounts=("dantochoicoin.near" "dank12ey.near" "xexilia.near" "bahai1808.near" "hien.near" "mr_free.near" "vuabongbong.near")
# descriptions=("Bestestest GIF" "Best Use of CheddarCatz" "Best Use of CheddarCatz" "Most Creative GIF" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner")


# # Loop All Winners and submit proposals
# for (( b=0; b<=${#accounts[@]} - 1; b++ ))
# do
#   echo "NEAR PROPOSAL FOR WINNER: ${accounts[b]} ${payout_amounts[b]}${base_zeroes} ${descriptions[b]}"
#   # The payout proposal
#   SUB_ADD_PROPOSAL=`echo "{\"proposal\": { \"description\": \"${descriptions[b]}\", \"kind\": { \"Transfer\": { \"token_id\": \"$token_id\", \"receiver_id\": \"${accounts[b]}\", \"amount\": \"${payout_amounts[b]}${base_zeroes}\" } } } }" | base64`
#   FIXED_SUB_ARGS=`echo $SUB_ADD_PROPOSAL | tr -d '\r' | tr -d ' '`

#   ## Dao can create a payout proposal on another DAO
#   near call $DAO_ACCOUNT add_proposal '{
#     "proposal": {
#       "description": "Add proposal to CheddarCatz for NEAR Winner Payout (Winner '${accounts[b]}')",
#       "kind": {
#         "FunctionCall": {
#           "receiver_id": "'$CROSS_DAO_ACCOUNT'",
#           "actions": [
#             {
#               "method_name": "add_proposal",
#               "args": "'$FIXED_SUB_ARGS'",
#               "deposit": "1000000000000000000000000",
#               "gas": "30000000000000"
#             }
#           ]
#         }
#       }
#     }
#   }' --accountId $MASTER_ACC --amount 1
# done


##############################################################################
### STEP 2. Create the $Cheddar Payout Proposals
##############################################################################

### --------------------------------
### CHEDDAR PAYOUT AMOUNTS
### --------------------------------
base_zeroes="0000000000000000000000000"
# payout_amounts=("50" "25" "25" "25" "25" "15" "15" "15" "15" "15" "15" "15" "15" "15" "15")
# token_id=token.cheddar.near
# accounts=("dantochoicoin.near" "bpc9unit.near" "dank12ey.near" "xexilia.near" "bahai1808.near" "hien.near" "mr_free.near" "vuabongbong.near" "avula.near" "adam7.near" "raul0287.near" "2bangio.near" "jang13.near" "mayokinney88818.near" "vtv3.near")
# descriptions=("Bestestest GIF" "Best Use of CheddarCatz" "Best Use of CheddarCatz" "Best Use of CheddarCatz" "Most Creative GIF" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner")

payout_amounts=("15" "15" "15" "15" "15" "15" "15" "15")
token_id=token.cheddar.near
accounts=("adam7.near" "raul0287.near" "2bangio.near" "jang13.near" "mayokinney88818.near" "vtv3.near")
descriptions=("Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner" "Top 10 Winner")


# Loop All Winners and submit proposals
for (( c=0; c<=${#accounts[@]} - 1; c++ ))
do
  echo "CHEDDAR PROPOSAL FOR WINNER: ${accounts[c]} ${payout_amounts[c]}${base_zeroes} ${descriptions[c]}"
  # The payout proposal
  SUB_ADD_PROPOSAL=`echo "{\"proposal\": { \"description\": \"${descriptions[c]}\", \"kind\": { \"Transfer\": { \"token_id\": \"$token_id\", \"receiver_id\": \"${accounts[c]}\", \"amount\": \"${payout_amounts[c]}${base_zeroes}\" } } } }" | base64`
  FIXED_SUB_ARGS=`echo $SUB_ADD_PROPOSAL | tr -d '\r' | tr -d ' '`

  ## Dao can create a payout proposal on another DAO
  near call $DAO_ACCOUNT add_proposal '{
    "proposal": {
      "description": "Add proposal to CheddarCatz for Cheddar Winner Payout (Winner '${accounts[c]}')",
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
  }' --accountId $MASTER_ACC --amount 1
done


# ##############################################################################
# ### STEP 3. Create the Action Proposals
# ### (Uncomment & Run this ONLY AFTER the other above proposals have PASSED)
# ### (You can then grab the IDs of the proposals and put into array on line 111)
# ##############################################################################

# # Loop All Action IDs and submit as proposals
# # TODO: CHANGE THESE!
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
# ### STEP 4. Make your personal votes
# ##############################################################################

# # Loop All Action IDs and submit action
# # TODO: CHANGE THESE TO WHATEVER YOU NEED!
# vote_actions=(0 1 2 3 4 5 6 7)
# for (( e=0; e<=${#vote_actions[@]} - 1; e++ ))
# do
#   action="VoteApprove"
#   # action="VoteReject"
#   # action="VoteRemove"
#   SUB_ACT_PROPOSAL=`echo "{\"id\": ${vote_actions[e]}, \"action\" :\"${action}\"}"`
#   echo "Payload ${SUB_ACT_PROPOSAL}"

#   near call $DAO_ACCOUNT act_proposal '{"id": '${vote_actions[e]}', "action" :"'${action}'"}' --accountId $MASTER_ACC  --gas 300000000000000
# done
