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

contract Groth16SwapperM {
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
    uint256 constant deltax1 = 3747100357248106724565757697404169002770034735837869005841770244207982686871;
    uint256 constant deltax2 = 9507156569079136078357852210329173888970115120764414606918240735211631331413;
    uint256 constant deltay1 = 6164417648125389665577135858495347612045923835261259739327708044060650578914;
    uint256 constant deltay2 = 3860454800179924829254603417051900017408115931943676543012144194211250220919;

    
    uint256 constant IC0x = 19136739283499903779378891450829476552864824231521351437094427207243977791538;
    uint256 constant IC0y = 6627609572482207399984491866616009010646532579356219982633536915459192516922;
    
    uint256 constant IC1x = 1384224169825923998981098797298178564456090102934723862480505368218229545332;
    uint256 constant IC1y = 11869236512653422696241209490747503345788721476244828913942915231532081355464;
    
    uint256 constant IC2x = 16428614514428861146213371187792855942934703407170425681098837986768808803013;
    uint256 constant IC2y = 3833097233958572347838628875407579492771469144647174891417063739364978995830;
    
    uint256 constant IC3x = 13447850763201052568510483903235198880120000451573862773146150303991825760572;
    uint256 constant IC3y = 20612721581730060806380790604116433347989812001228780446086355692627535696397;
    
    uint256 constant IC4x = 17667984928622793750432869121598039679050563726439558373970054512010701943285;
    uint256 constant IC4y = 289010333790142163952930094002218431027033956019039777818458956945157838630;
    
    uint256 constant IC5x = 6831201810392966798079094544582316345913635794817849822735054581786933376128;
    uint256 constant IC5y = 9624143930918434666861497551003302161848702718754521848388272915511528906157;
    
    uint256 constant IC6x = 16519808585639186616785743878857649077342740419985573238233375044379942732863;
    uint256 constant IC6y = 18005529720997759818953582634397234757574848856554551684187668555321358980941;
    
    uint256 constant IC7x = 19168066029123241352530347699300050957422769911686181472633087381734953660313;
    uint256 constant IC7y = 15463569687868604946794562614787433948386516984111501160042245959782690012286;
    
    uint256 constant IC8x = 21682382519355678306555833229127471412335083483942629097308643988055352233111;
    uint256 constant IC8y = 7305241537615388547336248985164421375086831751685428871442399078024014700418;
    
    uint256 constant IC9x = 18865285373676981164057298609449754468638356706193437359960428102869119877651;
    uint256 constant IC9y = 17919071328355226711479219072788627408123606390634456375672109511515658248386;
    
    uint256 constant IC10x = 3261005890549744211883222338760673513919426779848971500921251948299687636902;
    uint256 constant IC10y = 20300210918212398154089344087450271790591548721370860398789763570392670167633;
    
    uint256 constant IC11x = 11764963594176067940453521603849201013944863188142185117745399882770853771887;
    uint256 constant IC11y = 5380023323194921612808212801464234825133401730577795410379236905705403222724;
    
    uint256 constant IC12x = 15598306071107131813269461623688243155768306485973319827289994642200367347590;
    uint256 constant IC12y = 13206496163849115896606313585295335956423246092330855923538838490659570341419;
    
    uint256 constant IC13x = 12052407519954576454972530372214841126187564193010902791208404509174810840781;
    uint256 constant IC13y = 14277808041640611752517402650010594529561001530580372177426543228111849981261;
    
    uint256 constant IC14x = 19882526434393242020067475839404522009102219782415668577986365351626654478886;
    uint256 constant IC14y = 11132562238610048242895324872162415639312895147627502894956877454230140308235;
    
    uint256 constant IC15x = 20205626221812724542084951283359730029797351522066851022077413517362207303780;
    uint256 constant IC15y = 14178035284466690213017716711302167051705714250025569021248863332960172786058;
    
    uint256 constant IC16x = 7847794097396917665689762231583013358125281738820236010362758983167850359655;
    uint256 constant IC16y = 9276381760814059353337501198723038277406293804731513952096026237333852248612;
    
    uint256 constant IC17x = 18298985494533317929636204567870657638128901709781412374840442804359223802982;
    uint256 constant IC17y = 13697999961017748425785056280728025796724622709952208577952634752011049724035;
    
    uint256 constant IC18x = 19866342067575732886163246166672791329555749320383322099896822881547736725570;
    uint256 constant IC18y = 21095498512379102707220206277410044840953864034295658063623549744214782004496;
    
    uint256 constant IC19x = 11980460217339861739900485170477309553478775024219902712482552220792620181575;
    uint256 constant IC19y = 10449354153006402380989213693639317238705345738670468920635517341616341401647;
    
    uint256 constant IC20x = 15208173318826672709360150955472294897017543235835316441004600540226817481000;
    uint256 constant IC20y = 8615662690818923465023484309570144396663965047197460146978455188056424677225;
    
    uint256 constant IC21x = 21012852805180005597592628785460679576927910482163331093664100366261044944787;
    uint256 constant IC21y = 20461329768548874171827387727198101106885922687420208256829169416272932643393;
    
    uint256 constant IC22x = 17465739257961756079629954203179161362927683446643881508407437271080127197199;
    uint256 constant IC22y = 10515686259790358985492389438021445893989731241098256845443284375589413272511;
    
    uint256 constant IC23x = 17802732897386682838737089537461320597726009350934960007867829377145749812683;
    uint256 constant IC23y = 10470406403140724594347907232809708170822831094327166084461040008238905100185;
    
    uint256 constant IC24x = 1239743340321145434316052155796644847576458902296338043553747617500024100127;
    uint256 constant IC24y = 4048463598477766346386651360208903041157825397223173478284039869435331045407;
    
    uint256 constant IC25x = 5133117992112995634148852252823538829698677218439590635762481945886152520663;
    uint256 constant IC25y = 17363573552779623771317178393757079414803811289886576405273310527973699059458;
    
    uint256 constant IC26x = 4810795773111767596564555139426926149532231507335945048194243541462356913788;
    uint256 constant IC26y = 1060960330178798511146035745973295129395020536548857832975988105689940943258;
    
    uint256 constant IC27x = 12070697835056610394368841916791047611132891553507338945326164506488445451207;
    uint256 constant IC27y = 3361161890587596245229313467927756701801533054460930370007135693628702804054;
    
    uint256 constant IC28x = 6503128003216296820227107713438687946379347700286610542773537466596753491131;
    uint256 constant IC28y = 9621478633854967446736018113335418251834534334860990888874953543463185400591;
    
    uint256 constant IC29x = 11415744028263775357410281286855002541843509767234584137198909955258231791387;
    uint256 constant IC29y = 5298682447674425245188289127856469208186567829653519138102342510719420801566;
    
    uint256 constant IC30x = 20933955879741227977974368677383467273457502619589498584137390163967513882594;
    uint256 constant IC30y = 7469338191985970990253209822979816921529483450168774574032804411295384993976;
    
    uint256 constant IC31x = 3897147545031299293936359504685447901825837384451180993099093691048376678156;
    uint256 constant IC31y = 17451935690564840796977881894369618623534066094050132440331089341963758555519;
    
    uint256 constant IC32x = 12972201039983553888889487101307706750778701564878812995560134929427860106553;
    uint256 constant IC32y = 10138930789545584879281578475514242630881785025500009775931678598124731811377;
    
    uint256 constant IC33x = 10034334623839171979903552205120601338719243490416381885435485062733508784779;
    uint256 constant IC33y = 3142424327169013047613246294722550812366339712265811156253017377286083455191;
    
    uint256 constant IC34x = 11164672394668697900516136347078512700590632229139508621630126858007617904170;
    uint256 constant IC34y = 267805444773774801726486010455396390407470647654305582696676721595289196304;
    
    uint256 constant IC35x = 13898965593980738600863988741914177184711674122224339729176248799260362952295;
    uint256 constant IC35y = 11771300190105976741012634139794976689266251564010040467543003847198889863314;
    
    uint256 constant IC36x = 19508158930871281457363179529342713975221090952107068651052452018085923084401;
    uint256 constant IC36y = 15235123437964347419562853341298324996480613660902275762986613859283261772586;
    
    uint256 constant IC37x = 4647619801700502225226481565069562788310096700583066839938955077587765481375;
    uint256 constant IC37y = 3818396995927602673069716166108855898296009769409722875599346621729442417411;
    
    uint256 constant IC38x = 20525326642630532003412145162376547864525876461019286283527375902860330300559;
    uint256 constant IC38y = 7200246473202116111831305969928006646487950451506142247334515592347744341502;
    
    uint256 constant IC39x = 6815085131966620327149064800383083513159359375319291630317489140542817485827;
    uint256 constant IC39y = 9964691120482814784414740081413253416438421833773931694713891489811312294762;
    
    uint256 constant IC40x = 19417264626580095162616699158409332871482266672221183223080095410289482616876;
    uint256 constant IC40y = 354382848255794639370571051735632828046926526325505775234796607815812285285;
    
    uint256 constant IC41x = 7535439648489765776497997951233530788576093642249675166097267775953351664564;
    uint256 constant IC41y = 3486922730771749593450911307119051990217008771302671092603050670526834585286;
    
    uint256 constant IC42x = 9600336834860242554566029514677919486060395170707432593640693710002052247331;
    uint256 constant IC42y = 2221385147165263771252021174544293207472870529327537441114812697250785512487;
    
    uint256 constant IC43x = 15576586232176322273122616224683893638197341995841483705422502600156678830426;
    uint256 constant IC43y = 10797632283618669123191830035656945856213859683257022788943189860761273703795;
    
    uint256 constant IC44x = 15127232189152811202451257328728739837122663115493881898938181079999070291873;
    uint256 constant IC44y = 4854284833397784958942260275269205889084329977395439644477589928682159979037;
    
    uint256 constant IC45x = 4958847586904187290636071514599131304045022029632647666668172762247505877974;
    uint256 constant IC45y = 5793465840972809322708199710672101499615265011995072637800146079086137377709;
    
    uint256 constant IC46x = 9691881580912414550651736781947649899454493900307903929315008546805740035713;
    uint256 constant IC46y = 9471843615534232159204753436034930687618594462654913841999407942702599767759;
    
    uint256 constant IC47x = 6359580544051139977140062462241872533951856121902895288660391216126998613119;
    uint256 constant IC47y = 7016445849664793350519573221873665864330456502279961919289374494531820133634;
    
    uint256 constant IC48x = 2811045703106718280933315650765956152714698186735960794837957517502115400433;
    uint256 constant IC48y = 21136976927353131284938918364699553390101697984720278991720334161082313344204;
    
    uint256 constant IC49x = 3208344467225535716935787408207319177554560861976701618932553418389460835679;
    uint256 constant IC49y = 4703073625518537368580479226372937005662127847784302055694957258522354351813;
    
    uint256 constant IC50x = 5479261752738197233211059930396021167747177805315560883000935237222203565607;
    uint256 constant IC50y = 21838197553274362343483821450768322275493615752998819201159494166913584287776;
    
    uint256 constant IC51x = 17453739111046195870552002951026406693183828650165700762571301922762464664087;
    uint256 constant IC51y = 16468727208315488381527919787924004533418959963389043679261582881723545416316;
    
    uint256 constant IC52x = 16046292620047010886451619340661679210400390729056832091589943281801286952591;
    uint256 constant IC52y = 20060131459245354690746967715764862098144741419837259117146430146986431468485;
    
    uint256 constant IC53x = 4119310422190636119831223086023581593532642215870353856109407435042178744665;
    uint256 constant IC53y = 18173616534218295617047432136156650629952881329705421961202963953159603842953;
    
 
    // Memory data
    uint16 constant pVk = 0;
    uint16 constant pPairing = 128;

    uint16 constant pLastMem = 896;

    function verifyProof(uint[2] calldata _pA, uint[2][2] calldata _pB, uint[2] calldata _pC, uint[53] calldata _pubSignals) public view returns (bool) {
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
                
                g1_mulAccC(_pVk, IC38x, IC38y, calldataload(add(pubSignals, 1184)))
                
                g1_mulAccC(_pVk, IC39x, IC39y, calldataload(add(pubSignals, 1216)))
                
                g1_mulAccC(_pVk, IC40x, IC40y, calldataload(add(pubSignals, 1248)))
                
                g1_mulAccC(_pVk, IC41x, IC41y, calldataload(add(pubSignals, 1280)))
                
                g1_mulAccC(_pVk, IC42x, IC42y, calldataload(add(pubSignals, 1312)))
                
                g1_mulAccC(_pVk, IC43x, IC43y, calldataload(add(pubSignals, 1344)))
                
                g1_mulAccC(_pVk, IC44x, IC44y, calldataload(add(pubSignals, 1376)))
                
                g1_mulAccC(_pVk, IC45x, IC45y, calldataload(add(pubSignals, 1408)))
                
                g1_mulAccC(_pVk, IC46x, IC46y, calldataload(add(pubSignals, 1440)))
                
                g1_mulAccC(_pVk, IC47x, IC47y, calldataload(add(pubSignals, 1472)))
                
                g1_mulAccC(_pVk, IC48x, IC48y, calldataload(add(pubSignals, 1504)))
                
                g1_mulAccC(_pVk, IC49x, IC49y, calldataload(add(pubSignals, 1536)))
                
                g1_mulAccC(_pVk, IC50x, IC50y, calldataload(add(pubSignals, 1568)))
                
                g1_mulAccC(_pVk, IC51x, IC51y, calldataload(add(pubSignals, 1600)))
                
                g1_mulAccC(_pVk, IC52x, IC52y, calldataload(add(pubSignals, 1632)))
                
                g1_mulAccC(_pVk, IC53x, IC53y, calldataload(add(pubSignals, 1664)))
                

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
            
            checkField(calldataload(add(_pubSignals, 1216)))
            
            checkField(calldataload(add(_pubSignals, 1248)))
            
            checkField(calldataload(add(_pubSignals, 1280)))
            
            checkField(calldataload(add(_pubSignals, 1312)))
            
            checkField(calldataload(add(_pubSignals, 1344)))
            
            checkField(calldataload(add(_pubSignals, 1376)))
            
            checkField(calldataload(add(_pubSignals, 1408)))
            
            checkField(calldataload(add(_pubSignals, 1440)))
            
            checkField(calldataload(add(_pubSignals, 1472)))
            
            checkField(calldataload(add(_pubSignals, 1504)))
            
            checkField(calldataload(add(_pubSignals, 1536)))
            
            checkField(calldataload(add(_pubSignals, 1568)))
            
            checkField(calldataload(add(_pubSignals, 1600)))
            
            checkField(calldataload(add(_pubSignals, 1632)))
            
            checkField(calldataload(add(_pubSignals, 1664)))
            
            checkField(calldataload(add(_pubSignals, 1696)))
            

            // Validate all evaluations
            let isValid := checkPairing(_pA, _pB, _pC, _pubSignals, pMem)

            mstore(0, isValid)
             return(0, 0x20)
         }
     }
 }
