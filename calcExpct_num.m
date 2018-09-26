function p = calcExpct_num(eta, n1, N)

W = [.10921834195238497114,
				.21044310793881323294,
				.23521322966984800539,
				.19590333597288104341,
				.12998378628607176061,
				.70578623865717441560E-1,
				.31760912509175070306E-1,
				.11918214834838557057E-1,
				.37388162946115247897E-2,
				.98080330661495513223E-3,
				.21486491880136418802E-3,
				.39203419679879472043E-4,
				.59345416128686328784E-5,
				.74164045786675522191E-6,
				.76045678791207814811E-7,
				.63506022266258067424E-8,
				.42813829710409288788E-9,
				.23058994918913360793E-10,
				.97993792887270940633E-12,
				.32378016577292664623E-13,
				.81718234434207194332E-15,
				.15421338333938233722E-16,
				.21197922901636186120E-18,
				.20544296737880454267E-20,
				.13469825866373951558E-22,
				.56612941303973593711E-25,
				.14185605454630369059E-27,
				.19133754944542243094E-30,
				.11922487600982223565E-33,
				.26715112192401369860E-37,
				.13386169421062562827E-41,
				.45105361938989742322E-47];
X = [.44489365833267018419E-1,
				.23452610951961853745,
				.57688462930188642649,
				.10724487538178176330E1,
				.17224087764446454411E1,
				.25283367064257948811E1,
				.34922132730219944896E1,
				.46164567697497673878E1,
				.59039585041742439466E1,
				.73581267331862411132E1,
				.89829409242125961034E1,
				.10783018632539972068E2,
				.12763697986742725115E2,
				.14931139755522557320E2,
				.17292454336715314789E2,
				.19855860940336054740E2,
				.22630889013196774489E2,
				.25628636022459247767E2,
				.28862101816323474744E2,
				.32346629153964737003E2,
				.36100494805751973804E2,
				.40145719771539441536E2,
				.44509207995754937976E2,
				.49224394987308639177E2,
				.54333721333396907333E2,
				.59892509162134018196E2,
				.65975377287935052797E2,
				.72687628090662708639E2,
				.80187446977913523067E2,
				.88735340417892398689E2,
				.98829542868283972559E2,
				.11175139809793769521E3];
            
fun_h = @(x) calcProb(eta * sqrt(x / (n1-1)), N);
fun_f = @(x) chi2pdf(x, n1-1);
fun = @(x) fun_h(x) .* fun_f(x);
p = sum(fun(X) .* W .* exp(X));
end