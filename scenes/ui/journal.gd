
extends CanvasLayer


# =====================================================
# REFERÊNCIAS AOS ELEMENTOS DA INTERFACE
# =====================================================

@onready var _root: Control = $Root

@onready var _page_title: Label = $Root/Center/Panel/Layout/Title
@onready var _page_subtitle: Label = $Root/Center/Panel/Layout/Subtitle
@onready var _page_content: Label = $Root/Center/Panel/Layout/Scroll/PageContent
@onready var _page_image: TextureRect = $Root/Center/Panel/Layout/PageImage

@onready var _page_counter: Label = $Root/Center/Panel/Layout/Footer/PageCounter

@onready var _previous_button: Button = $Root/Center/Panel/Layout/Footer/PreviousButton
@onready var _next_button: Button = $Root/Center/Panel/Layout/Footer/NextButton
@onready var _close_button: Button = $Root/Center/Panel/Layout/Footer/CloseButton


# =====================================================
# CONTROLE DO DIÁRIO
# =====================================================

var _paused_before_open: bool = false

var _current_page: int = 0


# =====================================================
# PÁGINAS DO DIÁRIO
# Cada página possui:
# title, subtitle, content, image e category
# =====================================================

var _pages: Array[Dictionary] = [

# =================================================
# INTRODUÇÃO
# =================================================
{
	"title": "Diário da Apotecária",
	"subtitle": "Introdução do Jogo",
	"content": """Saudações, pequeno viajante! Se estas páginas chegaram até suas patas, significa que nossa parceria está oficialmente começando. Como não posso mais percorrer as terras em busca dos ingredientes de que necessito, por conta das minhas costelas machucadas, precisarei confiar em você para realizar nossas expedições. Antes de partir, entretanto, há algumas coisas que deve aprender sobre este mundo.

SOBRE AS REGIÕES:
As terras que nos cercam são divididas em seis grandes regiões: Amazônia, Caatinga, Campos e Rios, Cerrado, Litoral e Mata Atlântica. Cada uma possui seu próprio ecossistema, com plantas, frutos e outros recursos que podem ser aproveitados em nossas preparações.

Mas cuidado: não são lugares tão simples quanto parecem. Cada região esconde labirintos misteriosos, cujos caminhos se reorganizam constantemente. Nenhuma expedição é exatamente igual à anterior! Corredores mudam de posição, passagens surgem e desaparecem, e aquilo que você encontrou em uma jornada pode não estar no mesmo lugar na próxima.

DOS INGREDIENTES:
Os recursos de que precisamos podem aparecer espalhados pelo chão dos labirintos. Sua localização é imprevisível: em cada andar, os ingredientes são distribuídos aleatoriamente, e será necessário explorar cada canto para encontrá-los.

Entretanto, nem todos os ingredientes crescem em qualquer lugar. Cada espécie possui suas próprias características e prefere determinadas condições ambientais. Por isso, alguns recursos só podem ser encontrados em regiões específicas. Consulte sempre este diário para descobrir onde procurar.

Há ainda uma particularidade nesses labirintos: alguns ingredientes aparecem apenas nos andares pares, enquanto outros podem ser encontrados somente nos andares ímpares. Tenha isso em mente antes de decidir até onde deseja explorar!

DAS CRIATURAS E DA ESCURIDÃO:
Infelizmente, os labirintos não estão desabitados. Criaturas de comportamento agressivo também surgem aleatoriamente pelos andares e podem representar um perigo durante sua busca.

Elas nem sempre percebem sua presença imediatamente, mas, quando uma delas avistar você, partirá em sua direção sem hesitar! Nem toda batalha precisa ser enfrentada, meu pequeno ajudante. Com velocidade e atenção, talvez consiga correr o suficiente para despistá-las antes que se aproximem demais.

Caso decida enfrentá-las, lembre-se de que cada criatura derrotada fará a luz se espalhar um pouco mais pelo andar, enfraquecendo a escuridão que esconde os caminhos. Ainda assim, tenha cuidado: ao avançar para um novo andar, a escuridão voltará a dominar o ambiente.

DAS PASSAGENS E DOS CAMINHOS:
Todo andar possui uma saída que permite continuar a exploração. Ao encontrá-la, você poderá escolher entre três caminhos: descer para o próximo andar da mesma região, retornar ao primeiro andar de outra região ou voltar diretamente para nossa cabana.

Pense bem antes de escolher! Quanto mais fundo avançar, mais oportunidades terá de encontrar os ingredientes necessários, mas também precisará enfrentar os perigos de novos andares. E lembre-se: não há vergonha alguma em retornar quando sua mochila estiver cheia ou quando a situação se tornar perigosa.

DOS PACIENTES E DAS PREPARAÇÕES:
De tempos em tempos, viajantes e habitantes destas terras chegarão à nossa cabana em busca de auxílio. Cada paciente poderá apresentar uma entre dez condições que já estudei e registrei neste diário.

Cada condição exige ingredientes específicos para que possamos preparar o tratamento adequado. Algumas preparações precisam de três ingredientes diferentes, enquanto outras podem exigir quatro. Não basta trazer qualquer planta ou fruto que encontrar pelo caminho: é importante conhecer suas propriedades e entender por que determinados recursos são mais apropriados para cada necessidade.

Consulte a seção de condições para descobrir quais ingredientes devemos procurar. Depois, visite a seção de regiões para identificar onde cada um deles pode ser encontrado. Com planejamento, conhecimento e um pouco de coragem, conseguiremos reunir tudo de que precisamos!

UMA ÚLTIMA RECOMENDAÇÃO:
Nossa cabana será sempre seu ponto de partida e seu refúgio. Quando retornar, poderei receber os ingredientes encontrados, preparar os tratamentos e atender aos pacientes que aguardam nossa ajuda.

Este mundo guarda inúmeros segredos, e cada expedição é uma oportunidade de aprender algo novo sobre suas plantas, animais e propriedades naturais.

Agora, Mingau, cuide de suas patas, mantenha os olhos atentos e não deixe a curiosidade falar mais alto que a prudência. Temos muito trabalho pela frente!

Com carinho,
A Apotecária.""",
	"image": "",
	"category": "introduction"
},

{
	"title": "Controles",
	"subtitle": "Introdução",
	"content": """Controles do jogo:

MOVIMENTAÇÃO
- W, A, S, D ou Setas direcionais: movimentar Mingau pelo cenário.

AÇÕES
- Espaço: atacar criaturas próximas.
- E: interagir com personagens e objetos.

INVENTÁRIO E INFORMAÇÕES
- I: abrir ou fechar a mochila, onde ficam armazenados os ingredientes encontrados durante as expedições.
- J: abrir ou fechar o Diário da Apotecária, onde você pode consultar informações sobre condições, ingredientes e regiões.

OUTROS
- Esc: pausar o jogo e acessar o menu de pausa.
- Mouse: selecionar opções e interagir com os elementos dos menus.

DICAS:
- A mochila possui seis espaços e permite acumular várias unidades do mesmo ingrediente.
- Cada região possui ingredientes específicos, que podem aparecer em andares pares ou ímpares.
- Derrotar criaturas aumenta temporariamente a iluminação do andar, facilitando a exploração.
- O combate é opcional! Você pode evitar os confrontos, coletar os ingredientes e procurar a saída para continuar sua jornada.

Boa sorte, Mingau! A apotecária está contando com você.""",
	"image": "",
	"category": "introduction"
},



	# =================================================
	# REGIÕES
	# =================================================


	{
		"title": "Amazônia",
		"subtitle": "Região",
		"content": """A Amazônia é uma das regiões mais exuberantes deste mundo. Sua imensa floresta é atravessada por rios de águas escuras e barrentas, igarapés e áreas alagadas que mudam de aparência conforme as cheias. Árvores enormes formam um verdadeiro teto verde, enquanto cipós, palmeiras e plantas de todos os tamanhos disputam espaço em meio à vegetação.

A umidade é constante em boa parte da região, e muitos de seus frutos crescem próximos às margens dos rios e em terrenos inundáveis. Entre as descobertas mais interessantes estão o Buriti e o Camu-Camu, frutos de plantas adaptadas a ambientes com bastante água. Também é possível encontrar a Unha de Gato, uma trepadeira que utiliza outras árvores como apoio para alcançar a luz.

A Resina de Copaíba é outro recurso importante. Ela é obtida do tronco de árvores conhecidas como copaibeiras, que produzem um óleo-resina utilizado há muito tempo por comunidades amazônicas.

Os itens encontrados nesta região são:

1. Resina de Copaíba — andares pares. Óleo-resina extraído do tronco da copaibeira.
2. Buriti — andares ímpares. Fruto de uma grande palmeira que cresce em áreas úmidas e alagadas.
3. Camu-Camu — andares ímpares. Pequeno fruto amazônico encontrado principalmente nas margens de rios e lagos.
4. Unha de Gato — andares pares. Planta trepadeira de origem amazônica.

Estas espécies e seus recursos fazem parte da riqueza natural da Amazônia do mundo de Mingau. É uma região onde a água e a floresta estão profundamente conectadas, e cada expedição pode revelar uma nova descoberta.""",
		"image": "",
		"category": "region"
	},

	{
		"title": "Caatinga",
		"subtitle": "Região",
		"content": """A Caatinga é uma região de clima quente e predominantemente semiárido. Sua paisagem é marcada por longos períodos de seca, vegetação adaptada à falta de água e árvores de troncos retorcidos. Ao contrário do que muitos imaginam, a Caatinga não é uma região sem vida: quando chegam as chuvas, o cenário pode se transformar rapidamente, cobrindo o solo de vegetação, flores e pequenos frutos.

Entre suas plantas mais conhecidas está o Licuri, uma palmeira muito importante para as comunidades locais. Seus pequenos frutos possuem uma amêndoa bastante aproveitada na alimentação. Também encontramos o Alecrim-Pimenta, uma planta aromática característica do Nordeste brasileiro, adaptada às condições quentes da região.

A Acerola pode ser encontrada em pomares e áreas de cultivo, sendo muito apreciada por seus frutos. Já o cajueiro, conhecido pela produção da castanha de caju, é muito associado ao Nordeste, tanto no litoral quanto em áreas do sertão.

Os itens encontrados nesta região são:

1. Castanha de Caju — andares ímpares. Semente do cajueiro, árvore muito cultivada no Nordeste.
2. Acerola — andares pares. Pequeno fruto de uma planta cultivada em regiões tropicais.
3. Alecrim-Pimenta — andares ímpares. Planta aromática nativa do Nordeste brasileiro.
4. Licuri — andares pares. Fruto de uma palmeira particularmente adaptada às regiões secas.

A Caatinga exige adaptação e resistência. Suas plantas desenvolveram diferentes maneiras de enfrentar a escassez de água, e conhecer suas características é essencial para quem deseja explorar essa região.""",
		"image": "",
		"category": "region"
	},

	{
		"title": "Campos e Rios",
		"subtitle": "Região",
		"content": """Campos e Rios é uma região de paisagens abertas, pastagens, pequenas matas e extensos cursos de água. Seu cenário lembra algumas das paisagens do interior brasileiro, onde rios atravessam campos, árvores acompanham suas margens e pequenas propriedades rurais fazem parte da vida cotidiana.

As áreas próximas aos rios possuem vegetação mais abundante, enquanto os campos abertos apresentam gramíneas e plantas de diferentes tamanhos. Em determinados períodos, as águas podem subir e inundar terrenos baixos, formando lagoas e pequenas áreas alagadas que abrigam diversos animais.

Nem todos os recursos encontrados aqui vêm diretamente da vegetação silvestre. Algumas descobertas estão relacionadas às atividades humanas, como a criação de animais, o cultivo de alimentos e a pesca em açudes e viveiros. A Pele de Tilápia, por exemplo, é obtida de um peixe de origem africana que foi introduzido no Brasil e se tornou muito utilizado na piscicultura.

Os itens encontrados nesta região são:

1. Pele de Tilápia — andares ímpares. Parte externa de um peixe criado em ambientes de água doce.
2. Banana da Terra — andares ímpares. Fruto de uma planta cultivada em propriedades rurais.
3. Fígado Bovino — andares pares. Órgão obtido de animais criados na pecuária.
4. Erva Cidreira — andares pares. Planta aromática encontrada em quintais, hortas e áreas cultivadas.
5. Semente de Chia — andares pares. Semente de uma planta cultivada para fins alimentícios.

Esta região demonstra como a natureza e as atividades humanas podem coexistir. Seus rios fornecem água, alimento e caminhos de exploração, enquanto os campos e as propriedades rurais oferecem outros recursos importantes para a sobrevivência.""",
		"image": "",
		"category": "region"
	},

	{
		"title": "Cerrado",
		"subtitle": "Região",
		"content": """O Cerrado é uma região de vastas paisagens abertas, árvores de troncos retorcidos e vegetação adaptada a períodos de seca. Em algumas áreas, predominam campos com gramíneas e arbustos; em outras, árvores de maior porte formam pequenas matas. O solo, o clima e a passagem natural do fogo influenciam bastante a aparência de sua vegetação.

Uma das maiores riquezas dessa região está em seus frutos. O Pequi é um dos símbolos do Cerrado brasileiro, produzido por uma árvore de copa ampla e frutos de casca verde. Seu interior possui uma polpa amarelada e um caroço com espinhos, exigindo cuidado durante o consumo.

Também é possível encontrar a Arnica Brasileira, conhecida em algumas localidades como Arnica-do-Cerrado, uma planta associada principalmente aos campos rupestres e áreas de altitude. O Assa-Peixe cresce em áreas abertas e ensolaradas, sendo uma planta bastante visitada por abelhas. O Mulungu completa nossas descobertas, aparecendo em trechos de vegetação arbórea e áreas de transição desta região.

Os itens encontrados nesta região são:

1. Mulungu — andares pares. Planta de porte arbóreo, conhecida por suas flores e sementes.
2. Pequi — andares ímpares. Fruto característico do Cerrado, produzido por uma árvore nativa.
3. Arnica Brasileira — andares pares. Planta arbustiva encontrada principalmente em campos rupestres e áreas de altitude.
4. Flor de Assa-Peixe — andares ímpares. Inflorescência de uma planta que cresce em terrenos abertos.

O Cerrado pode parecer uma região simples à primeira vista, mas sua biodiversidade é extraordinária. Entre campos, árvores e terrenos pedregosos, existem espécies que desenvolveram características muito particulares para sobreviver às condições locais.""",
		"image": "",
		"category": "region"
	},

	{
		"title": "Litoral Brasileiro",
		"subtitle": "Região",
		"content": """O Litoral Brasileiro reúne paisagens bastante variadas, desde praias de areia clara e águas tranquilas até regiões de dunas, falésias, restingas e manguezais. É uma região onde a presença do oceano influencia diretamente o clima, a vegetação e a vida dos animais.

A vegetação litorânea precisa suportar condições particulares, como ventos constantes, solos arenosos e a influência da salinidade. Entre as plantas encontradas nesse ambiente está a Aroeira-da-Praia, uma árvore que pode crescer em restingas e outras formações vegetais próximas ao mar.

Os coqueirais também fazem parte da paisagem de muitas praias brasileiras. Embora o coqueiro tenha origem asiática, seu cultivo se tornou muito comum no litoral do Brasil. Seus frutos fornecem a Água de Coco, bastante apreciada em dias quentes.

O mar, por sua vez, oferece diferentes espécies de peixes. Entre elas estão as Sardinhas, peixes que formam cardumes e fazem parte da atividade pesqueira de diversas comunidades costeiras. O Mel também pode ser encontrado nessa região, produzido por abelhas que visitam as flores da vegetação local.

Os itens encontrados nesta região são:

1. Mel — andares pares. Alimento produzido pelas abelhas a partir do néctar das flores.
2. Água de Coco — andares ímpares. Líquido encontrado no interior do fruto do coqueiro.
3. Sardinha — andares ímpares. Peixe marinho encontrado em cardumes.
4. Aroeira-da-Praia — andares pares. Árvore nativa que também ocorre em ambientes de restinga.

O litoral é uma região de grande diversidade, onde a vegetação, os animais e o oceano estão constantemente relacionados. Mesmo em uma faixa relativamente estreita de terra, existem inúmeros ambientes e recursos para descobrir.""",
		"image": "",
		"category": "region"
	},

	{
		"title": "Mata Atlântica",
		"subtitle": "Região",
		"content": """A Mata Atlântica é uma região de florestas densas, vegetação abundante e grande diversidade de espécies. Suas árvores podem alcançar alturas impressionantes, formando diferentes camadas de vegetação que dificultam a passagem da luz até o solo. A umidade favorece o crescimento de trepadeiras, arbustos, samambaias e outras plantas.

Apesar de sua riqueza natural, grande parte da Mata Atlântica foi transformada ao longo dos séculos pela expansão das cidades e das atividades humanas. Atualmente, seus remanescentes são extremamente importantes para a conservação da biodiversidade brasileira.

Entre suas descobertas está a Erva Baleeira, um arbusto aromático bastante associado às áreas litorâneas e à vegetação da Mata Atlântica. Também encontramos o Guaco, uma planta trepadeira cujas folhas são bastante conhecidas na tradição popular brasileira.

A Espinheira Santa é outra espécie de interesse, encontrada especialmente em formações florestais do Sul e em áreas próximas a cursos de água. Já a Goiabeira pode aparecer em clareiras, pomares e áreas próximas às comunidades. O Maracujazeiro, uma planta trepadeira nativa do Brasil, também está representado nesta região por suas flores características.

Os itens encontrados nesta região são:

1. Folha de Goiabeira — andares pares. Folha de uma árvore frutífera que produz goiabas.
2. Flor de Maracujá — andares ímpares. Flor de uma planta trepadeira do gênero Passiflora.
3. Folha de Guaco — andares pares. Folha de uma planta trepadeira conhecida popularmente como guaco.
4. Erva Baleeira — andares ímpares. Folha de um arbusto aromático encontrado especialmente em áreas litorâneas.
5. Espinheira Santa — andares ímpares. Folha de um arbusto encontrado principalmente em formações florestais do Sul do Brasil.

A Mata Atlântica é uma região que exige atenção aos detalhes. Muitas espécies vivem escondidas entre a vegetação, e mesmo uma pequena trilha pode revelar plantas e animais que não seriam encontrados em nenhum outro lugar da exploração.""",
		"image": "",
		"category": "region"
	},




# =================================================
# CONDIÇÕES
# =================================================

{
	"title": "Anemia Ferropriva",
	"subtitle": "Condição",
	"content": """Descrição:
A anemia ferropriva é uma condição causada pela deficiência de ferro no organismo. Esse mineral é essencial para a produção de hemoglobina, proteína presente nas hemácias responsável pelo transporte de oxigênio pelo corpo. Quando há pouco ferro disponível, o organismo passa a produzir menos hemoglobina, podendo provocar cansaço frequente, fraqueza, palidez, tontura e dificuldade de concentração.

Ingredientes associados:
1. Fígado Bovino — Campos e Rios. É uma fonte de ferro heme, uma forma de ferro encontrada em alimentos de origem animal e absorvida com maior facilidade pelo organismo. Sua ingestão contribui para a produção de hemoglobina.
2. Castanha de Caju — Caatinga. Contém ferro não heme, de origem vegetal, que complementa a ingestão desse mineral. Embora seja absorvido com menor facilidade, pode contribuir para uma alimentação rica em ferro.
3. Camu-Camu — Amazônia ou Acerola — Caatinga. Ambos os frutos são ricos em vitamina C. Essa vitamina favorece a absorção do ferro não heme presente em alimentos vegetais, tornando-a uma boa companheira para ingredientes ricos em ferro.

A alimentação rica em ferro é importante para prevenir deficiências nutricionais. Entretanto, casos de anemia ferropriva podem exigir suplementação e acompanhamento médico.""",
	"image": "",
	"category": "condition"
},

{
	"title": "Diarreia",
	"subtitle": "Condição",
	"content": """Descrição:
A diarreia é caracterizada pelo aumento da frequência das evacuações e pela eliminação de fezes amolecidas ou líquidas. Pode ser provocada por infecções, alimentos contaminados, intolerâncias alimentares ou outras alterações do sistema digestivo. Um dos principais riscos é a perda excessiva de água e sais minerais, que pode levar à desidratação. Entre os sintomas mais comuns estão cólicas, dores abdominais, náuseas e fraqueza.

Ingredientes associados:
1. Água de Coco — Litoral. Rica em água e potássio, contribui para a ingestão de líquidos e a reposição de parte dos minerais perdidos durante episódios de diarreia. Entretanto, não possui a proporção adequada de sais para substituir o soro de reidratação oral.
2. Folha de Goiabeira — Mata Atlântica. É utilizada tradicionalmente para desconfortos intestinais. Seus taninos e outros compostos vegetais apresentam propriedades adstringentes e podem influenciar a movimentação intestinal, embora ainda sejam necessários mais estudos clínicos para confirmar sua eficácia.
3. Banana da Terra — Campos e Rios. É fonte de amido e fibras que ajudam na alimentação durante a recuperação intestinal. Quando consumida ainda pouco madura e cozida, apresenta amido resistente, que pode favorecer a recuperação da consistência das fezes.

A hidratação é fundamental durante episódios de diarreia, pois a perda de líquidos pode ser mais prejudicial do que os próprios sintomas intestinais.""",
	"image": "",
	"category": "condition"
},

{
	"title": "Dor Muscular",
	"subtitle": "Condição",
	"content": """Descrição:
A dor muscular é um desconforto que pode afetar diferentes partes do corpo, geralmente associado a esforço físico excessivo, tensão, inflamações ou pequenas lesões nas fibras musculares. Pode provocar sensibilidade, rigidez, dificuldade de movimentação e dor ao realizar determinados movimentos. Dependendo de sua origem, o desconforto pode ser temporário ou persistente.

Ingredientes associados:
1. Erva Baleeira — Mata Atlântica. Conhecida por seus compostos com propriedades anti-inflamatórias, é tradicionalmente utilizada para aliviar dores musculares, contusões e desconfortos nas articulações. Seu uso tópico possui respaldo em estudos sobre preparações medicinais da planta.
2. Unha de Gato — Amazônia. Possui compostos vegetais associados a atividades anti-inflamatórias e é utilizada tradicionalmente para dores e inflamações. Sua relação com o alívio muscular está principalmente ligada a esse potencial, embora as evidências clínicas ainda sejam limitadas.
3. Arnica Brasileira — Cerrado. É uma planta tradicionalmente associada ao tratamento externo de contusões, dores localizadas e inchaços. Seus compostos apresentam potencial anti-inflamatório, sendo especialmente relacionada ao alívio de desconfortos provocados por pancadas e esforços físicos.

Esses ingredientes são conhecidos principalmente por suas propriedades anti-inflamatórias, que podem contribuir para o alívio de dores e desconfortos musculares.""",
	"image": "",
	"category": "condition"
},

{
	"title": "Escorbuto",
	"subtitle": "Condição",
	"content": """Descrição:
O escorbuto é uma doença causada pela deficiência prolongada de vitamina C no organismo. Essa vitamina é essencial para a produção de colágeno, uma proteína importante para a estrutura da pele, dos vasos sanguíneos, das gengivas e de outros tecidos. Sua deficiência prejudica a cicatrização e a resistência desses tecidos, provocando sintomas como cansaço, sangramento nas gengivas, dores musculares, manchas na pele e dificuldade de cicatrização.

Ingredientes associados:
1. Camu-Camu — Amazônia. É um fruto amazônico conhecido por sua elevada concentração de vitamina C. Essa vitamina é indispensável para a produção de colágeno e para a manutenção dos tecidos, sendo especialmente importante na prevenção e recuperação do escorbuto.
2. Acerola — Caatinga. É uma excelente fonte natural de vitamina C. Seu consumo contribui para a reposição desse nutriente e auxilia o organismo na produção de colágeno, ajudando a manter a integridade das gengivas, da pele e dos vasos sanguíneos.
3. Aroeira-da-praia — Litoral. Possui compostos vegetais associados a atividades antioxidantes e anti-inflamatórias, além de ser tradicionalmente utilizada em preparações relacionadas à cicatrização. Sua relação com o escorbuto é indireta: não é uma fonte comprovada de vitamina C e não substitui a reposição desse nutriente.

A ingestão adequada de vitamina C é essencial para prevenir o escorbuto. Frutos frescos são especialmente importantes para manter o organismo abastecido desse nutriente.""",
	"image": "",
	"category": "condition"
},

{
	"title": "Gastrite",
	"subtitle": "Condição",
	"content": """Descrição:
A gastrite é uma inflamação da mucosa que reveste o interior do estômago. Pode estar relacionada à infecção pela bactéria Helicobacter pylori, ao uso prolongado de determinados medicamentos, ao consumo excessivo de álcool e a outros fatores que prejudicam a proteção da parede gástrica. Entre os sintomas mais comuns estão dor ou queimação na região superior do abdômen, náuseas, sensação de estômago cheio e desconforto após as refeições.

Ingredientes associados:
1. Espinheira Santa — Mata Atlântica. É uma planta bastante conhecida na medicina tradicional brasileira por seu uso contra desconfortos digestivos. Seus taninos e flavonoides são estudados por possíveis propriedades gastroprotetoras, que podem ajudar a proteger a mucosa do estômago.
2. Erva Cidreira — Campos e Rios. Tradicionalmente utilizada em preparações digestivas, possui propriedades calmantes e pode contribuir para aliviar desconfortos abdominais leves e espasmos digestivos. Sua associação com a gastrite está principalmente relacionada ao alívio dos sintomas.
3. Aroeira-da-praia — Litoral. É tradicionalmente utilizada em diferentes regiões do Brasil para problemas inflamatórios e gastrointestinais, incluindo gastrite. Seus compostos apresentam potencial anti-inflamatório e gastroprotetor em estudos experimentais, embora ainda sejam necessárias mais pesquisas clínicas.

Essas plantas fazem parte da tradição medicinal brasileira e são estudadas por seus possíveis efeitos sobre o sistema digestivo e a proteção da mucosa gástrica.""",
	"image": "",
	"category": "condition"
},

{
	"title": "Insônia",
	"subtitle": "Condição",
	"content": """Descrição:
A insônia é uma alteração do sono caracterizada pela dificuldade para adormecer, permanecer dormindo ou voltar a dormir após acordar durante a noite. Pode provocar cansaço ao longo do dia, irritabilidade, dificuldade de concentração e alterações no humor. Entre os fatores associados estão o estresse, a ansiedade, hábitos inadequados de sono e algumas condições de saúde.

Ingredientes associados:
1. Flor de Maracujá — Mata Atlântica. Espécies do gênero Passiflora são tradicionalmente utilizadas por suas propriedades calmantes e sedativas. Alguns estudos sugerem que determinadas preparações podem contribuir para melhorar o tempo total de sono, embora os resultados ainda não sejam conclusivos.
2. Erva Cidreira — Campos e Rios. É tradicionalmente utilizada em chás e preparações calmantes. Seu uso está associado ao relaxamento e à redução da agitação, podendo favorecer um ambiente mais propício ao sono.
3. Mulungu — Cerrado. É uma planta conhecida na medicina popular brasileira por suas propriedades tradicionalmente sedativas e calmantes. Seus compostos são estudados por possíveis efeitos sobre o sistema nervoso, mas ainda faltam pesquisas clínicas que comprovem sua eficácia no tratamento da insônia.

Esses ingredientes são associados principalmente a propriedades calmantes e relaxantes. Entretanto, seus efeitos sobre o sono variam e ainda precisam de maior comprovação científica.""",
	"image": "",
	"category": "condition"
},

{
	"title": "Ossos Fracos",
	"subtitle": "Condição",
	"content": """Descrição:
A fragilidade óssea está relacionada à redução da resistência dos ossos, que podem se tornar mais suscetíveis a fraturas. Esse problema pode estar associado à ingestão insuficiente de cálcio, vitamina D, proteínas e outros nutrientes importantes para a formação e a manutenção do tecido ósseo. Também pode ocorrer com o envelhecimento e em condições como a osteoporose. Entre as consequências estão dores, perda de resistência e maior risco de fraturas.

Ingredientes associados:
1. Sardinha — Litoral. Quando consumida com suas espinhas macias, é uma excelente fonte de cálcio, mineral fundamental para a formação e a manutenção dos ossos. Também fornece proteínas e vitamina D, nutrientes importantes para a saúde óssea.
2. Castanha de Caju — Caatinga. Contém minerais como magnésio e fósforo, que participam da formação e da manutenção do tecido ósseo. Sua ingestão contribui para complementar a alimentação com nutrientes importantes para os ossos.
3. Semente de Chia — Campos e Rios. Possui cálcio, fósforo e magnésio, minerais envolvidos na estrutura e na manutenção dos ossos. Também fornece outros nutrientes que contribuem para uma alimentação equilibrada.

Uma alimentação variada, com quantidades adequadas de cálcio, vitamina D, proteínas e outros minerais, é importante para preservar a resistência dos ossos ao longo da vida.""",
	"image": "",
	"category": "condition"
},

{
	"title": "Queimaduras",
	"subtitle": "Condição",
	"content": """Descrição:
As queimaduras são lesões provocadas pela exposição da pele ou de outros tecidos a fontes de calor, substâncias químicas, eletricidade ou radiação. Sua gravidade varia conforme a profundidade e a extensão da área atingida. Os sintomas podem incluir vermelhidão, dor, inchaço, formação de bolhas e destruição de camadas da pele. Lesões mais profundas podem comprometer a proteção natural do organismo e favorecer infecções.

Ingredientes associados:
1. Pele de Tilápia — Campos e Rios. É rica em colágeno e possui características que permitem sua utilização como cobertura biológica temporária para queimaduras de espessura parcial. Quando devidamente processada e esterilizada em ambiente hospitalar, pode aderir à região lesionada, proteger o tecido e reduzir a dor e a necessidade de trocas de curativos. Seu uso já foi avaliado em estudos clínicos realizados no Brasil.
2. Resina de Copaíba — Amazônia. É conhecida tradicionalmente por suas propriedades anti-inflamatórias e pelo uso em preparações relacionadas à cicatrização. Seus compostos são estudados por possíveis atividades antimicrobianas e cicatrizantes, embora sua eficácia específica no tratamento de queimaduras ainda não esteja bem estabelecida.
3. Mel — Litoral Atlântico. Possui compostos e características que favorecem a atividade antimicrobiana e é utilizado em alguns curativos médicos para auxiliar no cuidado de feridas. O mel medicinal, devidamente preparado e esterilizado, pode contribuir para a manutenção de um ambiente úmido favorável à cicatrização.

Esses ingredientes estão associados à proteção da pele e à recuperação dos tecidos lesionados. A aplicação de substâncias diretamente em queimaduras, entretanto, exige cuidados específicos e não deve ser feita com produtos caseiros.""",
	"image": "",
	"category": "condition"
},

{
	"title": "Resfriado",
	"subtitle": "Condição",
	"content": """Descrição:
O resfriado é uma infecção viral que afeta principalmente o nariz e a garganta. Geralmente provoca coriza, espirros, congestão nasal, dor de garganta, tosse e, em alguns casos, febre baixa e indisposição. Os sintomas costumam desaparecer gradualmente, mas o desconforto pode prejudicar o sono e as atividades cotidianas. A hidratação e o alívio dos sintomas são importantes durante a recuperação.

Ingredientes associados:
1. Folha de Guaco — Mata Atlântica. É tradicionalmente utilizada em preparações para problemas respiratórios, principalmente tosses com secreção. Seus compostos, como a cumarina, estão associados a efeitos expectorantes e ao relaxamento da musculatura dos brônquios, podendo facilitar a eliminação do muco.
2. Mel — Litoral Atlântico. É conhecido por suas propriedades suavizantes e pode aliviar a irritação da garganta. Estudos também apontam benefícios no alívio da tosse associada a infecções respiratórias, contribuindo para um sono mais confortável durante o resfriado.
3. Flor de Assa-Peixe — Cerrado. É utilizada tradicionalmente em preparações populares para desconfortos respiratórios e tosses. Seu uso está associado a possíveis propriedades expectorantes, embora ainda existam poucas evidências clínicas sobre sua eficácia.
4. Alecrim-Pimenta — Caatinga. Possui compostos presentes em seu óleo essencial que apresentam atividades antimicrobianas e anti-inflamatórias em estudos laboratoriais. É uma planta de interesse na medicina tradicional nordestina, embora ainda não existam evidências suficientes para afirmar que combata diretamente os vírus responsáveis pelo resfriado.

Esses ingredientes são associados principalmente ao alívio da tosse, da irritação respiratória e de outros desconfortos que acompanham o resfriado. Eles não eliminam diretamente os vírus responsáveis pela infecção.""",
	"image": "",
	"category": "condition"
},

{
	"title": "Xeroftalmia",
	"subtitle": "Condição",
	"content": """Descrição:
A xeroftalmia é um conjunto de alterações oculares provocadas pela deficiência de vitamina A no organismo. Essa vitamina é essencial para o funcionamento da retina e para a manutenção da superfície dos olhos. Em estágios iniciais, sua deficiência pode provocar dificuldade para enxergar em ambientes com pouca iluminação, conhecida como cegueira noturna. Em casos mais avançados, pode causar ressecamento da conjuntiva e da córnea, lesões e até perda permanente da visão.

Ingredientes associados:
1. Buriti — Amazônia. Sua polpa é rica em betacaroteno, um pigmento vegetal que o organismo pode converter em vitamina A. Esse nutriente é fundamental para a visão, especialmente para o funcionamento da retina em ambientes com pouca luminosidade.
2. Pequi — Cerrado. É um fruto que contém carotenoides, incluindo betacaroteno e betacriptoxantina, substâncias que podem ser convertidas em vitamina A pelo organismo. Seu consumo contribui para a ingestão desse nutriente importante para a saúde ocular.
3. Fígado Bovino — Campos e Rios. É uma das fontes alimentares mais concentradas de vitamina A na forma de retinol, que pode ser utilizada diretamente pelo organismo. Sua ingestão fornece o nutriente necessário para manter o funcionamento adequado da retina e dos tecidos oculares.
4. Licuri — Caatinga. A polpa de seu fruto contém betacaroteno e outros carotenoides que podem ser convertidos em vitamina A. Dessa forma, contribui para a ingestão de nutrientes importantes para a manutenção da visão e da superfície ocular.

A vitamina A é indispensável para a saúde dos olhos. Frutos ricos em carotenoides e alimentos de origem animal que fornecem retinol são importantes fontes desse nutriente.""",
	"image": "",
	"category": "condition"
},




# =================================================
# ITENS E INGREDIENTES
# =================================================

{
	"title": "Buriti",
	"subtitle": "Item",
	"content": """Descrição:
O buriti é um fruto típico de regiões amazônicas, produzido por uma das maiores palmeiras brasileiras, a Mauritia flexuosa. Sua árvore cresce principalmente em áreas úmidas, como margens de rios, terrenos alagados e veredas. O fruto possui uma casca avermelhada e uma polpa de coloração alaranjada, bastante rica em nutrientes. Seu óleo também é aproveitado na produção de alimentos e cosméticos.

Onde encontrar:
Amazônia.

Propriedades:
- Vitamina A: Sua polpa é extremamente rica em betacaroteno, um pigmento vegetal que o organismo consegue transformar em vitamina A. Esse nutriente é essencial para o funcionamento da retina e para a manutenção da superfície dos olhos.
- Vitamina E: Também contém vitamina E, um antioxidante que auxilia na proteção das células contra danos causados pelos radicais livres.
- Gorduras saudáveis: Possui óleos naturais, especialmente ricos em ácido oleico, que contribuem para o valor energético do fruto.

Curiosidade:
A coloração alaranjada do buriti é um indicativo da presença de carotenoides. É considerado um dos frutos brasileiros mais ricos em betacaroteno, sendo especialmente interessante para a manutenção da saúde ocular.""",
	"image": "res://assets/plants/buriti.png",
	"category": "item"
},

{
	"title": "Camu-Camu",
	"subtitle": "Item",
	"content": """Descrição:
O camu-camu é um pequeno fruto amazônico produzido por um arbusto que cresce principalmente nas margens de rios e lagos. Sua casca apresenta coloração avermelhada ou arroxeada quando maduro, enquanto sua polpa possui sabor bastante ácido. A planta é adaptada a ambientes alagáveis e pode permanecer parcialmente submersa durante os períodos de cheia dos rios.

Onde encontrar:
Amazônia.

Propriedades:
- Vitamina C: É uma das maiores fontes naturais de vitamina C conhecidas. Esse nutriente é essencial para a produção de colágeno, proteína que mantém a estrutura da pele, das gengivas, dos vasos sanguíneos e de outros tecidos.
- Absorção de ferro: A vitamina C também aumenta a absorção do ferro não heme, encontrado principalmente em alimentos vegetais, como castanhas e sementes.
- Ação antioxidante: Contém compostos fenólicos e carotenoides que auxiliam na proteção das células contra o estresse oxidativo.

Curiosidade:
Apesar de seu tamanho reduzido, o camu-camu pode apresentar concentrações de vitamina C muito superiores às de frutas bastante conhecidas, como laranja e limão. Por isso, é um ingrediente especialmente interessante para prevenir deficiências desse nutriente.""",
	"image": "",
	"category": "item"
},

{
	"title": "Resina de Copaíba",
	"subtitle": "Item",
	"content": """Descrição:
A resina de copaíba é um óleo-resina extraído do tronco de árvores conhecidas como copaibeiras, encontradas principalmente na Floresta Amazônica. Possui aparência líquida e coloração que varia entre amarelo-claro, dourado e castanho. É um recurso natural utilizado há muito tempo por diferentes comunidades amazônicas, tanto em preparações tradicionais quanto na produção de cosméticos.

Onde encontrar:
Amazônia.

Propriedades:
- Ação anti-inflamatória: Possui compostos como o beta-cariofileno, um sesquiterpeno estudado por suas propriedades anti-inflamatórias.
- Ação antimicrobiana: Alguns componentes da resina apresentam atividade contra determinados microrganismos em estudos laboratoriais.
- Cicatrização: Seu uso tradicional está associado ao cuidado de feridas e à recuperação dos tecidos. Pesquisas investigam seu possível papel na cicatrização, embora os resultados ainda não comprovem todos esses usos.

Curiosidade:
As copaibeiras possuem um sistema natural de produção de óleo-resina em seus troncos. A extração pode ser realizada por meio de perfurações controladas, permitindo a coleta sem precisar derrubar a árvore. A composição da resina varia conforme a espécie de copaibeira.""",
	"image": "",
	"category": "item"
},

{
	"title": "Unha de Gato",
	"subtitle": "Item",
	"content": """Descrição:
A unha de gato é uma planta trepadeira encontrada em florestas tropicais da América do Sul, especialmente na Amazônia. Seu nome popular vem dos pequenos espinhos curvados presentes nos caules, que lembram as garras de um felino e ajudam a planta a se prender à vegetação ao redor. É uma espécie que utiliza outras árvores como apoio para alcançar regiões mais iluminadas da floresta.

Onde encontrar:
Amazônia.

Propriedades:
- Ação anti-inflamatória: Possui alcaloides oxindólicos e outros compostos vegetais estudados por sua influência sobre processos inflamatórios.
- Sistema imunológico: Alguns de seus componentes são investigados por possíveis efeitos imunomoduladores, ou seja, pela capacidade de influenciar a atividade do sistema imunológico.
- Dores articulares: Na medicina tradicional, é utilizada em preparações associadas ao alívio de dores e inflamações, especialmente nas articulações.

Curiosidade:
A unha de gato possui diferentes espécies, sendo Uncaria tomentosa e Uncaria guianensis algumas das mais conhecidas. Na medicina tradicional, suas cascas são especialmente aproveitadas. Apesar de seu potencial medicinal, os estudos clínicos ainda são limitados e seu uso pode apresentar contraindicações.""",
	"image": "",
	"category": "item"
},

{
	"title": "Acerola",
	"subtitle": "Item",
	"content": """Descrição:
A acerola é um pequeno fruto arredondado, geralmente avermelhado quando maduro, produzido por um arbusto cultivado em diversas regiões tropicais. Possui sabor caracteristicamente ácido e polpa suculenta. No Brasil, seu cultivo é bastante difundido, especialmente no Nordeste, onde as condições de clima e temperatura favorecem sua produção.

Onde encontrar:
Caatinga.

Propriedades:
- Vitamina C: É uma das frutas mais conhecidas por sua elevada concentração de vitamina C. Esse nutriente participa da formação do colágeno, auxilia no funcionamento do sistema imunológico e contribui para a proteção das células.
- Absorção de ferro: Quando consumida junto a alimentos ricos em ferro não heme, como a castanha de caju, sua vitamina C aumenta a absorção desse mineral.
- Ação antioxidante: Também contém carotenoides e compostos fenólicos que ajudam a combater o estresse oxidativo.

Curiosidade:
A acerola possui uma concentração de vitamina C muito superior à da laranja. Por isso, pequenas quantidades da fruta já podem contribuir significativamente para a ingestão diária desse nutriente.""",
	"image": "",
	"category": "item"
},

{
	"title": "Alecrim-Pimenta",
	"subtitle": "Item",
	"content": """Descrição:
O alecrim-pimenta é um arbusto aromático nativo do Nordeste brasileiro, especialmente adaptado às condições quentes e relativamente secas do semiárido. Suas folhas possuem aroma intenso e são utilizadas tradicionalmente em preparações medicinais. Apesar do nome, não pertence ao mesmo gênero do alecrim convencional utilizado na culinária.

Onde encontrar:
Caatinga.

Propriedades:
- Ação antimicrobiana: Suas folhas possuem um óleo essencial rico em substâncias como timol e carvacrol, conhecidas por apresentar atividade contra diferentes bactérias e fungos em estudos laboratoriais.
- Ação anti-inflamatória: Seus compostos aromáticos também são investigados por possíveis efeitos anti-inflamatórios.
- Higiene bucal: Preparações tradicionais da planta são utilizadas para auxiliar na higiene da boca e no cuidado de desconfortos na garganta.

Curiosidade:
O alecrim-pimenta é uma das plantas medicinais de interesse para o desenvolvimento de produtos fitoterápicos no Nordeste. Seu óleo essencial possui um aroma bastante forte e característico. O óleo concentrado pode irritar a pele e as mucosas quando utilizado inadequadamente.""",
	"image": "",
	"category": "item"
},

{
	"title": "Castanha de Caju",
	"subtitle": "Item",
	"content": """Descrição:
A castanha de caju é a semente comestível produzida pelo cajueiro, uma árvore bastante conhecida no Nordeste brasileiro. Ela fica presa à parte inferior do caju, fruto de coloração amarela, vermelha ou alaranjada. Depois de colhida e processada para a remoção da casca externa, a semente pode ser consumida torrada ou utilizada em diversas preparações alimentícias.

Onde encontrar:
Caatinga.

Propriedades:
- Ferro: Contém ferro não heme, uma forma de ferro encontrada em alimentos de origem vegetal. Esse mineral é importante para a produção de hemoglobina e o transporte de oxigênio pelo organismo.
- Magnésio e fósforo: Possui quantidades importantes desses minerais, que participam da formação e da manutenção dos ossos.
- Proteínas: Também fornece proteínas vegetais, necessárias para a construção e recuperação dos tecidos.
- Gorduras saudáveis: É rica em gorduras insaturadas, que fazem parte de uma alimentação equilibrada.

Curiosidade:
O ferro presente na castanha de caju é do tipo não heme, cuja absorção pelo organismo é menor do que a do ferro encontrado em carnes. Entretanto, consumir alimentos ricos em vitamina C, como acerola e camu-camu, na mesma refeição aumenta significativamente sua absorção. Essa combinação é especialmente interessante para pessoas com deficiência de ferro.""",
	"image": "",
	"category": "item"
},

{
	"title": "Licuri",
	"subtitle": "Item",
	"content": """Descrição:
O licuri é o fruto de uma palmeira nativa do Nordeste brasileiro, especialmente adaptada às condições da Caatinga. Seus frutos são pequenos, geralmente arredondados e de coloração amarelada. Possuem uma polpa externa e uma amêndoa interna bastante aproveitada na alimentação das comunidades locais. A palmeira é resistente ao clima seco e desempenha um papel importante na economia de diversas regiões do semiárido.

Onde encontrar:
Caatinga.

Propriedades:
- Betacaroteno: Sua polpa possui carotenoides, principalmente betacaroteno, que o organismo consegue transformar em vitamina A. Esse nutriente é essencial para o funcionamento da retina e a manutenção dos tecidos oculares.
- Vitamina E: Contém compostos da família da vitamina E, que apresentam ação antioxidante e auxiliam na proteção das células.
- Minerais: Sua amêndoa fornece minerais como magnésio e fósforo, importantes para diversas funções do organismo.
- Valor energético: Possui gorduras naturais que fornecem energia e contribuem para a composição nutricional do alimento.

Curiosidade:
A polpa do licuri apresenta uma concentração expressiva de betacaroteno. Além de seu aproveitamento alimentar, seus frutos são uma importante fonte de alimento para animais da Caatinga, especialmente algumas espécies de aves e araras.""",
	"image": "",
	"category": "item"
},

{
	"title": "Banana da Terra",
	"subtitle": "Item",
	"content": """Descrição:
A banana-da-terra é uma variedade de banana de frutos grandes, alongados e geralmente mais firmes do que os de outras variedades. É muito utilizada na culinária brasileira, principalmente em preparações cozidas, assadas ou fritas. Diferentemente de outras bananas consumidas principalmente cruas, a banana-da-terra costuma ser preparada antes do consumo.

Onde encontrar:
Campos e Rios.

Propriedades:
- Potássio: É uma fonte desse mineral, que participa do funcionamento dos músculos, dos nervos e do equilíbrio de líquidos no organismo.
- Fibras: Contém fibras alimentares que auxiliam o funcionamento do sistema digestivo.
- Amido resistente: Quando ainda está verde, apresenta uma quantidade maior de amido resistente, que não é completamente digerido no intestino delgado. Esse composto pode ser utilizado pelas bactérias benéficas do intestino e contribuir para a saúde da microbiota intestinal.
- Energia: Seu conteúdo de carboidratos fornece energia para as atividades do organismo.

Curiosidade:
À medida que a banana amadurece, parte de seu amido é transformada em açúcares, deixando o fruto mais doce e macio. A banana verde e a banana madura, portanto, apresentam características nutricionais diferentes.""",
	"image": "",
	"category": "item"
},

{
	"title": "Erva Cidreira",
	"subtitle": "Item",
	"content": """Descrição:
A erva-cidreira é o nome popular de diferentes plantas aromáticas conhecidas pelo cheiro agradável de suas folhas. No Brasil, é muito cultivada em quintais, hortas e pequenas propriedades rurais. Suas folhas podem apresentar diferentes formatos dependendo da espécie, mas geralmente possuem aroma semelhante ao limão e são utilizadas tradicionalmente na preparação de chás.

Onde encontrar:
Campos e Rios.

Propriedades:
- Efeito calmante: Algumas espécies conhecidas como erva-cidreira possuem compostos associados ao relaxamento e à redução de estados leves de agitação e ansiedade.
- Conforto digestivo: Suas preparações tradicionais são utilizadas para aliviar desconfortos estomacais leves, gases e cólicas intestinais.
- Ação antiespasmódica: Alguns compostos presentes nas folhas podem auxiliar no relaxamento da musculatura lisa do sistema digestivo.
- Aroma natural: Seus óleos essenciais são responsáveis pelo cheiro característico e também são aproveitados na produção de produtos aromáticos.

Curiosidade:
O nome erva-cidreira pode se referir a espécies diferentes, como Lippia alba e Melissa officinalis. Embora compartilhem algumas características aromáticas e usos tradicionais, suas composições químicas e propriedades não são exatamente iguais. No Brasil, a Lippia alba também é conhecida como erva-cidreira-brasileira.""",
	"image": "",
	"category": "item"
},

{
	"title": "Fígado Bovino",
	"subtitle": "Item",
	"content": """Descrição:
O fígado bovino é um órgão obtido de animais criados na pecuária. Sua principal função no organismo do animal é participar do metabolismo de nutrientes, armazenar determinadas vitaminas e auxiliar na filtragem e transformação de substâncias presentes no sangue. É um alimento bastante nutritivo e conhecido por sua elevada concentração de vitaminas e minerais.

Onde encontrar:
Campos e Rios.

Propriedades:
- Ferro heme: É uma excelente fonte de ferro de origem animal, cuja absorção pelo organismo costuma ser mais eficiente do que a do ferro não heme presente nos vegetais. Esse mineral é fundamental para a produção de hemoglobina.
- Vitamina A: Apresenta uma concentração muito elevada de retinol, uma forma de vitamina A que o organismo consegue utilizar diretamente. Esse nutriente é essencial para a visão e a manutenção dos tecidos oculares.
- Vitamina B12: É uma das melhores fontes alimentares dessa vitamina, necessária para a formação das células sanguíneas e o funcionamento do sistema nervoso.
- Proteínas: Fornece proteínas de alto valor biológico, importantes para a construção e recuperação dos tecidos.

Curiosidade:
O fígado bovino possui uma concentração especialmente elevada de ferro e vitamina A. Por isso, é associado tanto à prevenção de deficiências de ferro quanto à manutenção da saúde ocular. Entretanto, justamente por conter muita vitamina A, seu consumo excessivo não é recomendado.""",
	"image": "",
	"category": "item"
},

{
	"title": "Pele de Tilápia",
	"subtitle": "Item",
	"content": """Descrição:
A pele de tilápia é obtida de um peixe de água doce muito utilizado na piscicultura brasileira. A tilápia possui escamas relativamente pequenas e uma pele resistente, características que contribuem para seu aproveitamento em diferentes atividades. Além de sua utilização na alimentação e no processamento de pescados, a pele também despertou interesse na área da medicina regenerativa.

Onde encontrar:
Campos e Rios.

Propriedades:
- Colágeno: Sua estrutura é rica em colágeno, especialmente do tipo I, uma proteína que também faz parte da composição da pele humana e participa da sustentação dos tecidos.
- Curativos biológicos: Quando passa por processos específicos de limpeza, esterilização e preparação, pode ser utilizada como cobertura biológica temporária para determinados tipos de queimaduras.
- Proteção dos tecidos: Como curativo preparado, pode aderir à região lesionada, ajudar a manter um ambiente úmido favorável à cicatrização e proteger a área exposta.
- Redução da dor: Estudos clínicos brasileiros observaram benefícios relacionados ao conforto dos pacientes e à redução da frequência de trocas de curativos.

Curiosidade:
Pesquisadores brasileiros, especialmente no Ceará, desenvolveram estudos importantes sobre a utilização da pele de tilápia no tratamento de queimaduras. O material precisa passar por processamento especializado antes de ser utilizado como curativo, não sendo seguro aplicar pele de peixe recém-retirada diretamente sobre uma lesão.""",
	"image": "",
	"category": "item"
},

{
	"title": "Semente de Chia",
	"subtitle": "Item",
	"content": """Descrição:
A chia é uma pequena semente originária da América Central, produzida por uma planta herbácea conhecida como Salvia hispanica. Seus grãos são geralmente pretos, cinzentos ou esbranquiçados e possuem tamanho reduzido. Quando entram em contato com a água, desenvolvem uma camada gelatinosa ao redor da semente, característica que permite sua utilização em diversas preparações alimentícias.

Onde encontrar:
Campos e Rios.

Propriedades:
- Cálcio: Possui uma quantidade significativa desse mineral, necessário para a formação e manutenção dos ossos e dentes.
- Magnésio e fósforo: Esses minerais participam da estrutura óssea e de diversos processos metabólicos do organismo.
- Fibras alimentares: É particularmente rica em fibras, que auxiliam o funcionamento intestinal e contribuem para a sensação de saciedade.
- Ômega-3: Contém ácido alfa-linolênico (ALA), um tipo de gordura poli-insaturada importante para uma alimentação equilibrada.
- Proteínas: Também fornece proteínas vegetais, que participam da manutenção dos tecidos.

Curiosidade:
A camada gelatinosa que se forma ao redor da chia quando ela é hidratada é resultado da absorção de água pelas fibras da semente. Essa característica é bastante aproveitada na culinária, especialmente no preparo de pudins, bebidas e alimentos que precisam de consistência mais espessa.""",
	"image": "",
	"category": "item"
},

{
	"title": "Arnica Brasileira",
	"subtitle": "Item",
	"content": """Descrição:
A arnica brasileira, também conhecida em algumas regiões como arnica-do-cerrado, é uma planta encontrada principalmente em campos rupestres, terrenos pedregosos e áreas de altitude. Possui caule ereto, folhas características e pequenas flores amarelas. Apesar de compartilhar o nome com a arnica europeia, pertence a uma espécie diferente, conhecida cientificamente como Solidago chilensis.

Onde encontrar:
Cerrado.

Propriedades:
- Ação anti-inflamatória: Possui compostos vegetais estudados por sua capacidade de reduzir processos inflamatórios.
- Alívio de dores: É tradicionalmente utilizada em preparações de uso externo para aliviar desconfortos musculares, contusões e dores localizadas.
- Hematomas: Também é associada ao cuidado de regiões afetadas por pancadas e pequenos traumas.
- Cicatrização: Alguns de seus componentes são estudados por possíveis atividades relacionadas à recuperação de tecidos.

Curiosidade:
Apesar de ser conhecida como arnica, a espécie brasileira não é a mesma utilizada tradicionalmente na Europa. Seu uso popular é principalmente externo, pois a ingestão de preparações da planta pode oferecer riscos à saúde. Na medicina tradicional, é especialmente associada a contusões e dores musculares.""",
	"image": "",
	"category": "item"
},

{
	"title": "Flor de Assa-Peixe",
	"subtitle": "Item",
	"content": """Descrição:
O assa-peixe é uma planta arbustiva encontrada em terrenos abertos, pastagens e áreas ensolaradas. Suas flores são pequenas e costumam se agrupar em inflorescências de coloração branca ou levemente arroxeada. A planta é bastante conhecida no interior do Brasil e recebe a visita frequente de abelhas e outros insetos polinizadores.

Onde encontrar:
Cerrado.

Propriedades:
- Uso respiratório tradicional: Suas flores e outras partes da planta são utilizadas popularmente em preparações voltadas ao alívio de desconfortos respiratórios.
- Tosse: Na medicina popular, é associada ao alívio da tosse e à eliminação de secreções respiratórias.
- Compostos vegetais: Apresenta substâncias naturais que são estudadas por possíveis atividades anti-inflamatórias e antioxidantes, embora ainda sejam necessárias mais pesquisas para confirmar seus efeitos em seres humanos.

Curiosidade:
O assa-peixe é considerado uma planta importante para a alimentação de abelhas. Sua presença em terrenos abertos favorece a atividade de polinizadores, contribuindo para a manutenção da biodiversidade do Cerrado.""",
	"image": "",
	"category": "item"
},

{
	"title": "Mulungu",
	"subtitle": "Item",
	"content": """Descrição:
O mulungu é uma árvore brasileira conhecida por suas flores de coloração vermelha ou alaranjada, bastante vistosas. Algumas espécies do gênero Erythrina recebem esse nome popular e são encontradas em diferentes regiões do país. Sua estrutura apresenta tronco geralmente irregular, folhas compostas e sementes que se desenvolvem dentro de vagens.

Onde encontrar:
Cerrado.

Propriedades:
- Efeito calmante tradicional: É conhecido na medicina popular por seu uso em preparações associadas ao relaxamento e à redução da agitação.
- Sono: Algumas espécies de mulungu possuem compostos investigados por possíveis efeitos ansiolíticos e sedativos, o que explica sua associação tradicional com dificuldades para dormir.
- Sistema nervoso: Seus alcaloides naturais são estudados por sua influência sobre o sistema nervoso, embora seus efeitos e sua segurança dependam da espécie e da preparação utilizada.

Curiosidade:
O nome mulungu não identifica uma única espécie vegetal. Diferentes árvores do gênero Erythrina recebem essa denominação popular. Algumas possuem alcaloides que podem ser tóxicos em determinadas concentrações, especialmente nas sementes e nas cascas, exigindo muito cuidado com seu uso medicinal.""",
	"image": "",
	"category": "item"
},

{
	"title": "Pequi",
	"subtitle": "Item",
	"content": """Descrição:
O pequi é um fruto bastante característico do Cerrado brasileiro, produzido por uma árvore de copa ampla conhecida como pequizeiro. Possui casca externa verde e polpa interna de coloração amarela intensa, com aroma e sabor bastante marcantes. Seu interior apresenta um caroço com pequenos espinhos, exigindo cuidado durante o consumo. É um ingrediente tradicional da culinária de diversas regiões do Centro-Oeste e do interior do Brasil.

Onde encontrar:
Cerrado.

Propriedades:
- Betacaroteno: Sua polpa amarelada contém carotenoides, incluindo betacaroteno, que pode ser transformado em vitamina A pelo organismo.
- Vitamina A: Os carotenoides contribuem para a ingestão desse nutriente, fundamental para a visão e a manutenção dos tecidos que revestem os olhos.
- Gorduras saudáveis: A polpa contém óleos naturais, incluindo ácidos graxos insaturados, que contribuem para seu valor energético.
- Ação antioxidante: Possui carotenoides e compostos fenólicos que auxiliam na proteção das células contra o estresse oxidativo.

Curiosidade:
A polpa do pequi é muito utilizada na culinária regional, especialmente em pratos com arroz e frango. Seu caroço possui espinhos finos que podem machucar a boca, por isso a polpa deve ser retirada cuidadosamente.""",
	"image": "",
	"category": "item"
},

{
	"title": "Água de Coco",
	"subtitle": "Item",
	"content": """Descrição:
A água de coco é o líquido naturalmente encontrado no interior do fruto do coqueiro, uma palmeira muito cultivada nas regiões tropicais. É transparente, levemente adocicada e possui sabor refrescante. No Brasil, seu consumo é especialmente popular nas regiões litorâneas, onde os coqueirais fazem parte da paisagem de muitas praias.

Onde encontrar:
Litoral Brasileiro.

Propriedades:
- Hidratação: É composta principalmente por água, contribuindo para a reposição de líquidos no organismo.
- Potássio: Apresenta uma quantidade importante desse mineral, necessário para o funcionamento dos músculos, dos nervos e para o equilíbrio de líquidos.
- Eletrólitos: Também fornece pequenas quantidades de outros minerais, como sódio e magnésio, que participam do equilíbrio eletrolítico do organismo.
- Valor energético: Contém açúcares naturais que fornecem energia.

Curiosidade:
A água de coco é frequentemente consumida após atividades físicas e em dias quentes por seu sabor refrescante e conteúdo de minerais. Entretanto, sua composição não possui as proporções adequadas de sais e glicose para substituir o soro de reidratação oral em casos de desidratação provocada por diarreia.""",
	"image": "",
	"category": "item"
},

{
	"title": "Aroeira-da-praia",
	"subtitle": "Item",
	"content": """Descrição:
A aroeira-da-praia é uma árvore nativa brasileira que pode ser encontrada em restingas, áreas costeiras e diferentes formações vegetais próximas ao mar. Também conhecida como aroeira-vermelha, possui folhas compostas, pequenas flores e frutos arredondados de coloração rosada ou avermelhada. É uma espécie resistente e bastante adaptada às condições ambientais do litoral.

Onde encontrar:
Litoral Brasileiro.

Propriedades:
- Ação anti-inflamatória: Possui compostos vegetais, incluindo flavonoides e taninos, estudados por suas propriedades anti-inflamatórias.
- Ação antimicrobiana: Alguns extratos apresentam atividade contra determinados microrganismos em estudos laboratoriais.
- Cicatrização: Seus taninos estão associados a propriedades adstringentes, e preparações específicas da planta são utilizadas tradicionalmente em cuidados com a pele e outros tecidos.
- Ação antioxidante: Seus compostos fenólicos contribuem para a atividade antioxidante observada em diferentes extratos.

Curiosidade:
Os pequenos frutos avermelhados da aroeira são conhecidos como pimenta-rosa e podem ser utilizados como tempero na culinária. A espécie também possui importância ecológica, pois seus frutos são consumidos por diversas aves, que ajudam a dispersar suas sementes.""",
	"image": "",
	"category": "item"
},

{
	"title": "Mel",
	"subtitle": "Item",
	"content": """Descrição:
O mel é um alimento natural produzido pelas abelhas a partir do néctar das flores. As abelhas coletam o néctar, transformam parte de seus açúcares por meio de enzimas e armazenam o produto nas células dos favos, onde ocorre a perda de umidade até atingir sua consistência característica. Sua cor, aroma e sabor variam conforme as espécies de plantas visitadas pelas abelhas.

Onde encontrar:
Litoral Brasileiro.

Propriedades:
- Energia: É composto principalmente por açúcares naturais, como glicose e frutose, que fornecem energia ao organismo.
- Alívio da garganta: Sua consistência espessa pode ajudar a revestir temporariamente a garganta, aliviando a irritação e o desconforto associados à tosse.
- Ação antimicrobiana: Possui características que dificultam o desenvolvimento de alguns microrganismos, incluindo baixa umidade, acidez e determinados compostos bioativos.
- Cicatrização: Algumas apresentações de mel medicinal, devidamente processadas e esterilizadas, são utilizadas em curativos especializados para auxiliar na recuperação de feridas.

Curiosidade:
A composição e o sabor do mel dependem diretamente das flores visitadas pelas abelhas. Por isso, diferentes regiões podem produzir méis com aromas e colorações bastante distintos. O mel não deve ser oferecido a crianças menores de um ano de idade.""",
	"image": "",
	"category": "item"
},

{
	"title": "Sardinha",
	"subtitle": "Item",
	"content": """Descrição:
A sardinha é um peixe marinho de pequeno porte que costuma formar grandes cardumes. Possui corpo alongado e prateado, sendo encontrada em diferentes regiões costeiras do Brasil. É uma espécie bastante importante para a pesca comercial e para a alimentação de muitas comunidades litorâneas.

Onde encontrar:
Litoral Brasileiro.

Propriedades:
- Cálcio: Quando consumida com suas pequenas espinhas, fornece uma quantidade significativa de cálcio, mineral fundamental para a formação e manutenção dos ossos e dentes.
- Vitamina D: Contém vitamina D, que auxilia na absorção e utilização do cálcio pelo organismo.
- Proteínas: É uma boa fonte de proteínas de alto valor biológico, necessárias para a manutenção dos músculos e de outros tecidos.
- Ômega-3: Fornece ácidos graxos EPA e DHA, associados à saúde cardiovascular e ao funcionamento do cérebro.
- Vitamina B12: Também é fonte dessa vitamina, importante para a formação das células sanguíneas e o funcionamento do sistema nervoso.

Curiosidade:
A sardinha é considerada um alimento bastante nutritivo porque combina proteínas, gorduras saudáveis e vitaminas. Quando consumida inteira, incluindo as espinhas macias, torna-se uma fonte especialmente interessante de cálcio.""",
	"image": "",
	"category": "item"
},

{
	"title": "Erva Baleeira",
	"subtitle": "Item",
	"content": """Descrição:
A erva baleeira é um arbusto aromático nativo do Brasil, bastante associado às regiões costeiras e à vegetação da Mata Atlântica. Possui folhas verdes alongadas, aroma característico e pequenas flores claras agrupadas em inflorescências. Seu nome popular está relacionado ao uso tradicional da planta por comunidades litorâneas.

Onde encontrar:
Mata Atlântica.

Propriedades:
- Ação anti-inflamatória: Suas folhas possuem compostos como o alfa-humuleno, estudado por sua atividade anti-inflamatória.
- Alívio de dores musculares: Preparações tópicas desenvolvidas a partir da planta são utilizadas para auxiliar no alívio de dores localizadas associadas a processos inflamatórios.
- Desconfortos articulares: Também é associada ao alívio de dores nas articulações e de desconfortos provocados por inflamações.
- Compostos aromáticos: Seus óleos essenciais possuem substâncias naturais que despertam interesse na pesquisa farmacológica.

Curiosidade:
A erva baleeira ganhou destaque na pesquisa farmacêutica brasileira e deu origem a um medicamento fitoterápico de uso tópico. É especialmente conhecida por sua associação com dores musculares e articulares.""",
	"image": "",
	"category": "item"
},

{
	"title": "Espinheira Santa",
	"subtitle": "Item",
	"content": """Descrição:
A espinheira-santa é um arbusto brasileiro de pequeno ou médio porte, conhecido pelas folhas com pequenas saliências nas bordas que lembram espinhos. É encontrada principalmente em formações florestais do Sul e em áreas próximas a cursos de água. Suas folhas são utilizadas há muito tempo na medicina tradicional brasileira, principalmente em preparações voltadas ao sistema digestivo.

Onde encontrar:
Mata Atlântica.

Propriedades:
- Proteção gástrica: Seus compostos, especialmente taninos e flavonoides, estão associados a efeitos gastroprotetores, podendo auxiliar na proteção da mucosa que reveste o estômago.
- Desconforto digestivo: É tradicionalmente utilizada para aliviar sintomas como sensação de queimação, má digestão e desconforto abdominal.
- Ação antiácida: Preparações padronizadas da planta apresentam propriedades associadas à redução da acidez e ao alívio de sintomas digestivos.
- Compostos antioxidantes: Também contém substâncias vegetais que apresentam atividade antioxidante em estudos experimentais.

Curiosidade:
A espinheira-santa é uma das plantas medicinais brasileiras reconhecidas pela Agência Nacional de Vigilância Sanitária. Preparações específicas de suas folhas possuem indicação tradicional para dispepsia e como auxiliar no tratamento de gastrite e úlcera gastroduodenal.""",
	"image": "",
	"category": "item"
},

{
	"title": "Flor de Maracujá",
	"subtitle": "Item",
	"content": """Descrição:
A flor de maracujá é uma das estruturas mais características das plantas do gênero Passiflora, conhecidas popularmente como maracujazeiros. Apresenta uma aparência bastante particular, com pétalas, sépalas e filamentos coloridos organizados em uma estrutura circular. Algumas espécies são trepadeiras e utilizam gavinhas para se prender à vegetação ao redor.

Onde encontrar:
Mata Atlântica.

Propriedades:
- Efeito calmante: Algumas espécies de Passiflora possuem compostos vegetais associados à redução da ansiedade leve e ao relaxamento.
- Sono: Preparações tradicionais da planta são utilizadas para favorecer o descanso e aliviar estados de agitação que podem dificultar o sono.
- Flavonoides: Contém substâncias dessa família de compostos vegetais, estudadas por suas possíveis atividades antioxidantes e influência sobre o sistema nervoso.

Curiosidade:
Apesar de ser conhecida principalmente pelo fruto, a planta do maracujá também possui importância medicinal. Em preparações fitoterápicas, geralmente são utilizadas as partes aéreas da planta, especialmente folhas e estruturas próximas às flores. Diferentes espécies de Passiflora possuem composições e propriedades distintas.""",
	"image": "",
	"category": "item"
},

{
	"title": "Folha de Goiabeira",
	"subtitle": "Item",
	"content": """Descrição:
A folha de goiabeira é proveniente da goiabeira, uma árvore frutífera bastante comum em pomares, quintais e áreas próximas a comunidades rurais. Suas folhas são verdes, possuem formato ovalado e apresentam nervuras bem marcadas. A árvore também produz a goiaba, um fruto bastante conhecido por seu sabor e por sua riqueza em vitamina C.

Onde encontrar:
Mata Atlântica.

Propriedades:
- Taninos: Suas folhas contêm taninos, compostos vegetais com propriedades adstringentes que podem influenciar a atividade intestinal.
- Conforto digestivo: Preparações tradicionais das folhas são utilizadas popularmente para aliviar episódios de desconforto intestinal e diarreia.
- Ação antimicrobiana: Estudos laboratoriais identificaram atividade de alguns extratos contra determinados microrganismos.
- Ação antioxidante: Também possui flavonoides e outros compostos fenólicos que ajudam a proteger as células contra o estresse oxidativo.

Curiosidade:
A goiabeira possui grande importância alimentar e medicinal. Enquanto seus frutos são conhecidos principalmente pela elevada concentração de vitamina C, suas folhas despertam interesse pela presença de taninos e outros compostos associados à saúde digestiva.""",
	"image": "",
	"category": "item"
},

{
	"title": "Folha de Guaco",
	"subtitle": "Item",
	"content": """Descrição:
O guaco é uma planta trepadeira encontrada em diferentes formações vegetais brasileiras, especialmente nas áreas de Mata Atlântica. Suas folhas são verdes, possuem formato geralmente ovalado ou em coração e apresentam aroma característico quando amassadas. A planta utiliza outras estruturas vegetais como apoio para crescer em direção à luz.

Onde encontrar:
Mata Atlântica.

Propriedades:
- Ação expectorante: É tradicionalmente utilizada para auxiliar na eliminação de secreções acumuladas nas vias respiratórias.
- Alívio da tosse: Suas preparações são associadas ao alívio da tosse, especialmente quando acompanhada de secreções.
- Ação broncodilatadora: Alguns compostos presentes no guaco estão associados ao relaxamento da musculatura dos brônquios, podendo facilitar a passagem do ar.
- Cumarina: Contém essa substância natural, utilizada como um dos marcadores químicos para a padronização de preparações fitoterápicas da planta.

Curiosidade:
O guaco é uma das plantas medicinais brasileiras reconhecidas pelo Ministério da Saúde. Suas folhas são utilizadas na produção de preparações fitoterápicas voltadas ao alívio de sintomas respiratórios. Existem diferentes espécies conhecidas como guaco, especialmente Mikania glomerata e Mikania laevigata.""",
	"image": "",
	"category": "item"
}


]


