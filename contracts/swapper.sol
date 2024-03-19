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

contract Groth16Swapper {
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
    uint256 constant deltax1 = 11713036461447996583247380417007101325497016790211602072465641530050970429072;
    uint256 constant deltax2 = 9617996954318383710050284145389691211348392491854429291561276058465340989302;
    uint256 constant deltay1 = 18506746300976812280851319054700691049633456139709409425575551031854081869900;
    uint256 constant deltay2 = 19959161267921201444088880786050506115980757602793058940572930220638884088802;

    
    uint256 constant IC0x = 19987166747746642905635739613278196881937573124642699838209630460303438962675;
    uint256 constant IC0y = 2525012950348862947588734275031052369155665881426444945988275108801221989436;
    
    uint256 constant IC1x = 6705487057476767755857457053884546314707676679389179955470651328825500299375;
    uint256 constant IC1y = 1890362679211393993759431176235080012666975746496094421262159089467767524156;
    
    uint256 constant IC2x = 3456846569490699819034753743666324191167719303308124207474085144340448175618;
    uint256 constant IC2y = 8714127587293660108220965907558149893928714561248016464724050196400087751718;
    
    uint256 constant IC3x = 7610795738510672906723063359619224845801611012666383575509509952898049040389;
    uint256 constant IC3y = 15115465405346066474803990208552859417260158609019250887311545449593402404139;
    
    uint256 constant IC4x = 6373293497366367930807501453390136425376227237140961666791138832064456696846;
    uint256 constant IC4y = 561030868065439235552343020612015863695193044949899268400730397139186755625;
    
    uint256 constant IC5x = 8880602892198121813843003536185148747914899382791956147526267226442495051908;
    uint256 constant IC5y = 8880175143257787025384676477385330878327288028724644657420082344754457043539;
    
    uint256 constant IC6x = 16957329167219164588122419806300605402109397722285012183801741619655105746148;
    uint256 constant IC6y = 18804290068262473066154535333189595916332353124823947829045639714182643685483;
    
    uint256 constant IC7x = 7011271930444206199470326344643240034519312991410346328835873106616910719514;
    uint256 constant IC7y = 12326274090835661267397180754195617962190516519070393831953123607167479301594;
    
    uint256 constant IC8x = 11449717610854881569845891283957450510690302622491926683785898918876738957334;
    uint256 constant IC8y = 6978481630076772378519740346713517333614126680257237160398388406801240782719;
    
    uint256 constant IC9x = 10840204231902180841979895169399675791729132732564712600603026225875391336248;
    uint256 constant IC9y = 18707929185037740014719159544016324014758053267118797945221605079867720666907;
    
    uint256 constant IC10x = 5720666748633481712358524518689822552725902065909899533478948393275398732959;
    uint256 constant IC10y = 6495348241335423582852843786324127926223372786003321544813875458793275812672;
    
    uint256 constant IC11x = 16969313541220009387739691085612986627983222539035847214286612193530481536198;
    uint256 constant IC11y = 12831272223880809116982254405627061167151130192577538455562510931728914752068;
    
    uint256 constant IC12x = 38982656492963990142300831355727752970299393959497537476564495302011306343;
    uint256 constant IC12y = 766775283110011370743288720031739882518919168847544048808934259064497101835;
    
    uint256 constant IC13x = 21736860527720303845393611114997562870099659252602779878889991333350856290274;
    uint256 constant IC13y = 14690952403443182382653020189385546464023047826248143235346852147993243584997;
    
    uint256 constant IC14x = 19162192032956594492632623452607929822247418430534943079106053459228764084679;
    uint256 constant IC14y = 19722714566321016649881434949242862698119632538639035513123109910698012106966;
    
    uint256 constant IC15x = 13433295681759278763930956997642551032845784858883606971214270761300420084332;
    uint256 constant IC15y = 3658840299124053144794350184429688048493047198325553596691791495972415253058;
    
    uint256 constant IC16x = 10511688655171702021572353782733452674014385853372240188657393048580922279244;
    uint256 constant IC16y = 11674989642697427996539724648558366541038284297379835520217925198553597008395;
    
    uint256 constant IC17x = 16758123000402682444583305876387324313183642057493197504985892761601296348888;
    uint256 constant IC17y = 12739201963399138471316644862116300736057956871022415234300015890212423899123;
    
    uint256 constant IC18x = 7286519296336577344892613461565231696547378602351579606757435379753596770683;
    uint256 constant IC18y = 10199896252464826714411556204395147550247976556587092325968108830984438739578;
    
    uint256 constant IC19x = 1508849766824840462468449833477014749694970744398427019580780625016282761317;
    uint256 constant IC19y = 21631946292588953121635356002698983891593964633839709241122766321087336921275;
    
    uint256 constant IC20x = 14030315268421761161648869505778239564022284847096031270842597664617622365927;
    uint256 constant IC20y = 15373557791785429043302672208825667519244169594496949231013118034004816064780;
    
    uint256 constant IC21x = 20653580365568977273429269010194728552055632626135688388169032887838272907212;
    uint256 constant IC21y = 6784912136451963168583817987793234860503737140660949389675006565502191016880;
    
    uint256 constant IC22x = 19762994211431763432680785119129467437040128067628770777541695148115098398504;
    uint256 constant IC22y = 3784664227669307608545299439763223041525602807024463228330137195866831996890;
    
    uint256 constant IC23x = 2984506511324411985776340461092280863173651371628948832940827396657622774172;
    uint256 constant IC23y = 12112670628510474187180004127628719988754939582558968286795949136544311508511;
    
    uint256 constant IC24x = 6949374047648725345600239000163461201608869569881194178377342112021749635036;
    uint256 constant IC24y = 3394761413171583872288273400143833848163691770007134280659203148192166744352;
    
    uint256 constant IC25x = 21726893168561059879124734060197015579528646665554320786056707722246794709130;
    uint256 constant IC25y = 8228219943936478664606008133842435299527722777591525451645755455224424863840;
    
    uint256 constant IC26x = 10345919090416452352843982364449483037194345809349121504925082330815329642666;
    uint256 constant IC26y = 2785757247398227371500643786938147987791413061597179338865429359583517875135;
    
    uint256 constant IC27x = 20233209692347625728384284609339981908605430798431468110195856662817380076708;
    uint256 constant IC27y = 1340866621229501326232593897731099352350692460108668053687034822687099888945;
    
    uint256 constant IC28x = 17628044874093374260115040765083205740820996004938096274133833291030003334828;
    uint256 constant IC28y = 4444162520697742328554105685164789312048456335622740682953692594781688556348;
    
    uint256 constant IC29x = 13548805707275455066790424142250532233317929106489376293666385893246664284629;
    uint256 constant IC29y = 9906898423521012724806235391093428037461604427687064222227109391033088986150;
    
    uint256 constant IC30x = 19498021159631655767251207050152250720920153749192625965108588648139827815638;
    uint256 constant IC30y = 9480364253821213296553994970089237692479167171636553753519553337810977467223;
    
    uint256 constant IC31x = 14003773416287073584471719964422601599156726930421158123999478288210225540773;
    uint256 constant IC31y = 14835135419128322123700516226714943901893782043804672034726861566624802478643;
    
    uint256 constant IC32x = 15928816780429216021264564162664772151166601715338316998806872995241033200939;
    uint256 constant IC32y = 1329873893838802479942513776476873601128085924704343841673272195554954272643;
    
    uint256 constant IC33x = 14451048143813246380640271757780042099031554670978507692146966543723948525986;
    uint256 constant IC33y = 8244104522617154781867633157185667340427290212479565456860265231359466434993;
    
    uint256 constant IC34x = 8624343310773692678569349073136812118270972616762391821373822393863143201737;
    uint256 constant IC34y = 12361423609486564298370938225320486006649715528265908181420239509990856742727;
    
    uint256 constant IC35x = 20116988513711612246623609643094141170739450097760212174227030066705464114039;
    uint256 constant IC35y = 17467363739148760900618559939150042292989345013195170755880426383136246353234;
    
    uint256 constant IC36x = 19116347383882451975117562380032615219883131910414681000161787510366780458157;
    uint256 constant IC36y = 21675265637862880201333599317851532225075848844095509466901771807709175227111;
    
    uint256 constant IC37x = 19251986053370798628088373345184966569504217158627676961479531532908142735380;
    uint256 constant IC37y = 20544733639402446399296802009774846303108513945049671721998442196607177163867;
    
 
    // Memory data
    uint16 constant pVk = 0;
    uint16 constant pPairing = 128;

    uint16 constant pLastMem = 896;

    function verifyProof(uint[2] calldata _pA, uint[2][2] calldata _pB, uint[2] calldata _pC, uint[37] calldata _pubSignals) public view returns (bool) {
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
                
                g1_mulAccC(_pVk, IC20x, IC20y, calldataload(add(pubSignals, 608)))
                
                g1_mulAccC(_pVk, IC21x, IC21y, calldataload(add(pubSignals, 640)))
                
                g1_mulAccC(_pVk, IC22x, IC22y, calldataload(add(pubSignals, 672)))
                
                g1_mulAccC(_pVk, IC23x, IC23y, calldataload(add(pubSignals, 704)))
                
                g1_mulAccC(_pVk, IC24x, IC24y, calldataload(add(pubSignals, 736)))
                
                g1_mulAccC(_pVk, IC25x, IC25y, calldataload(add(pubSignals, 768)))
                
                g1_mulAccC(_pVk, IC26x, IC26y, calldataload(add(pubSignals, 800)))
                
                g1_mulAccC(_pVk, IC27x, IC27y, calldataload(add(pubSignals, 832)))
                
                g1_mulAccC(_pVk, IC28x, IC28y, calldataload(add(pubSignals, 864)))
                
                g1_mulAccC(_pVk, IC29x, IC29y, calldataload(add(pubSignals, 896)))
                
                g1_mulAccC(_pVk, IC30x, IC30y, calldataload(add(pubSignals, 928)))
                
                g1_mulAccC(_pVk, IC31x, IC31y, calldataload(add(pubSignals, 960)))
                
                g1_mulAccC(_pVk, IC32x, IC32y, calldataload(add(pubSignals, 992)))
                
                g1_mulAccC(_pVk, IC33x, IC33y, calldataload(add(pubSignals, 1024)))
                
                g1_mulAccC(_pVk, IC34x, IC34y, calldataload(add(pubSignals, 1056)))
                
                g1_mulAccC(_pVk, IC35x, IC35y, calldataload(add(pubSignals, 1088)))
                
                g1_mulAccC(_pVk, IC36x, IC36y, calldataload(add(pubSignals, 1120)))
                
                g1_mulAccC(_pVk, IC37x, IC37y, calldataload(add(pubSignals, 1152)))
                

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
            
            checkField(calldataload(add(_pubSignals, 640)))
            
            checkField(calldataload(add(_pubSignals, 672)))
            
            checkField(calldataload(add(_pubSignals, 704)))
            
            checkField(calldataload(add(_pubSignals, 736)))
            
            checkField(calldataload(add(_pubSignals, 768)))
            
            checkField(calldataload(add(_pubSignals, 800)))
            
            checkField(calldataload(add(_pubSignals, 832)))
            
            checkField(calldataload(add(_pubSignals, 864)))
            
            checkField(calldataload(add(_pubSignals, 896)))
            
            checkField(calldataload(add(_pubSignals, 928)))
            
            checkField(calldataload(add(_pubSignals, 960)))
            
            checkField(calldataload(add(_pubSignals, 992)))
            
            checkField(calldataload(add(_pubSignals, 1024)))
            
            checkField(calldataload(add(_pubSignals, 1056)))
            
            checkField(calldataload(add(_pubSignals, 1088)))
            
            checkField(calldataload(add(_pubSignals, 1120)))
            
            checkField(calldataload(add(_pubSignals, 1152)))
            
            checkField(calldataload(add(_pubSignals, 1184)))
            

            // Validate all evaluations
            let isValid := checkPairing(_pA, _pB, _pC, _pubSignals, pMem)

            mstore(0, isValid)
             return(0, 0x20)
         }
     }
 }
