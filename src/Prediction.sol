// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './Polls.sol';

contract Predictions is Polls{
 
    bool predictionFinished = false;

    mapping(uint => Prediction[]) public predictions;
    
    Polls pollsInstance = new Polls();

    event PredictionCreated(string prediction, uint likelihood);

    struct Prediction{
        uint pollId;
        uint proposalId;
        uint predictionId;
        string prediction;
        uint likelihood;
        uint yesBets;
        uint noBets;
    }
    function requireProposalToExist(uint _pollId, uint _proposalId) public view returns (bool){
        for (uint i=0; i <= proposals[_pollId].length;i++){
           
          if (proposals[_pollId][i].proposalId==_proposalId) {
            return true;
          }
        }
        return false;
    }

    function createPrediction(
        uint _pollId, 
        uint _proposalId,
        string memory _prediction,
        uint _likelihood
        
        ) public{
            
            Proposal storage proposal = proposals[_pollId][_proposalId -1]; // Get the proposal from the proposals mapping
            require(requireProposalToExist(_pollId, _proposalId));

            proposal.predictionCount++; //Increment by one
            uint _predictionId = proposal.predictionCount; // Set prediction id

            proposals[_pollId][_proposalId -1] = proposal; // Update mapping
   

            predictions[_proposalId].push(Prediction({
                pollId: _pollId,
                proposalId: _proposalId,
                predictionId: _predictionId,
                prediction: _prediction,
                likelihood: _likelihood,
                yesBets:0,
                noBets:0
                
            }));
            emit PredictionCreated(_prediction, _likelihood);
    }

     function requirePredictionToExist(uint _pollId, uint _proposalId, uint _predictionId) internal view returns (bool){

        for (uint a=0; a <= proposals[_pollId].length; a++){
            if (proposals[_pollId][a].proposalId ==_proposalId){
                for (uint b=0; b <= predictions[_proposalId].length;i++){   
                    if (predictions[_proposalId][b].predictionId ==_predictionId)
                    return true;
                    }  
                 }
            return false;  
        }
    }
    
    function getPredictions(uint _proposalId) external view returns(Prediction[] memory) {
        return predictions[_proposalId];
    }

    function placePredictionBet(
        uint _pollId,
        uint _proposalId,
        uint _predictionId,
        bool _bet

    )  external {

            Proposal storage proposal = proposals[_pollId][_proposalId -1];
            //proposal.predictions
             
            // get poll -  get proposal - get prediction

            

        require(!predictionFinished, "Prediction is finished");
        require(requirePredictionToExist(_pollId, _proposalId, _predictionId), "Prediction does not exist"); 


        if (_bet)
            predictions[_proposalId][_predictionId-1].yesBets++; //POLLID behövs
        else if(!_bet)
            predictions[_proposalId][_predictionId-1].noBets++;
             


        // if (_yesBets > 1 || _noBets > 1)
        //     revert("Input must be 1");
        // else if(_yesBets==0 && _noBets==0)
        //     revert("Please place bet");
        // else if(_yesBets==1 && _noBets==1)
        //     revert("Please bet yes or no");
        // else if(_yesBets==1 && _noBets==0)
        //     predictions[_proposalId][_predictionId-1].yesBets += _yesBets; 
        // else if(_yesBets==0 && _noBets==1)
        //     predictions[_proposalId][_predictionId-1].noBets += _noBets;  
    }

    // function getResult(uint _proposalId, uint _predictionId) external view returns (string memory winner){
    //     require(predictionFinished == true, "Prediction is not finished");
    //     if (predictions[_proposalId][_predictionId-1].yesBets > predictions[_proposalId][_predictionId-1].noBets){
    //         return "Yes";                               
    //     }else if(predictions[_proposalId][_predictionId-1].yesBets < predictions[_proposalId][_predictionId-1].noBets){
    //         return "No";                                     
    //     }
    //     else if(predictions[_proposalId][_predictionId-1].yesBets < predictions[_proposalId][_predictionId-1].noBets){
    //         return "Tie";
    //     }
    // }

    function predictionIsFinished() internal {
        predictionFinished = true;
    }

}