# =====================================================
# INICIALIZAÇÃO
# =====================================================

func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	_root.hide()

	# Configura a imagem da página.
	_page_image.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_page_image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	_page_image.custom_minimum_size = Vector2(0, 140)
	_page_image.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	# Conecta os botões às suas respectivas funções.
	_previous_button.pressed.connect(_go_to_previous_page)
	_next_button.pressed.connect(_go_to_next_page)
	_close_button.pressed.connect(close)

	# Atualiza a primeira página.
	_update_page()


# =====================================================
# ENTRADAS DO JOGADOR
# =====================================================

func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("journal"):

		if _root.visible:
			close()
		else:
			open()

		get_viewport().set_input_as_handled()

	elif _root.visible and event.is_action_pressed("ui_cancel"):

		close()
		get_viewport().set_input_as_handled()


# =====================================================
# ABRIR E FECHAR O DIÁRIO
# =====================================================

func open() -> void:

	_paused_before_open = get_tree().paused

	_root.show()

	get_tree().paused = true


func close() -> void:

	_root.hide()

	get_tree().paused = _paused_before_open


# =====================================================
# NAVEGAÇÃO ENTRE PÁGINAS
# =====================================================

func _go_to_next_page() -> void:

	if _current_page < _pages.size() - 1:

		_current_page += 1

		_update_page()


