import '../domain/animal.dart';

AnimalsType? selectedAnimalType;

List<AnimalsType> animalTypesList = <AnimalsType>[
  AnimalsType(
    tableName: "Mamíferos",
    bgImage: "https://images.pexels.com/photos/45170/kittens-cat-cat-puppy-rush-45170.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  ),
  AnimalsType(
    tableName: "Aves",
    bgImage: "https://images.pexels.com/photos/973165/pexels-photo-973165.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  ),
  AnimalsType(
    tableName: "Peixes",
    bgImage: "https://images.pexels.com/photos/213399/pexels-photo-213399.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  ),
  AnimalsType(
    tableName: "Répteis",
    bgImage: "https://images.pexels.com/photos/2078809/pexels-photo-2078809.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  ),
  AnimalsType(
    tableName: "Anfíbios",
    bgImage: "https://images.pexels.com/photos/70083/frog-macro-amphibian-green-70083.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  ),
  AnimalsType(
    tableName: "Invertebrados",
    bgImage: "https://images.pexels.com/photos/1557208/pexels-photo-1557208.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  ),
];

//Lista de Animais:
List<Animal> animals = <Animal>[
  Animal(
    image: 'https://images.pexels.com/photos/4224300/pexels-photo-4224300.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Leão",
    description: "O leão é um grande felino do gênero Panthera nativo da África e da Índia. Ele tem um corpo musculoso.",
    type: "Mamíferos",
  ),
  Animal(
    image: 'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Cachorro",
    description: "O cão ou cachorro doméstico é um descendente domesticado do lobo e é caracterizado por uma cauda levantada.",
    type: "Mamíferos",
  ),
  Animal(
    image: 'https://images.pexels.com/photos/1996333/pexels-photo-1996333.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Cavalo",
    description: "O cavalo é um mamífero doméstico, ungulado e de casco ímpar. Ele pertence à família taxonômica Equidae e é uma das duas subespécies existentes de Equus ferus.",
    type: "Mamíferos",
  ),
  Animal(
    image: 'https://images.pexels.com/photos/4666753/pexels-photo-4666753.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Baleia",
    description: "Baleias são um grupo amplamente distribuído e diversificado de mamíferos marinhos totalmente aquáticos.",
    type: "Mamíferos",
  ),
  Animal(
    image: 'https://images.pexels.com/photos/9015517/pexels-photo-9015517.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Enguia",
    description: "Enguias são peixes de nadadeiras radiadas pertencentes à ordem Anguilliformes, que consiste em oito subordens.",
    type: "Peixes",
  ),
  Animal(
    image: 'https://images.pexels.com/photos/1887830/pexels-photo-1887830.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Falcão",
    description: "Falcões são aves de rapina do gênero Falco, que inclui cerca de 40 espécies. Falcões estão amplamente distribuídos em todos os continentes.",
    type: "Aves",
  ),
  Animal(
    image: 'https://images.pexels.com/photos/724695/pexels-photo-724695.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Pinguim",
    description: "Pinguins são um grupo de aves aquáticas não voadoras. Eles vivem quase exclusivamente no Hemisfério Sul.",
    type: "Aves",
  ),
  Animal(
    image: 'https://images.pexels.com/photos/209035/pexels-photo-209035.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Pato",
    description: "Pato é o nome comum para inúmeras espécies de aves aquáticas da família Anatidae. Patos são geralmente menores.",
    type: "Aves",
  ),
  Animal(
    image: 'https://images.pexels.com/photos/10041693/pexels-photo-10041693.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Papagaio",
    description: "Papagaios, também conhecidos como psitacídeos, são aves das aproximadamente 398 espécies em 92 gêneros que compõem a ordem Psittaciformes.",
    type: "Aves",
  ),
  Animal(
    image: 'https://images.pexels.com/photos/87451/sparrow-tree-branch-bird-87451.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Pardal",
    description: "O nome pardal está mais firmemente ligado às aves da família Passeridae do Velho Mundo, especialmente ao pardal-doméstico.",
    type: "Aves",
  ),
  Animal(
    image: 'https://images.pexels.com/photos/35669/hyla-meridionalis-the-frog-amphibians.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Sapo",
    description: "Um sapo é qualquer membro de um grupo diversificado e em grande parte carnívoro de corpos curtos.",
    type: "Anfíbios",
  ),
  Animal(
    image: 'https://images.pexels.com/photos/4913766/pexels-photo-4913766.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Abelha",
    description: "Abelhas são insetos alados intimamente relacionados a vespas e formigas, conhecidos por seu papel na polinização.",
    type: "Invertebrados",
  ),
  Animal(
    image: 'https://images.pexels.com/photos/842401/pexels-photo-842401.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Formiga",
    description: "Formigas são insetos eussociais da família Formicidae e, juntamente com as vespas e abelhas relacionadas.",
    type: "Invertebrados",
  ),
  Animal(
    image: 'https://images.pexels.com/photos/3805975/pexels-photo-3805975.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Borboleta",
    description: "Borboletas são insetos na clado macrolepidóptera do clado Rhopalocera, da ordem Lepidoptera.",
    type: "Invertebrados",
  ),
  Animal(
    image: 'https://images.pexels.com/photos/34426/snake-rainbow-boa-reptile-scale.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Cobra",
    description: "Cobras são répteis carnívoros alongados e sem membros da subordem Serpentes.",
    type: "Répteis",
  ),
  Animal(
    image: 'https://images.pexels.com/photos/162307/giant-tortoise-reptile-shell-walking-162307.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    name: "Tartaruga",
    description: "Tartarugas são uma ordem de répteis conhecida como Testudines, caracterizada por uma concha desenvolvida principalmente a partir de suas costelas.",
    type: "Répteis",
  ),
];