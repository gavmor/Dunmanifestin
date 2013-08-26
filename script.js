var listNames = new Array(0);
var lists = new Array(0);
var pageTitle = "NPC Generator";
var pageSubTitle = "with added content scrounged by Gavin";
var iterations = 1;
var inputsyntax = "[npc] ";
var output = '';
var codeoutput = '';
var listText = '';
var helpShown = false;
var textareaWidth = 84;
var textareaHeight = 10;
var docBackground = '#CCCCCC';
var docText = '#333333';
var docFont = ' font-family:monospace;';
var helpText = unescape('Text%20has%20been%20added%20to%20the%20New%20Code%20text%20box%0A%20%28and%20should%20be%20already%20highlighted%29.%0A%0A%0A%20Copy%20and%20paste%20that%20text%20into%20a%20new%20file%2C%0A%20give%20it%20a%20name%20ending%20in%20.html%2C%20and%20save%20it%0A%20to%20create%20your%20new%20generator%20page.%0A%0A%0A%20This%20message%20will%20not%20be%20shown%20again%20until%0A%20the%20next%20time%20you%20load%20a%20fresh%20copy%20of%20this%20page%2C%0A%20but%20the%20Generate%20buttons%20will%20still%20work%20the%20same.');
var instructionText = unescape('%3Ch3%3EInstructions%20for%20Use%3A%3C/h3%3E%0A%3Cp%3E%3Cb%3ETake%20a%20moment%20to%20look%20at%20the%20sample%20data%3C/b%3E%20included%20with%20this%20template%2C%20and%20click%20the%20Re-randomize%20Results%20button%20a%20few%20times%2C%20to%20see%20how%20the%20program%20works.%20%20Doing%20that%20may%20allow%20you%20to%20figure%20out%20this%20program%20and%20get%20started%20right%20away.%3C/p%3E%0A%3Cp%3E%3Cb%3EThis%20page%20is%20self-contained%3C/b%3E%2C%20so%20it%20will%20work%20just%20as%20well%20from%20your%20hard%20drive%20as%20it%20does%20from%20the%20Internet.%20%20You%20can%20save%20a%20copy%20to%20your%20hard%20drive%20and%20work%20with%20it%20there.%3C/p%3E%0A%3Cp%3E%3Cb%3EBear%20in%20mind%3C/b%3E%20that%20this%20page%20cannot%20%3Cb%3Edirectly%3C/b%3E%20save%20changes%20you%20make%21%20%20Most%20web%20browsers%20have%20safeguards%20against%20letting%20code%20change%20the%20pages%20you%20are%20viewing%2C%20to%20prevent%20malicious%20code%20from%20deceiving%20people%20browsing%20the%20Web.%20%20To%20save%20any%20of%20the%20changes%20you%20make%2C%20you%20will%20have%20to%20use%20the%20buttons%20labeled%20Generate%20Working%20Copy%20or%20Generate%20Final%20Copy.%20%20Instructions%20for%20how%20to%20use%20them%20are%20given%20below.%3C/p%3E%0A%3Cp%3E%3Cb%3EEnter%20a%20syntax%3C/b%3E%20that%20describes%20the%20random%20phrases%20you%20want%20to%20generate.%20%20Normal%20text%20in%20the%20syntax%20will%20always%20show%20up%20the%20same%2C%20and%20anything%20in%20%5Bsquare%20brackets%5D%20will%20be%20randomized%20from%20a%20list%20that%20you%20provide.%20%20Whenever%20the%20program%20sees%20something%20in%20%5Bsquare%20brackets%5D%2C%20it%20knows%20you%20want%20to%20make%20a%20random%20substitution%20there%2C%20and%20it%20will%20go%20looking%20for%20a%20data%20list%20that%20has%20the%20same%20name%20as%20whatever%20you%20put%20in%20the%20brackets.%20%20So%2C%20if%20you%20put%20the%20words%20%5Bdog%20species%5D%20in%20your%20syntax%2C%20the%20program%20will%20go%20looking%20for%20a%20list%20named%20%22dog%20species%22%20in%20your%20data%20lists.%3C/p%3E%0A%3Cp%3E%28Try%20to%20avoid%20using%20curly%20braces%20like%20this%20%7B%20or%20this%20%7D%20or%20number-signs%20like%20this%20%23%20in%20your%20syntax.%20%20Those%20characters%20have%20special%20uses%20in%20RandListGen%2C%20described%20in%20the%20instructions%20below.%20%20Using%20parentheses%2C%20like%20this%20%28%20or%20this%20%29%20is%20fine%2C%20though.%29%3C/p%3E%0A%3Cp%3E%3Cb%3EPick%20how%20many%20random%20results%3C/b%3E%20you%20want%20to%20generate%20each%20time.%3C/p%3E%0A%3Cp%3E%3Cb%3EEnter%20a%20data%20list%3C/b%3E%20for%20each%20bracketed%20item%20in%20your%20syntax.%20%20The%20first%20line%20of%20each%20list%20should%20start%20with%20a%20vertical%20pipe%20character%2C%20like%20this%3A%20%7C%20followed%20by%20the%20name%20of%20the%20list.%20%20The%20second%20line%20of%20each%20list%20is%20the%20first%20item%20that%20may%20be%20picked%20randomly.%20%20Each%20additional%20line%20of%20each%20list%20is%20another%20item%20that%20might%20be%20picked.%20%20Put%20a%20blank%20line%20at%20the%20end%20of%20each%20list%2C%20to%20let%20the%20program%20know%20that%20list%20is%20finished.%20%20See%20the%20sample%20data%20above%20and%20further%20instructions%20below%20for%20examples%20of%20what%20lists%20look%20like..%3C/p%3E%0A%3Cp%3EDo%20not%20use%20the%20vertical%20pipe%20character%20elsewhere%20in%20your%20lists%2C%20or%20the%20program%20will%20misundertand%20where%20your%20lists%20begin%20and%20end.%20%20Do%20not%20use%20the%20caret%20character%20%28%5E%29%20in%20your%20lists%2C%20unless%20you%20intend%20to%20make%20a%20parameter%20label%20%28see%20Advanced%20Instructions%2C%20below%29.%3C/p%3E%0A%3Cp%3E%3Cb%3EIf%20you%20want%20some%20list%20items%20to%20show%20up%20more%20often%3C/b%3E%20than%20other%20items%20in%20the%20same%20list%2C%20you%20can%20put%20a%20number%20and%20an%20@%20character%20at%20the%20front%20of%20the%20lines%20you%20want%20to%20show%20up%20more%20often.%20%20For%20example%2C%20having%20a%20list%20like%20this%3A%3C/p%3E%0A%3Cpre%3E%0A%7Cdog%20species%0Agerman%20shepherd%0Alabrador%20retriever%0Agolden%20retriever%0Adachshund%0Apomeranian%0Acorgi%0Acorgi%0Acorgi%0Acorgi%0Acorgi%0A%3C/pre%3E%0A%3Cp%3E...is%20exactly%20the%20same%20as%20having%20a%20list%20like%20this%3A%3C/p%3E%0A%3Cpre%3E%0A%7Cdog%20species%0Agerman%20shepherd%0Alabrador%20retriever%0Agolden%20retriever%0Adachshund%0Apomeranian%0A5@corgi%0A%3C/pre%3E%0A%3Cp%3EIn%20those%20lists%2C%20any%20time%20a%20random%20%5Bdog%20species%5D%20is%20called%20for%20in%20the%20syntax%2C%20corgis%20are%20five%20times%20as%20likely%20to%20show%20up%20as%20each%20of%20the%20other%20dogs%2C%20and%20since%20corgis%20represent%20five%20choices%20out%20of%20ten%20total%20choices%20in%20each%20list%2C%20there%20is%20a%2050%25%20chance%20of%20getting%20the%20corgi%20result%20each%20time%20you%20call%20for%20a%20random%20%5Bdog%20species%5D.%3C/p%3E%0A%3Cp%3E%3Cb%3EIf%20you%20specify%20a%20number%20for%20a%20line%3C/b%3E%2C%20the%20number%20and%20@%20character%20must%20be%20at%20the%20very%20beginning%20of%20the%20line.%20%20Putting%20them%20in%20the%20middle%20or%20at%20the%20end%20will%20not%20work.%20%20There%20is%20no%20difference%20between%20having%20a%20line%20in%20your%20list%20that%20says%20%22pomeranian%22%20and%20one%20that%20says%20%221@pomeranian%22.%20%20They%20are%20exactly%20the%20same%20to%20the%20program%2C%20so%20you%20don%27t%20ever%20have%20to%20type%20%221@%22%20if%20you%20don%27t%20want%20to.%20%20The%20program%20will%20automatically%20add%20%221@%22%20in%20front%20of%20any%20list%20line%20that%20doesn%27t%20already%20have%20a%20number.%3C/p%3E%0A%3Cp%3E%3Cb%3EList%20lines%20can%20be%20simple%20text%3C/b%3E%2C%20like%20the%20dogs%20above%2C%20%3Cb%3Eor%20they%20can%20be%20little%20syntaxes%20of%20their%20own%3C/b%3E%2C%20referring%20to%20other%20lists%21%20%20So%20you%20can%20have%20lists%20like%20these%3A%3C/p%3E%0A%3Cpre%3E%0A%7Cdog%20type%0Aan%20old%2C%20%5Btraining%20level%5D%20%5Bdog%20species%5D%0Aa%20young%2C%20%5Btraining%20level%5D%20%5Bdog%20species%5D%0Aa%20%5Bdog%20species%5D%20puppy%2C%20too%20young%20to%20train%0A%0A%7Ctraining%20level%0Awell-trained%0Apoorly-trained%0Awild%0A%0A%7Cdog%20species%0Agerman%20shepherd%0Alabrador%20retriever%0Agolden%20retriever%0Adachshund%0Apomeranian%0A5@corgi%0A%3C/pre%3E%0A%3Cp%3EIf%20you%20used%20these%20lists%2C%20any%20time%20you%20called%20for%20a%20%5Bdog%20type%5D%20in%20your%20syntax%2C%20you%20might%20get%20something%20like%20%22an%20old%2C%20poorly-trained%20pomeranian%22%20or%20%22a%20young%2C%20well-trained%20german%20shepherd%22.%20%20Because%20the%20line%20for%20%22puppy%22%20is%20constructed%20differently%20than%20the%20rest%2C%20no%20%5Btraining%20level%5D%20will%20be%20generated%20for%20puppies.%20%3C/p%3E%0A%3Cp%3E%3Cb%3EYou%20can%20also%20generate%20random%20numbers%2C%20just%20like%20rolling%20dice%3C/b%3E%20in%20your%20syntax%20and%20data%20lists.%20%20Anything%20you%20put%20between%20number%20signs%20%28%23%23%29%20will%20be%20treated%20like%20dice%2C%20according%20to%20the%20format%20XdY+N%2C%20where%20X%20is%20the%20number%20of%20dice%20to%20be%20rolled%20and%20added%20together%2C%20Y%20is%20the%20number%20of%20sides%20on%20each%20die%2C%20and%20N%20is%20something%20to%20be%20added%20to%20the%20total%20%28or%20subtracted%2C%20using%20a%20-%20instead%20of%20a%20+%29.%20%20So%20%232d6%23%20simulates%20rolling%20two%20six-sided%20dice%2C%20and%20adding%20them%20together.%20%20Similarly%2C%20specifying%20%231d37+4d2-88%23%20simulates%20rolling%20a%2037-sided%20die%20%28something%20that%20may%20never%20have%20existed%20in%20the%20real%20world%20but%20can%20still%20be%20simulated%29%2C%20rolling%20four%20two-sided%20dice%20%28esentially%2C%20flipping%20four%20coins%2C%20treating%20tails%20as%201%20and%20heads%20as%202%29%2C%20adding%20the%20results%20together%2C%20and%20subtracting%20eighty-eight.%20%20In%20addition%20to%20numeric%20dice%2C%20you%20can%20also%20simulate%20Fudge%20dice%2C%20by%20using%20dF%20instead%20of%20a%20number.%20%204dF%20simulates%20four%20Fudge%20dice.%20%20%28Fudge%20dice%20are%20special%20dice%20used%20for%20a%20game%20named%20Fudge%2C%20which%20you%20can%20find%20online.%29%3C/p%3E%0A%3Cp%3ERandListGen%20is%20not%20intended%20to%20fulfill%20all%20your%20dice-rolling%20needs.%20%20For%20a%20more%20full-featured%20dice%20roller%20by%20the%20same%20author%20as%20RandListGen%2C%20you%20can%20go%20here%3A%20%20%3Ca%20href%3D%22http%3A//www.path-o-logic.com/misc/random_dice.html%22%3Ehttp%3A//www.path-o-logic.com/misc/random_dice.html%3C/a%3E%3C/p%3E%0A%3Cp%3E%3Cb%3EPick%20a%20new%20title%20and%20subtitle%3C/b%3E%20for%20your%20page.%3C/p%3E%0A%3Cp%3E%3Cb%3EPick%20a%20new%20background%20color%2C%20text%20color%2C%20and%20font%3C/b%3E%20for%20your%20page%2C%20if%20you%20wish.%20%20You%20can%20pick%20colors%20from%20the%20lists%2C%20or%20if%20you%20know%20the%20RRGGBB%20number%20for%20the%20color%20you%20want%2C%20you%20can%20enter%20it%20directly%20in%20either%20of%20the%20boxes.%20%20The%20list%20of%20fonts%20is%20generic%2C%20and%20which%20font%20appears%20when%20you%20pick%20each%20one%20depends%20entirely%20on%20which%20fonts%20are%20installed%20on%20your%20computer.%20%20In%20effect%2C%20when%20you%20pick%20from%20this%20font%20list%2C%20your%20web%20browser%20decides%20which%20font%20you%20actually%20see.%20%20RandListGen%20does%20not%20actually%20come%20with%20any%20fonts%20of%20its%20own.%3C/p%3E%0A%3Cp%3E%3Cb%3EYou%20can%20save%20your%20work%3C/b%3E%20by%20clicking%20either%20the%20Generate%20Working%20Copy%20button%20or%20the%20Generate%20Final%20Copy%20button.%20%20Either%20of%20these%20buttons%20generates%20the%20code%20for%20a%20new%20web%20page%2C%20and%20puts%20that%20code%20into%20the%20New%20Code%20text%20box.%20%20%28Depending%20on%20what%20browser%20you%20are%20using%2C%20that%20new%20code%20may%20automatically%20be%20highlighted%2C%20as%20if%20you%20had%20selected%20it%20with%20your%20mouse%2C%20to%20make%20it%20easier%20to%20copy%20to%20your%20clipboard.%29%20%20Copy%20and%20paste%20that%20new%20code%20into%20a%20new%20file%2C%20give%20it%20a%20name%20ending%20in%20.html%20like%20%22RandList_MyDogs.html%22%20or%20something%20similar%2C%20and%20save%20that%20new%20file%20to%20your%20hard%20drive.%20%20Open%20that%20new%20file%20in%20your%20web%20browser%2C%20and%20it%20should%20have%20all%20the%20changes%20you%20made%20permanently%20coded%20into%20it.%3C/p%3E%0A%3Cp%3E%3Cb%3EIf%20you%20choose%20the%20Generate%20Working%20Copy%20button%3C/b%3E%2C%20the%20code%20will%20make%20a%20new%20page%20for%20you%20that%20has%20your%20chosen%20data%20instead%20of%20the%20sample%20data%20that%20came%20with%20this%20page%2C%20and%20that%20page%20should%20continue%20to%20look%20and%20work%20just%20like%20this%20page%20does.%20%20This%20new%20copy%20will%20also%20have%20your%20choices%20for%20title%2C%20subtitle%2C%20font%2C%20color%2C%20and%20other%20settings%20permanently%20set%20in%20it.%20%20In%20this%20new%20working%20copy%2C%20you%20can%20continue%20to%20make%20changes%20and%20save%20new%20copies%2C%20just%20like%20in%20this%20page.%3C/p%3E%0A%3Cp%3E%3Cb%3EIf%20you%20choose%20the%20Generate%20Final%20Copy%20button%3C/b%3E%2C%20the%20code%20will%20make%20a%20new%20page%20for%20you%20that%20has%20your%20chosen%20data%2C%20but%20without%20most%20of%20the%20buttons%2C%20text%20boxes%2C%20and%20instructions%20this%20page%20has.%20%20All%20the%20data%20you%20chose%20becomes%20%22locked%20down%22%20and%20the%20controls%20for%20them%20do%20not%20appear%20on%20a%20final%20copy%2C%20except%20for%20the%20Re-Randomize%20Results%20button.%20%20This%20is%20for%20people%20who%20want%20to%20keep%20that%20data%20that%20way%20forever%2C%20display%20it%20on%20a%20web%20site%2C%20send%20it%20to%20others%2C%20or%20whatever.%20%20For%20example%2C%20this%20is%20handy%20for%20GMs%20who%20want%20to%20make%20a%20random%20list%20of%20character%20names%20for%20players%20to%20choose%20from%2C%20but%20don%27t%20want%20players%20fiddling%20with%20the%20lists.%20%20These%20final%20copies%20are%20also%20much%20shorter%20and%20simpler%20pages%2C%20so%20they%20are%20easier%20to%20add%20to%2C%20customize%2C%20and%20make%20prettier%2C%20if%20you%20want%20to%20edit%20them%20manually.%3C/p%3E%0A%3Cp%3EIf%20you%20make%20a%20final%20copy%20of%20a%20project%20and%20then%20later%20decide%20that%20you%20need%20to%20make%20changes%2C%20look%20inside%20the%20source%20code%20of%20the%20final%20copy.%20%20There%2C%20toward%20the%20end%2C%20you%20should%20see%20a%20commented%20section%20%28part%20of%20the%20HTML%20that%20does%20not%20appear%20when%20the%20page%20is%20viewed%20in%20a%20browser%29%20that%20has%20the%20working%20copy%27s%20syntax%20and%20data%20lists.%20%20Get%20a%20new%20copy%20of%20the%20RandListGen%20page%2C%20copy%20and%20paste%20in%20the%20syntax%20and%20lists%2C%20make%20a%20working%20copy%20of%20it%2C%20and%20most%20of%20the%20work%20of%20re-creating%20your%20project%20is%20done%2C%20and%20it%27s%20ready%20for%20you%20to%20experiment%20and%20make%20changes.%3C/p%3E%0A%3Cbr%20/%3E%3Cbr%20/%3E%3Ch3%3EAdvanced%20Instructions%3A%3C/h3%3E%0A%3Cbr%20/%3E%3Cp%3E%3Cb%3EYou%20can%20create%20parameters%20for%20your%20randomizer%20project%20as%20well.%3C/b%3E%20%20Parameters%20are%20values%20that%20you%20can%20set%20manually%2C%20picking%20from%20a%20data%20list%20you%20created%2C%20instead%20of%20being%20picked%20randomly.%20%20Parameters%20are%20useful%20if%20you%20want%20some%20parts%20of%20your%20randomizer%20to%20be%20random%2C%20while%20others%20are%20not%2C%20letting%20you%20make%20choices%20about%20what%20the%20randomizer%20does.%20%20For%20example%2C%20using%20the%20sample%20data%2C%20turning%20the%20character%20race%20from%20a%20random%20pick%20into%20a%20parameter%20allows%20you%20to%20say%20%22hmm%2C%20this%20next%20character%20should%20be%20an%20elf%2C%22%20and%20instead%20of%20clicking%20Re-Randomize%20and%20hoping%20an%20elf%20comes%20up%2C%20you%20can%20manually%20choose%20to%20randomize%20nothing%20but%20elves%20on%20the%20next%20push%20of%20the%20button.%3C/p%3E%0A%3Cp%3EParameters%20are%20data%20list%20names%20that%20are%20entered%20in%20your%20syntax%2C%20except%20that%20instead%20of%20being%20enclosed%20in%20%5Bsquare%20brackets%5D%2C%20they%20are%20enclosed%20in%20%7Bcurly%20braces%7D.%20%20You%20can%20use%20the%20same%20data%20list%20as%20both%20a%20random%20pick%20and%20a%20parameter%20in%20the%20same%20project%2C%20if%20you%20wish%2C%20by%20including%20its%20name%20in%20the%20syntax%20in%20brackets%20or%20in%20braces%2C%20wherever%20you%20want%20them.%3C/p%3E%0A%3Cp%3EParameters%20do%20not%20show%20up%20immediately%20when%20you%20create%20them.%20%20After%20you%20specify%20a%20parameter%20in%20your%20syntax%2C%20then%20generate%20a%20Working%20Copy%20or%20Final%20Copy%2C%20that%20new%20copy%20of%20the%20page%20will%20have%20drop-down%20selectors%20underneath%20the%20random%20result%20area%2C%20above%20the%20Re-Randomize%20Results%20button.%20%20When%20you%20select%20values%20in%20these%20drop-down%20selectors%2C%20then%20re-randomize%2C%20the%20values%20you%20select%20are%20the%20same%20for%20each%20line%2C%20instead%20of%20being%20randomized%20for%20each%20line.%20%20This%20allows%20you%20to%20give%20your%20users%20some%20options%20that%20they%20can%20determine%20themselves.%3C/p%3E%0A%3Cp%3ETo%20see%20how%20parameters%20work%20using%20the%20sample%20data%20that%20comes%20with%20this%20page%2C%20load%20up%20a%20fresh%20copy%20of%20the%20page%2C%20and%20in%20the%20syntax%2C%20change%20the%20brackets%20around%20the%20word%20%5Brace%5D%20to%20braces%2C%20so%20it%20says%20%7Brace%7D%20instead.%20%20Then%20hit%20Generate%20Working%20Copy%2C%20save%20the%20code%20as%20a%20new%20file%2C%20and%20open%20the%20new%20file%20in%20your%20browser.%20%20You%20should%20see%20a%20drop-down%20selector%20that%20allows%20you%20to%20select%20a%20character%20race%20for%20all%20of%20the%20randomized%20results.%20%20In%20this%20new%20version%20you%20just%20created%2C%20character%20race%20is%20not%20randomly%20determined%3B%20it%20is%20picked%20by%20the%20user.%3C/p%3E%0A%3Cp%3EParameters%20default%20to%20the%20first%20value%20in%20their%20data%20list%20when%20they%20are%20created%2C%20and%20will%20until%20you%20manually%20select%20a%20value%20in%20their%20drop-down%20list.%20%20Once%20you%20select%20a%20value%20in%20the%20drop-down%20list%2C%20new%20copies%20of%20the%20page%20you%20make%20will%20default%20to%20that%20value%20until%20you%20pick%20another%20one.%3C/p%3E%0A%3Cp%3EIf%20you%20want%20a%20parameter%20to%20default%20to%20a%20random%20pick%2C%20make%20sure%20that%20the%20first%20line%20in%20the%20data%20list%20for%20that%20parameter%20is%20a%20reference%20to%20the%20data%20list%27s%20own%20name%2C%20like%20this%3A%3C/p%3E%0A%3Cpre%3E%0A%7Crace%0A%5Brace%5D%0Adryad%0Aelf%20%5Bprofession%5D%0A%5Balignment%5D%20human%20%5Bprofession%5D%20%5Bhuman%20origin%5D%0A%5Bdwarf%20alignment%5D%20dwarf%20%5Bdwarf%20profession%5D%0Ahalfling%20%5Bhalfling%20profession%5D%0A%5Bhumanoid%5D%0A%3C/pre%3E%0A%3Cp%3ESo%20long%20as%20the%20first%20line%20of%20the%20list%20is%20the%20name%20of%20the%20list%20in%20brackets%20%28with%20no%20extra%20text%29%2C%20this%20will%20work%20to%20make%20your%20parameters%20default%20to%20random%20picks.%20%20When%20the%20parameter%20is%20set%20to%20be%20the%20first%20line%20of%20that%20list%2C%20it%20ends%20up%20being%20a%20random%20pick%20from%20the%20list.%20%20Be%20sure%20that%20the%20random%20item%20%28the%20first%20one%20in%20the%20list%29%20is%20selected%20in%20the%20parameter%20when%20you%20create%20new%20code%2C%20if%20you%20want%20the%20random%20item%20to%20remain%20the%20default%20for%20the%20new%20code.%3C/p%3E%0A%3Cp%3EParameters%20cannot%20be%20used%20inside%20data%20lists%2C%20only%20in%20the%20main%20syntax%20for%20your%20project.%20%20Items%20in%20curly%20braces%20in%20data%20list%20lines%20will%20just%20be%20treated%20as%20plain%20text%2C%20not%20as%20anything%20special.%3C/p%3E%0A%3Cp%3E%3Cb%3EParameter%20labels%3C/b%3E%20can%20be%20used%20to%20make%20your%20parameters%20more%20user-friendly%2C%20by%20letting%20you%20provide%20plain-language%20descriptions%20for%20each%20of%20the%20choices%20in%20a%20drop-down%20selector.%20%20For%20example%2C%20you%20can%20change%20this%20list%20of%20parameter%20choices%3A%3C/p%3E%0A%3Cselect%3E%3Coption%20value%3D%22dryad%22%20selected%3D%22selected%22%20%3Edryad%3C/option%3E%3Coption%20value%3D%22elf%20%5Bprofession%5D%22%3Eelf%20%5Bprofession%5D%3C/option%3E%3Coption%20value%3D%22%5Balignment%5D%20human%20%5Bprofession%5D%20%5Bhuman%20origin%5D%22%3E%5Balignment%5D%20human%20%5Bprofession%5D%20%5Bhuman%20origin%5D%3C/option%3E%3Coption%20value%3D%22%5Bdwarf%20alignment%5D%20dwarf%20%5Bdwarf%20profession%5D%22%3E%5Bdwarf%20alignment%5D%20dwarf%20%5Bdwarf%20profession%5D%3C/option%3E%3Coption%20value%3D%22halfling%20%5Bhalfling%20profession%5D%22%3Ehalfling%20%5Bhalfling%20profession%5D%3C/option%3E%3Coption%20value%3D%22%5Bhumanoid%5D%22%3E%5Bhumanoid%5D%3C/option%3E%3C/select%3E%3Cp%3EInto%20this%20list%20of%20choices%3A%3C/p%3E%0A%3Cselect%3E%3Coption%20value%3D%22dryad%22%3EDryad%3C/option%3E%3Coption%20value%3D%22elf%20%5Bprofession%5D%22%3EElf%3C/option%3E%3Coption%20value%3D%22%5Balignment%5D%20human%20%5Bprofession%5D%20%5Bhuman%20origin%5D%22%3EHuman%3C/option%3E%3Coption%20value%3D%22%5Bdwarf%20alignment%5D%20dwarf%20%5Bdwarf%20profession%5D%22%3EDwarf%3C/option%3E%3Coption%20value%3D%22halfling%20%5Bhalfling%20profession%5D%22%3EHalfling%3C/option%3E%3Coption%20value%3D%22%5Bhumanoid%5D%22%3ERandom%20humanoid%3C/option%3E%3C/select%3E%3Cp%3EBy%20adding%20parameter%20labels%20to%20the%20data%20list%20on%20which%20that%20selector%20is%20based%2C%20like%20so%3A%3C/p%3E%0A%3Cpre%3E%0A%7Crace%0ADryad%5Edryad%0AElf%5Eelf%20%5Bprofession%5D%0AHuman%5E%5Balignment%5D%20human%20%5Bprofession%5D%20%5Bhuman%20origin%5D%0ADwarf%5E%5Bdwarf%20alignment%5D%20dwarf%20%5Bdwarf%20profession%5D%0AHalfling%5Ehalfling%20%5Bhalfling%20profession%5D%0ARandom%20humanoid%5E%5Bhumanoid%5D%0A%3C/pre%3E%0A%3Cp%3EAs%20you%20can%20see%2C%20anything%20before%20the%20caret%20%28%5E%29%20is%20displayed%20in%20the%20drop-down%20selector%2C%20and%20anything%20after%20the%20caret%20is%20the%20actual%20data%20that%20gets%20used.%3C/p%3E%0A%3Cp%3EWhen%20a%20data%20list%20is%20used%20as%20a%20random%20pick%2C%20parameter%20labels%20do%20not%20appear%20in%20the%20results%2C%20so%20it%27s%20safe%20to%20add%20parameter%20labels%20to%20any%20data%20list%20that%20you%20want%20to%20use%20as%20a%20parameter.%20%20If%20you%20don%27t%20actually%20use%20it%20as%20a%20parameter%2C%20the%20parameter%20labels%20are%20ignored.%3C/p%3E%0A%3Cbr%20/%3E%3Cp%3E%3Cb%3EInline%20data%20lists%3C/b%3E%20are%20a%20quick%20and%20dirty%20way%20of%20putting%20random%20picks%20in%20your%20syntax%20without%20having%20to%20build%20a%20data%20list%20for%20each%20one.%20%20Inline%20data%20lists%20go%20in%20the%20syntax%2C%20and%20are%20enclosed%20in%20%5Bsquare%20brackets%5D%2C%20just%20like%20regular%20data%20lists%2C%20but%20they%20don%27t%20have%20to%20be%20defined%20in%20the%20data%20list%20area%2C%20and%20they%20don%27t%20need%20to%20be%20named.%20%20Within%20the%20square%20brackets%20of%20each%20inline%20data%20list%2C%20put%20in%20the%20items%20you%20want%20in%20the%20list%2C%20separated%20by%20vertical%20pipe%20characters%2C%20like%20this%3A%20%5Bitem1%7Citem2%7Citem3%5D%20and%20that%20inline%20data%20list%20will%20work%20just%20like%20a%20normal%20data%20list.%3C/p%3E%0A%3Cp%3ETo%20see%20an%20inline%20data%20list%20in%20action%2C%20start%20with%20the%20sample%20syntax%20that%20comes%20with%20this%20page%3A%3C/p%3E%0A%3Cpre%3EThe%20%5Brace%5D%20%5Bmotivation%5D%2C%20and%20%5Bsecret%5D%3C/pre%3E%0A%3Cp%3E...and%20add%20a%20simple%20inline%20data%20list%20like%20this%3A%3C/p%3E%0A%3Cpre%3EThe%20%5Bmale%7Cfemale%5D%20%5Brace%5D%20%5Bmotivation%5D%2C%20and%20%5Bsecret%5D%3C/pre%3E%0A%3Cp%3E...then%20click%20the%20Re-Randomize%20button%2C%20and%20see%20how%20it%20works.%3C/p%3E%0A%3Cp%3EInline%20data%20lists%20don%27t%20handle%20multiple%20items%20like%20regular%20data%20lists%2C%20though.%20%20In%20other%20words%2C%20it%20won%27t%20work%20to%20put%20%225@male%22%20in%20an%20inline%20data%20list.%20%20It%20won%27t%20make%20the%20%22male%22%20item%20five%20times%20as%20likely%20to%20come%20up.%20%20If%20you%20want%20that%2C%20you%20have%20to%20make%20a%20regular%20data%20list%20to%20handle%20it.%20%20You%20could%20make%20an%20inline%20list%20that%20goes%20%5Bmale%7Cmale%7Cmale%7Cmale%7Cmale%7Cfemale%5D%20if%20you%20wanted%2C%20and%20that%20would%20work%2C%20but%20it%20might%20be%20easier%20to%20make%20a%20regular%20data%20list%20at%20that%20point.%3C/p%3E%0A%3Cbr%20/%3E%3Cp%3E%3Cb%3EThe%20syntax%20will%20accept%20HTML%20tags%3C/b%3E%2C%20and%20those%20tags%20will%20affect%20the%20formatting%20of%20your%20results%20accordingly.%20%20For%20one%20thing%2C%20the%20randomized%20results%20are%20displayed%20in%20single-cell%20rows%20of%20a%20table%2C%20so%20if%20you%20want%20to%20divide%20your%20results%20up%20into%20columns%2C%20you%20can%20divide%20those%20cells%20up%20like%20this%3A%3C/p%3E%0A%3Cpre%3E%0AThe%20%5Brace%5D%20%26lt%3B/td%26gt%3B%26lt%3Btd%26gt%3B%20%5Bmotivation%5D%20%26lt%3B/td%26gt%3B%26lt%3Btd%26gt%3B%20and%20%5Bsecret%5D%0A%3C/pre%3E%0A%3Cp%3E...and%20that%20will%20divide%20your%20results%20up%20into%20neat%20columns.%20%20You%20can%20use%20just%20about%20any%20HTML%20tags%20your%20browser%20will%20accept%3A%20far%20too%20many%20possibilities%20to%20list%20here.%3C/p%3E%0A%3Cp%3EEnjoy%21%3C/p%3E');

