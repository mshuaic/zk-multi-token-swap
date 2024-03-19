// SPDX-License-Identifier: GPL-3.0
/*
    Copyright 2021 0KIMS association.

    This file is generated with [snarkJS](https://github.com/iden3/snarkjs).

    snarkJS is a free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    snarkJS is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
    or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
    License for more details.

    You should have received a copy of the GNU General Public License
    along with snarkJS. If not, see <https://www.gnu.org/licenses/>.
*/

pragma solidity >=0.7.0 <0.9.0;

contract Groth16Verifier10 {
    // Scalar field size
    uint256 constant r    = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    // Base field size
    uint256 constant q   = 21888242871839275222246405745257275088696311157297823662689037894645226208583;

    // Verification Key data
    uint256 constant alphax  = 20491192805390485299153009773594534940189261866228447918068658471970481763042;
    uint256 constant alphay  = 9383485363053290200918347156157836566562967994039712273449902621266178545958;
    uint256 constant betax1  = 4252822878758300859123897981450591353533073413197771768651442665752259397132;
    uint256 constant betax2  = 6375614351688725206403948262868962793625744043794305715222011528459656738731;
    uint256 constant betay1  = 21847035105528745403288232691147584728191162732299865338377159692350059136679;
    uint256 constant betay2  = 10505242626370262277552901082094356697409835680220590971873171140371331206856;
    uint256 constant gammax1 = 11559732032986387107991004021392285783925812861821192530917403151452391805634;
    uint256 constant gammax2 = 10857046999023057135944570762232829481370756359578518086990519993285655852781;
    uint256 constant gammay1 = 4082367875863433681332203403145435568316851327593401208105741076214120093531;
    uint256 constant gammay2 = 8495653923123431417604973247489272438418190587263600148770280649306958101930;
    uint256 constant deltax1 = 2872069335748451795202904729458912402170097855222465770309127691831268529220;
    uint256 constant deltax2 = 12522618695770358860810646570810609305868404289144974392648964996017609263942;
    uint256 constant deltay1 = 5459149544215504213719420883026572326132101257804827095610013872027826491440;
    uint256 constant deltay2 = 19162712086530345158308529845085858384195581174210552867285899515350216439770;

    
    uint256 constant IC0x = 5944086266486999470962641951109334738305383501477452680202137221419532336032;
    uint256 constant IC0y = 2284193396405192641008929151568016205532088523468504888088084032224516351390;
    
    uint256 constant IC1x = 8353675218313145149480270425597685452969751708281836156491170448442624244659;
    uint256 constant IC1y = 14739165711002216945116759558004114905312299839001674385525616690089678008109;
    
    uint256 constant IC2x = 17710419779294073590160718442804493450276744435836135631850418250301928527026;
    uint256 constant IC2y = 8792281557244290707420573334153526768211179175229033697311983644633538273077;
    
    uint256 constant IC3x = 16387926719372170769516184828592553585528190497470273929060880729583122659131;
    uint256 constant IC3y = 7245185964082547652787736005714549264879023857884331433396204620339343338543;
    
    uint256 constant IC4x = 17383336950910662440158470453663772133726516249973224287676729613584429747384;
    uint256 constant IC4y = 14799971963215774963662292042043756622187285908327041804283162376964237617827;
    
    uint256 constant IC5x = 1227026011031827067107135527296113994798521391507267675054612172675822222641;
    uint256 constant IC5y = 10698195718385268234851280429631497598381717031591133546350385187349899570477;
    
    uint256 constant IC6x = 511201123731731303488297516460080819835995172492719825437321635783691990176;
    uint256 constant IC6y = 8967272912286139185792682711474978031435368943793664103438063039541654092281;
    
    uint256 constant IC7x = 3893406978156101527224134985146049840744305336453019294444021766238105979120;
    uint256 constant IC7y = 11226440096597132446223767258249839543299468771385495203367937045647889733412;
    
    uint256 constant IC8x = 7392972826483681654441453486380260829777411932674313448577431657311126416505;
    uint256 constant IC8y = 9751303435248029586908408020213904652443874010202157154216059819948834839357;
    
    uint256 constant IC9x = 20549343516206888287060485138268187372380045663638875869289532489223101535417;
    uint256 constant IC9y = 6771919314609405777394754832040056699639630570710200179654527043132757573237;
    
    uint256 constant IC10x = 20610333348233539615176544649172271485512468542976282100408508426868702186189;
    uint256 constant IC10y = 248757820011610760429290718094693522146626891803654108484441764406429306941;
    
    uint256 constant IC11x = 16765195369799747516603975539007952728644593210660618401470159725591885029402;
    uint256 constant IC11y = 18173836240763691957985447446349892857140766306313259847319783205274916687397;
    
    uint256 constant IC12x = 19899005235293471878329860371223841950704509038197008744840299106766545000414;
    uint256 constant IC12y = 17585194129027396459256114524596223490563055407313982857253492962797126920543;
    
    uint256 constant IC13x = 13889970014054007122433981227737565073058592943281013421028810989700369279126;
    uint256 constant IC13y = 15573117586229745959213738217968244696497985157152572730135287231939750564187;
    
    uint256 constant IC14x = 14329686630740426772911803224342661249317216594721986954791999529094414739022;
    uint256 constant IC14y = 448068616728546261519336143714812390957959962435512665238198599817175414370;
    
    uint256 constant IC15x = 2154515685268748643427237419643466633381435696281683789803052242176338874017;
    uint256 constant IC15y = 13563800529697588047939801057771698773178218435557712291525424065281068752763;
    
    uint256 constant IC16x = 17149196675792945775743583056268557420250737514349173765954391503367415549433;
    uint256 constant IC16y = 10316112012963405076656126354034630740866953487971559007074568565393531948871;
    
    uint256 constant IC17x = 15560321476690111371726457663446480440692955315951501365431959751159090954524;
    uint256 constant IC17y = 4917695715061389791571397021527049556167867755942335344158993622336321621343;
    
    uint256 constant IC18x = 6140545680705619434364696038419943027165608608579744339528138363584207810035;
    uint256 constant IC18y = 16130644241831478318886330872689977244108193689078220105108056917187153464807;
    
    uint256 constant IC19x = 3861491314242102294654077016543754112110944584035652463330769224377662430301;
    uint256 constant IC19y = 20942089950737856231991328468015992265608428426022792907807628640807588269945;
    
 
    // Memory data
    uint16 constant pVk = 0;
    uint16 constant pPairing = 128;

    uint16 constant pLastMem = 896;

    function verifyProof(uint[2] calldata _pA, uint[2][2] calldata _pB, uint[2] calldata _pC, uint[19] calldata _pubSignals) public view returns (bool) {
        assembly {
            function checkField(v) {
                if iszero(lt(v, q)) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }
            
            // G1 function to multiply a G1 value(x,y) to value in an address
            function g1_mulAccC(pR, x, y, s) {
                let success
                let mIn := mload(0x40)
                mstore(mIn, x)
                mstore(add(mIn, 32), y)
                mstore(add(mIn, 64), s)

                success := staticcall(sub(gas(), 2000), 7, mIn, 96, mIn, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }

                mstore(add(mIn, 64), mload(pR))
                mstore(add(mIn, 96), mload(add(pR, 32)))

                success := staticcall(sub(gas(), 2000), 6, mIn, 128, pR, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }

            function checkPairing(pA, pB, pC, pubSignals, pMem) -> isOk {
                let _pPairing := add(pMem, pPairing)
                let _pVk := add(pMem, pVk)

                mstore(_pVk, IC0x)
                mstore(add(_pVk, 32), IC0y)

                // Compute the linear combination vk_x
                
                g1_mulAccC(_pVk, IC1x, IC1y, calldataload(add(pubSignals, 0)))
                
                g1_mulAccC(_pVk, IC2x, IC2y, calldataload(add(pubSignals, 32)))
                
                g1_mulAccC(_pVk, IC3x, IC3y, calldataload(add(pubSignals, 64)))
                
                g1_mulAccC(_pVk, IC4x, IC4y, calldataload(add(pubSignals, 96)))
                
                g1_mulAccC(_pVk, IC5x, IC5y, calldataload(add(pubSignals, 128)))
                
                g1_mulAccC(_pVk, IC6x, IC6y, calldataload(add(pubSignals, 160)))
                
                g1_mulAccC(_pVk, IC7x, IC7y, calldataload(add(pubSignals, 192)))
                
                g1_mulAccC(_pVk, IC8x, IC8y, calldataload(add(pubSignals, 224)))
                
                g1_mulAccC(_pVk, IC9x, IC9y, calldataload(add(pubSignals, 256)))
                
                g1_mulAccC(_pVk, IC10x, IC10y, calldataload(add(pubSignals, 288)))
                
                g1_mulAccC(_pVk, IC11x, IC11y, calldataload(add(pubSignals, 320)))
                
                g1_mulAccC(_pVk, IC12x, IC12y, calldataload(add(pubSignals, 352)))
                
                g1_mulAccC(_pVk, IC13x, IC13y, calldataload(add(pubSignals, 384)))
                
                g1_mulAccC(_pVk, IC14x, IC14y, calldataload(add(pubSignals, 416)))
                
                g1_mulAccC(_pVk, IC15x, IC15y, calldataload(add(pubSignals, 448)))
                
                g1_mulAccC(_pVk, IC16x, IC16y, calldataload(add(pubSignals, 480)))
                
                g1_mulAccC(_pVk, IC17x, IC17y, calldataload(add(pubSignals, 512)))
                
                g1_mulAccC(_pVk, IC18x, IC18y, calldataload(add(pubSignals, 544)))
                
                g1_mulAccC(_pVk, IC19x, IC19y, calldataload(add(pubSignals, 576)))
                

                // -A
                mstore(_pPairing, calldataload(pA))
                mstore(add(_pPairing, 32), mod(sub(q, calldataload(add(pA, 32))), q))

                // B
                mstore(add(_pPairing, 64), calldataload(pB))
                mstore(add(_pPairing, 96), calldataload(add(pB, 32)))
                mstore(add(_pPairing, 128), calldataload(add(pB, 64)))
                mstore(add(_pPairing, 160), calldataload(add(pB, 96)))

                // alpha1
                mstore(add(_pPairing, 192), alphax)
                mstore(add(_pPairing, 224), alphay)

                // beta2
                mstore(add(_pPairing, 256), betax1)
                mstore(add(_pPairing, 288), betax2)
                mstore(add(_pPairing, 320), betay1)
                mstore(add(_pPairing, 352), betay2)

                // vk_x
                mstore(add(_pPairing, 384), mload(add(pMem, pVk)))
                mstore(add(_pPairing, 416), mload(add(pMem, add(pVk, 32))))


                // gamma2
                mstore(add(_pPairing, 448), gammax1)
                mstore(add(_pPairing, 480), gammax2)
                mstore(add(_pPairing, 512), gammay1)
                mstore(add(_pPairing, 544), gammay2)

                // C
                mstore(add(_pPairing, 576), calldataload(pC))
                mstore(add(_pPairing, 608), calldataload(add(pC, 32)))

                // delta2
                mstore(add(_pPairing, 640), deltax1)
                mstore(add(_pPairing, 672), deltax2)
                mstore(add(_pPairing, 704), deltay1)
                mstore(add(_pPairing, 736), deltay2)


                let success := staticcall(sub(gas(), 2000), 8, _pPairing, 768, _pPairing, 0x20)

                isOk := and(success, mload(_pPairing))
            }

            let pMem := mload(0x40)
            mstore(0x40, add(pMem, pLastMem))

            // Validate that all evaluations ∈ F
            
            checkField(calldataload(add(_pubSignals, 0)))
            
            checkField(calldataload(add(_pubSignals, 32)))
            
            checkField(calldataload(add(_pubSignals, 64)))
            
            checkField(calldataload(add(_pubSignals, 96)))
            
            checkField(calldataload(add(_pubSignals, 128)))
            
            checkField(calldataload(add(_pubSignals, 160)))
            
            checkField(calldataload(add(_pubSignals, 192)))
            
            checkField(calldataload(add(_pubSignals, 224)))
            
            checkField(calldataload(add(_pubSignals, 256)))
            
            checkField(calldataload(add(_pubSignals, 288)))
            
            checkField(calldataload(add(_pubSignals, 320)))
            
            checkField(calldataload(add(_pubSignals, 352)))
            
            checkField(calldataload(add(_pubSignals, 384)))
            
            checkField(calldataload(add(_pubSignals, 416)))
            
            checkField(calldataload(add(_pubSignals, 448)))
            
            checkField(calldataload(add(_pubSignals, 480)))
            
            checkField(calldataload(add(_pubSignals, 512)))
            
            checkField(calldataload(add(_pubSignals, 544)))
            
            checkField(calldataload(add(_pubSignals, 576)))
            
            checkField(calldataload(add(_pubSignals, 608)))
            

            // Validate all evaluations
            let isValid := checkPairing(_pA, _pB, _pC, _pubSignals, pMem)

            mstore(0, isValid)
             return(0, 0x20)
         }
     }
 }
