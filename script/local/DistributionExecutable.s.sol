// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../../src/call-contract-with-token/DistributionExecutable.sol";
import "./NetworkDetailsBase.sol";

contract DistributionExecutableScript is Script, NetworkDetailsBase {
    DistributionExecutable public distributionExecutable;

    function run() public {
        string memory network = vm.envString("NETWORK");

          // Retrieve the private key directly from environment variables
        string memory privateKeyHex = vm.envString("LOCAL_PRIVATE_KEY");

        // Basic validation to check if the private key is empty
        if (bytes(privateKeyHex).length == 0) {
            revert("LOCAL_PRIVATE_KEY is not set in the environment variables.");
        }

        // Convert the hexadecimal private key to a uint256
        uint256 privateKey = uint256(bytes32(vm.parseBytes(privateKeyHex)));

        (address gateway, address gasService) = getNetworkDetails(network); 

        vm.startBroadcast(privateKey);
        distributionExecutable = new DistributionExecutable(gateway, gasService);
        vm.stopBroadcast();
    }
}
