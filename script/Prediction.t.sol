// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/Prediction.sol";
import "forge-std/Vm.sol";
import "forge-std/console.sol";

contract PredictionTest is Test, Predictions{

    Predictions public prediction;
    // vm.startPrank(0x18d1161FaBAC4891f597386f0c9B932E3fD3A1FD);

    function setUp() public {
        prediction = new Predictions();
    }

    function run() public {
        vm.broadcast();
    }

    // function testCreatePrediction() public {
        
    //     uint _proposalId = 1;
    //     string memory _description = "pred";
    //     uint _likelihood= 4;
    //     uint _pollId = 1;
     
    //     // bool success = prediction.createPrediction(_proposalId, _description, _likelihood, _pollId);
       
    //     // console.log(success);

    // }
    
}