function sto(outputtext) {
    codeoutput += outputtext + "\n";
}

function storeData() {
    var tempArray_Lists = new Array();
    var tempArray_Rows = new Array();
    var posNameEnd = -1;
    var atsign = -1;
    var linenumber = 0;
    pageTitle = document.formMain.txtPageTitle.value.replace(/\"/g, "''");
    document.title = pageTitle;
    document.getElementById("pagetitle").innerHTML = pageTitle;
    pageSubTitle = document.formMain.txtPageSubTitle.value.replace(/\"/g, "''");
    document.getElementById("pagesubtitle").innerHTML = pageSubTitle;
    inputsyntax = document.formMain.txtSyntax.value.replace(/\"/g, "''");
    iterations = document.formMain.txtIterations.value;
    listText = document.formMain.txtLists.value;
    listText = listText.replace(/^\s+/, "");
    listText = listText.replace(/\"/g, "''");
    listText = listText.replace(/^\|/, "");
    tempArray_Lists = listText.split("|");
    listNames = new Array(0);
    lists = new Array(0);
    for (var t = 0; t < (tempArray_Lists.length); t++) {
        posNameEnd = tempArray_Lists[t].search(/\n/);
        listNames[t] = tempArray_Lists[t].slice(0, posNameEnd);
        listNames[t] = listNames[t].replace(/^\s+/, "");
        listNames[t] = listNames[t].replace(/\s+$/, "");
        tempArray_Lists[t] = tempArray_Lists[t].substr(posNameEnd + 1);
        tempArray_Lists[t] = tempArray_Lists[t].replace(/^\s+/, "");
        tempArray_Lists[t] = tempArray_Lists[t].replace(/\s+$/, "");
        tempArray_Rows = tempArray_Lists[t].split(/\n/);
        lists[t] = new Array(0);
        for (var r = 0; r < tempArray_Rows.length; r++) {
            atsign = tempArray_Rows[r].indexOf("@");
            if (atsign == -1) {
                linenumber = 1;
            } else {
                linenumber = 1 * (tempArray_Rows[r].slice(0, atsign));
                tempArray_Rows[r] = tempArray_Rows[r].substr(atsign + 1);
            }
            tempArray_Rows[r] = tempArray_Rows[r].replace(/\s+$/, "");
            if (linenumber > 1000) {
                linenumber = 1000;
            }
            for (var x = 0; x < linenumber; x++) {
                lists[t][lists[t].length] = tempArray_Rows[r];
            }
        }
    }
}
function writeLists() {
    var reviewText = "";
    var lastRow = "";
    var linecount = 0;
    for (var t = 0; t < listNames.length; t++) {
        reviewText += "|" + listNames[t] + "\n";
        linecount = 0;
        for (var y = 0; y < lists[t].length; y++) {
            if (y == 0) {
                linecount = 1;
                lastRow = lists[t][y];
                if (y == (lists[t].length - 1)) {
                    reviewText += linecount + "@" + lastRow + "\n";
                }
            } else {
                if (lastRow == lists[t][y]) {
                    linecount += 1;
                    if (y == (lists[t].length - 1)) {
                        reviewText += linecount + "@" + lastRow + "\n";
                    }
                } else {
                    reviewText += linecount + "@" + lastRow + "\n";
                    lastRow = lists[t][y];
                    linecount = 1;
                    if (y == (lists[t].length - 1)) {
                        reviewText += linecount + "@" + lastRow + "\n";
                    }
                }
            }
        }
        reviewText = reviewText.replace(/\'\'/g, "\"");
        reviewText += "\n";
    }
    return reviewText;
}
function writeArrayLists() {
    var outputstring = "";
    outputstring += "var listNames = new Array(\"" + listNames.join("\", \"") + "\");\n";
    outputstring += "var lists = new Array(" + lists.length + ");\n";
    for (var t = 0; t < lists.length; t++) {
        outputstring += "lists[" + t + "] = new Array(\"" + lists[t].join("\", \"") + "\");\n";
    }
    return outputstring;
}
function writeParameters() {
    var outputstring = "";
    var parameterArray = new Array(0);
    var parameterName = "";
    var listIndex = -1;
    var labelPos = -1;
    var selectedText = "";
    var selectorObj = {};
    var parameterExpression = /\{([^\{\}]+)\}/g;
    parameterArray = inputsyntax.match(parameterExpression);
    if (parameterArray) {
        for (var x = 0; x < parameterArray.length; x++) {
            parameterArray[x] = parameterArray[x].replace(/[\{\}]/g, "");
            for (var i = 0; i < (listNames.length); i++) {
                if (listNames[i] == parameterArray[x]) {
                    listIndex = i;
                    break;
                }
            }
            if (listIndex != -1) {
                if (document.getElementById("sel" + parameterArray[x])) {
                    selectorObj = document.getElementById("sel" + parameterArray[x]);
                    if (selectorObj.options[selectorObj.selectedIndex].value == selectorObj.options[selectorObj.selectedIndex].text) {
                        selectedText = selectorObj.options[selectorObj.selectedIndex].value;
                    } else {
                        selectedText = selectorObj.options[selectorObj.selectedIndex].text + "^" + selectorObj.options[selectorObj.selectedIndex].value;
                    }
                }
                outputstring += "\n<tr><td><b>Pick the " + parameterArray[x] + ": </b></td><td><select id=\"sel" + parameterArray[x] + "\">";
                for (var l = 0; l < lists[listIndex].length; l++) {
                    if (l == 0 ||
                        (l != 0 &&
                        (lists[listIndex][l] != lists[listIndex][l - 1]))) {
                        labelPos = lists[listIndex][l].indexOf("^");
                        if (labelPos != -1) {
                            outputstring += "<option value=\"" + lists[listIndex][l].slice(lists[listIndex][l].indexOf("^") + 1) + "\"" + (selectedText == lists[listIndex][l] ? " selected=\"selected\" " : "") + ">" + lists[listIndex][l].slice(0, lists[listIndex][l].indexOf("^")) + "</option>";
                        } else {
                            outputstring += "<option value=\"" + lists[listIndex][l] + "\"" + (selectedText == lists[listIndex][l] ? " selected=\"selected\" " : "") + ">" + lists[listIndex][l] + "</option>";
                        }
                    }
                }
                outputstring += "</select></td></tr>";
            }
        }
    }
    return outputstring;
}
function convertSyntax(rawsyntax, mode) {
    var cleanSyntax;
    cleanSyntax = rawsyntax;
    cleanSyntax = cleanSyntax.replace(/\'/g, "\\'");
    cleanSyntax = cleanSyntax.replace(/^([^\[])/, "'$1");
    cleanSyntax = cleanSyntax.replace(/([^\]])$/, "$1'");
    cleanSyntax = cleanSyntax.replace(/^#([^#]+)#$/, "Dice('$1')");
    cleanSyntax = cleanSyntax.replace(/^#([^#]+)#/, "Dice('$1') + '");
    cleanSyntax = cleanSyntax.replace(/#([^#]+)#$/, "' + Dice('$1')");
    cleanSyntax = cleanSyntax.replace(/#([^#]+)#/g, "' + Dice('$1') + '");
    cleanSyntax = cleanSyntax.replace(/^\[([^\[\]]+)\]$/, "Roll('$1')");
    cleanSyntax = cleanSyntax.replace(/^\[([^\[\]]+)\]/, "Roll('$1') + '");
    cleanSyntax = cleanSyntax.replace(/\[([^\[\]]+)\]$/, "' + Roll('$1')");
    cleanSyntax = cleanSyntax.replace(/\[([^\[\]]+)\]/g, "' + Roll('$1') + '");
    if (mode == "param") {
        cleanSyntax = cleanSyntax.replace(/^\{([^\{\}]+)\}$/, "Pick('$1')");
        cleanSyntax = cleanSyntax.replace(/^\{([^\{\}]+)\}/, "Pick('$1') + '");
        cleanSyntax = cleanSyntax.replace(/\{([^\{\}]+)\}$/, "' + Pick('$1')");
        cleanSyntax = cleanSyntax.replace(/\{([^\{\}]+)\}/g, "' + Pick('$1') + '");
    }
    return cleanSyntax;
}
function Roll(arrayName) {
    var nameIndex = -1;
    var resultText = "";
    var resultCode = "";
    var inlineList;
    for (var i = 0; i < (listNames.length); i++) {
        if (listNames[i] == arrayName) {
            nameIndex = i;
            break;
        }
    }
    if (nameIndex == -1) {
        inlineList = arrayName.split("|");
        if (inlineList.length > 1) {
            resultText = inlineList[Math.floor(Math.random() * inlineList.length)];
            resultCode = resultText;
            resultCode = resultCode.replace(/^\s+/, "");
            resultCode = resultCode.replace(/\s+$/, "");
            if (resultCode.search(/\[[^\[\]]+\]/) != -1) {
                resultCode = convertSyntax(resultCode, "noparam");
                resultText = eval(resultCode);
            }
        } else {
            return "<b><i>(" + arrayName + " list not found)</i></b>";
        }
    } else {
        resultText = lists[nameIndex][Math.floor(Math.random() * lists[nameIndex].length)];
        if (resultText.indexOf("^") != -1) {
            resultText = resultText.slice((resultText.indexOf("^")) + 1);
        }
        resultCode = resultText;
        resultCode = resultCode.replace(/^\s+/, "");
        resultCode = resultCode.replace(/\s+$/, "");
        if ((resultCode.search(/\[[^\[\]]+\]/) != -1) ||
            (resultCode.search(/#[^#]+#/) != -1)) {
            resultCode = convertSyntax(resultCode, "noparam");
            resultText = eval(resultCode);
        }
    }
    return resultText;
}
function Pick(arrayName) {
    var listIndex = -1;
    var resultText = "";
    var resultCode = "";
    var selectorID = "";
    for (var i = 0; i < (listNames.length); i++) {
        if (listNames[i] == arrayName) {
            listIndex = i;
            break;
        }
    }
    if (listIndex == -1) {
        return "<b><i>(" + arrayName + " list not found)</i></b>";
    } else {
        selectorID = "sel" + arrayName;
        if (document.getElementById(selectorID)) {
            selectorID = document.getElementById(selectorID);
            resultText = selectorID.options[selectorID.selectedIndex].value;
        } else {
            resultText = lists[listIndex][0];
            if (resultText.indexOf("^") != -1) {
                resultText = resultText.slice((resultText.indexOf("^")) + 1);
            }
        }
    }
    resultCode = resultText;
    resultCode = resultCode.replace(/^\s+/, "");
    resultCode = resultCode.replace(/\s+$/, "");
    if ((resultCode.search(/\[[^\[\]]+\]/) != -1) ||
        (resultCode.search(/#[^#]+#/) != -1)) {
        resultCode = convertSyntax(resultCode, "noparam");
        resultText = eval(resultCode);
    }
    return resultText;
}
function RollDie(dieSides) {
    if (dieSides == "f") {
        var fudgeArray = new Array(-1, 0, 1);
        return fudgeArray[Math.floor(Math.random() * fudgeArray.length)];
    } else {
        return Math.floor(Math.random() * dieSides) + 1;
    }
}
function Dice(diceString) {
    var dPos = -1, numDice = 0, negDice = 0, dieSides = 0, numTemp = 0, numResult = 0;
    var diceArray = new Array();
    var resultArray = new Array();
    diceString = diceString.toLowerCase();
    diceString = diceString.replace(/-/g, "+-");
    diceArray = diceString.split("+");
    diceString = diceString.replace(/\+-/g, "-");
    for (var i = 0; i < diceArray.length; i++) {
        dPos = diceArray[i].indexOf("d");
        if (dPos != -1) {
            numDice = diceArray[i].slice(0, dPos);
            dieSides = diceArray[i].slice(dPos + 1);
            if (isNaN(numDice)) {
                return "<b>\"" + numDice + "\" is not a valid number of dice</b>";
            }
            if (isNaN(dieSides)) {
                return "<b>\"" + dieSides + "\" is not a valid number of sides</b>";
            }
            negDice = 0;
            if (numDice < 0) {
                negDice = 1;
                numDice *= -1;
            }
            for (var x = 0; x < numDice; x++) {
                numTemp = RollDie(dieSides);
                if (negDice == 1) {
                    numTemp *= -1;
                }
                numResult += (numTemp * 1);
            }
        } else {
            if (!isNaN(diceArray[i]) &&
                diceArray[i] != "" && diceArray[i] != 0) {
                numResult += (diceArray[i] * 1);
            }
        }
    }
    return numResult;
}
function writeResults(mode) {
    if (mode == "working") {
        storeData();
        document.formMain.txtLists.value = writeLists();
    }
    output = "";
    for (var i = 0; i < iterations; i++) {
        output += "<tr><td>" + eval(convertSyntax(inputsyntax, "param")) + "</td></tr>";
    }
    document.getElementById("resultarea").innerHTML = "<table border=\"0\">" + output.replace(/\'\'/g, "\"") + "</table>";
}
function writeFinal() {
    var tempsyntax = "";
    storeData();
    document.formMain.txtLists.value = writeLists();
    codeoutput = "";
    sto("<html>\n");
    sto("<head>\n");
    sto("<script language='JavaScript'>\n");
    sto("var iterations = " + iterations + ";");
    sto("var inputsyntax = \"" + inputsyntax + "\";");
    sto("var output = '';");
    sto(writeArrayLists());
    sto(convertSyntax.toString());
    sto(Roll.toString());
    sto(Pick.toString());
    sto(RollDie.toString());
    sto(Dice.toString());
    sto(writeResults.toString());
    sto("<\/script>\n");
    sto("<title>" + pageTitle + "</title>\n");
    sto("</head>\n");
    sto("<body style='background-color:" + docBackground + "; color:" + docText + ";" + docFont + "'>\n");
    sto("<h2 id='pagetitle'>" + pageTitle + "</h2>\n");
    sto("<p id='pagesubtitle' style='font-weight: bold; font-style: italic;'>" + pageSubTitle + "</p>\n");
    sto("<form name='formMain'>\n");
    sto("<div id='resultarea' style='border: thin solid; padding: 0.75em; float: left;'></div>\n");
    sto("<br clear='both' /><br />\n");
    sto("<table id='parameterarea' style='float: left;'>" + writeParameters() + "</table>\n");
    sto("<br clear='both' /><br />\n");
    sto("<input type='button' name='btnRandomize' value='Re-Randomize Results' onClick='javascript:writeResults(\"final\");' />\n");
    sto("</form>\n");
    sto("<script language='JavaScript'>writeResults(\"final\");<\/script>\n");
    sto("<!--");
    sto("Just in case you ever need to turn this final copy back into a working copy,");
    sto("here are the syntax and data lists for a working copy of this randomizer.  You can copy and paste");
    sto("them back into a new working copy to save yourself the work of starting from scratch.\n");
    sto("Syntax:\n");
    sto(inputsyntax + "\n");
    sto("Data lists:\n");
    sto(writeLists());
    sto("-->\n");
    sto("If you want to customize this page by adding text, here's a good place.\n");
    sto("</body>\n");
    sto("</html>");
    document.formMain.txtCodeArea.value = codeoutput;
    document.formMain.txtLists.value = writeLists();
    document.formMain.txtCodeArea.select();
    if (!helpShown) {
        alert(helpText);
        helpShown = true;
    }
}
function writeWIP() {
    storeData();
    document.formMain.txtLists.value = writeLists();
    codeoutput = "";
    sto("<html>\n");
    sto("<head>\n");
    sto("<script language='JavaScript'>\n");
    sto("var listNames = new Array(0);");
    sto("var lists = new Array(0);");
    sto("var pageTitle = \"" + pageTitle + "\";");
    sto("var pageSubTitle = \"" + pageSubTitle + "\";");
    sto("var iterations = " + iterations + ";");
    sto("var inputsyntax = \"" + inputsyntax + "\";");
    sto("var output = '';");
    sto("var codeoutput = '';");
    sto("var listText = '';");
    sto("var helpShown = false;");
    sto("var textareaWidth = " + textareaWidth + ";");
    sto("var textareaHeight = " + textareaHeight + ";");
    sto("var docBackground = '" + docBackground + "';");
    sto("var docText = '" + docText + "';");
    sto("var docFont = '" + docFont + "';");
    sto("var helpText = unescape('" + escape(helpText) + "');");
    sto("var instructionText = unescape('" + escape(instructionText) + "');\n");
    sto(textareaWider.toString());
    sto(textareaNarrower.toString());
    sto(textareaTaller.toString());
    sto(textareaShorter.toString());
    sto(setBackground.toString());
    sto(setText.toString());
    sto(setFont.toString());
    sto(sto.toString());
    sto(prepFunc.toString());
    sto(storeData.toString());
    sto(writeLists.toString());
    sto(writeArrayLists.toString());
    sto(writeParameters.toString());
    sto(convertSyntax.toString());
    sto(Roll.toString());
    sto(Pick.toString());
    sto(RollDie.toString());
    sto(Dice.toString());
    sto(writeResults.toString());
    sto(prepFunc(writeFinal.toString()));
    sto(prepFunc(writeWIP.toString()));
    sto("<\/script>\n");
    sto("<title>" + pageTitle + "</title>\n");
    sto("</head>\n");
    sto("<body style='background-color:" + docBackground + "; color:" + docText + ";" + docFont + "'>\n");
    sto("<h2 id='pagetitle'>" + pageTitle + "</h2>\n");
    sto("<p id='pagesubtitle' style='font-weight: bold; font-style: italic;'>" + pageSubTitle + "</p>\n");
    sto("<form name='formMain'>\n");
    sto("<div id='resultarea' style='border: thin solid; padding: 0.75em; float: left;'></div>\n");
    sto("<br clear='both' /><br />\n");
    sto("<table id='parameterarea' style='float: left;'>" + writeParameters() + "</table>\n");
    sto("<br clear='both' /><br />\n");
    sto("<input type='button' name='btnRandomize' value='Re-Randomize Results' onClick='javascript:writeResults(\"working\");' />\n");
    sto("<br />\n<br />\n");
    sto("<table border='0'>\n");
    sto("<tr><td align='left' width='330'><b>Enter the syntax for your random phrase here:</b></td>\n");
    sto("<td align='left' width='100'>&nbsp;</td>\n");
    sto("<td align='left' width='*'><b>Generate</b> <input type='text' name='txtIterations' width='3' size='3' value='" + iterations + "' /> <b>results.</b></td></tr>\n");
    sto("<tr><td colspan='3'><input type='text' name='txtSyntax' size='112' value=\"" + inputsyntax + "\" /></td></tr>\n");
    sto("<tr><td colspan='3'>&nbsp;</td></tr>\n");
    sto("<tr><td align='left'><b>Enter your data lists here:</b></td>\n");
    sto("<td align='left' colspan='2'>Make this area\n");
    sto("<input type='button' name='btnWider' value='Wider' onClick='javascript:textareaWider();' />\n");
    sto("<input type='button' name='btnNarrower' value='Narrower' onClick='javascript:textareaNarrower();' />\n");
    sto("<input type='button' name='btnTaller' value='Taller' onClick='javascript:textareaTaller();' />\n");
    sto("<input type='button' name='btnShorter' value='Shorter' onClick='javascript:textareaShorter();' /></td></tr>\n");
    sto("<tr><td colspan='3'><textarea name='txtLists' wrap='off' rows='" + textareaHeight + "' cols='" + textareaWidth + "' />" + writeLists() + "</textarea></td></tr>\n");
    sto("<tr><td colspan='3'>&nbsp;</td></tr>\n");
    sto("<tr><td colspan='3'><b>Change the page title here:</b>\n");
    sto("<input type='text' name='txtPageTitle' width='50' size='50' value=\"" + pageTitle + "\" /></td></tr>\n");
    sto("<tr><td colspan='3'><b>Change the subtitle here:</b>\n");
    sto("<input type='text' name='txtPageSubTitle' size='70' value=\"" + pageSubTitle + "\" /></td></tr>\n");
    sto("<tr><td colspan='3'>&nbsp;</td></tr>\n");
    sto("<tr><td colspan='3'><b>Background:</b> <input type='text' name='txtBackground' size='7' value='" + docBackground + "' onChange='setBackground(this.value);' /><select id='selBackground' name='selBackground' onChange='setBackground(this.options[this.selectedIndex].value);'><option value='#FFFFFF' style='background-color:#FFFFFF;' selected='selected'>default</option><option value='#FFFFFF' style='background-color:#FFFFFF;'>White</option><option value='#CCCCCC' style='background-color:#CCCCCC;'>lt. gray</option><option value='#999999' style='background-color:#999999;'>md. gray</option><option value='#666666' style='background-color:#666666;'>dk. gray</option><option value='#333333' style='background-color:#333333;'>charcoal</option><option value='#000000' style='background-color:#000000;'>black</option><option value='#FFFFCC' style='background-color:#FFFFCC;'>pale beige</option><option value='#CCCC99' style='background-color:#CCCC99;'>lt. beige</option><option value='#999966' style='background-color:#999966;'>md. beige</option><option value='#666633' style='background-color:#666633;'>dk. beige</option><option value='#666600' style='background-color:#666600;'>brown</option><option value='#333300' style='background-color:#333300;'>dk. brown</option><option value='#999900' style='background-color:#999900;'>olive</option><option value='#990000' style='background-color:#990000;'>dusty red</option><option value='#FF0000' style='background-color:#FF0000;'>red</option><option value='#CC6600' style='background-color:#CC6600;'>dusty orange</option><option value='#FF6600' style='background-color:#FF6600;'>orange</option><option value='#FF9933' style='background-color:#FF9933;'>tangerine</option><option value='#FFFF66' style='background-color:#FFFF66;'>pale yellow</option><option value='#FFFF00' style='background-color:#FFFF00;'>yellow</option><option value='#00FF33' style='background-color:#00FF33;'>green</option><option value='#009900' style='background-color:#009900;'>dk. green</option><option value='#009999' style='background-color:#009999;'>dk. teal</option><option value='#0000FF' style='background-color:#0000FF;'>blue</option><option value='#000099' style='background-color:#000099;'>dk. blue</option><option value='#FF3399' style='background-color:#FF3399;'>pink</option><option value='#9900FF' style='background-color:#9900FF;'>lavender</option><option value='#990099' style='background-color:#990099;'>purple</option></select> <b>Text Color:</b> <input type='text' name='txtText' size='7' value='" + docText + "' onChange='setText(this.value);' /><select id='selText' name='selText' onChange='setText(this.options[this.selectedIndex].value);'><option value='#000000' style='background-color:#000000;' selected='selected'>default</option><option value='#FFFFFF' style='background-color:#FFFFFF;'>White</option><option value='#CCCCCC' style='background-color:#CCCCCC;'>lt. gray</option><option value='#999999' style='background-color:#999999;'>md. gray</option><option value='#666666' style='background-color:#666666;'>dk. gray</option><option value='#333333' style='background-color:#333333;'>charcoal</option><option value='#000000' style='background-color:#000000;'>black</option><option value='#FFFFCC' style='background-color:#FFFFCC;'>pale beige</option><option value='#CCCC99' style='background-color:#CCCC99;'>lt. beige</option><option value='#999966' style='background-color:#999966;'>md. beige</option><option value='#666633' style='background-color:#666633;'>dk. beige</option><option value='#666600' style='background-color:#666600;'>brown</option><option value='#333300' style='background-color:#333300;'>dk. brown</option><option value='#999900' style='background-color:#999900;'>olive</option><option value='#990000' style='background-color:#990000;'>dusty red</option><option value='#FF0000' style='background-color:#FF0000;'>red</option><option value='#CC6600' style='background-color:#CC6600;'>dusty orange</option><option value='#FF6600' style='background-color:#FF6600;'>orange</option><option value='#FF9933' style='background-color:#FF9933;'>tangerine</option><option value='#FFFF66' style='background-color:#FFFF66;'>pale yellow</option><option value='#FFFF00' style='background-color:#FFFF00;'>yellow</option><option value='#00FF33' style='background-color:#00FF33;'>green</option><option value='#009900' style='background-color:#009900;'>dk. green</option><option value='#009999' style='background-color:#009999;'>dk. teal</option><option value='#0000FF' style='background-color:#0000FF;'>blue</option><option value='#000099' style='background-color:#000099;'>dk. blue</option><option value='#FF3399' style='background-color:#FF3399;'>pink</option><option value='#9900FF' style='background-color:#9900FF;'>lavender</option><option value='#990099' style='background-color:#990099;'>purple</option></select> <b>Font:</b> <select name='selFont' onChange='setFont(this.options[this.selectedIndex].value);'><option value='' selected='selected'>default</option><option value='serif'>serif</option><option value='sans-serif'>sans-serif</option><option value='monospace'>fixed-width</option></select></td></tr>\n");
    sto("<tr><td colspan='3'>&nbsp;</td></tr>\n");
    sto("<tr><td colspan='3'><b>New Code:</b> <input type='button' name='btnWorkingCopy' value='Generate Working Copy' onClick='javascript:writeWIP();' />\n");
    sto("<input type='button' name='btnFinalCopy' value='Generate Final Copy' onClick='javascript:writeFinal();' /></td></tr>\n");
    sto("</table>\n");
    sto("<textarea name='txtCodeArea' wrap='off' rows='10' cols='84' style='display:block;' /></textarea>\n");
    sto("</form>\n");
    sto("<script language='JavaScript'>writeResults(\"working\");\n\n document.write(instructionText);<\/script>\n");
    sto("</body>\n");
    sto("</html>");
    document.formMain.txtCodeArea.value = codeoutput;
    document.formMain.txtCodeArea.select();
    if (!helpShown) {
        alert(helpText);
        helpShown = true;
    }
}