func _go_to_previous_page() -> void:

	if _current_page > 0:

		_current_page -= 1

		_update_page()


# =====================================================
# CARREGAMENTO DA IMAGEM
# =====================================================

func _update_page_image(image_path: String) -> void:

	# Primeiro, limpa e esconde a imagem anterior.
	_page_image.texture = null
	_page_image.hide()

	# Se não houver imagem cadastrada, encerramos a função.
	if image_path.is_empty():
		return

	# Verifica se o arquivo realmente existe.
	if not ResourceLoader.exists(image_path):

		push_warning("Imagem não encontrada: " + image_path)

		return

	# Carrega a imagem como uma Texture2D.
	var loaded_texture := load(image_path) as Texture2D

	if loaded_texture == null:

		push_warning("Não foi possível carregar a imagem: " + image_path)

		return

	# Exibe a imagem carregada.
	_page_image.texture = loaded_texture
	_page_image.show()


# =====================================================
# ATUALIZAÇÃO DA PÁGINA
# =====================================================

func _update_page() -> void:

	# Verifica se existem páginas cadastradas.
	if _pages.is_empty():

		_page_title.text = "Diário da Apotecária"
		_page_subtitle.text = ""
		_page_content.text = "Nenhuma página cadastrada."
		_page_counter.text = "Diário vazio"

		_page_image.texture = null
		_page_image.hide()

		_previous_button.disabled = true
		_next_button.disabled = true

		return

	# Recupera os dados da página atual.
	var page: Dictionary = _pages[_current_page]

	# Atualiza o título e o subtítulo.
	_page_title.text = str(page.get("title", "Sem título"))

	_page_subtitle.text = str(page.get("subtitle", ""))

	# Atualiza o conteúdo.
	_page_content.text = str(page.get("content", ""))

	# Atualiza a imagem.
	var image_path: String = str(page.get("image", ""))

	_update_page_image(image_path)

	# Atualiza o contador.
	_page_counter.text = "Página %d / %d" % [
		_current_page + 1,
		_pages.size()
	]

	# Controla os limites da navegação.
	_previous_button.disabled = _current_page == 0

	_next_button.disabled = _current_page >= _pages.size() - 1
