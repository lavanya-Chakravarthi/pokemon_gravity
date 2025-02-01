class PokemonCardResponse {
  final List<PokemonCard>? data;

  PokemonCardResponse({this.data});

  factory PokemonCardResponse.fromJson(Map<String, dynamic> json) {
    return PokemonCardResponse(
      data: (json['data'] as List?)
          ?.map((item) => PokemonCard.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class PokemonCard {
  final String? id;
  final String? name;
  final String? supertype;
  final List<String>? subtypes;
  final String? hp;
  final List<String>? types;
  final String? evolvesFrom;
  final List<Attack>? attacks;
  final List<Weakness>? weaknesses;
  final List<Resistance>? resistances;
  final List<String>? retreatCost;
  final int? convertedRetreatCost;
  final CardSet? set;
  final String? number;
  final String? artist;
  final String? rarity;
  final String? flavorText;
  final List<int>? nationalPokedexNumbers;
  final Legalities? legalities;
  final CardImages? images;
  final TcgPlayer? tcgplayer;
  final CardMarket? cardmarket;

  PokemonCard({
    this.id,
    this.name,
    this.supertype,
    this.subtypes,
    this.hp,
    this.types,
    this.evolvesFrom,
    this.attacks,
    this.weaknesses,
    this.resistances,
    this.retreatCost,
    this.convertedRetreatCost,
    this.set,
    this.number,
    this.artist,
    this.rarity,
    this.flavorText,
    this.nationalPokedexNumbers,
    this.legalities,
    this.images,
    this.tcgplayer,
    this.cardmarket,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['id'],
      name: json['name'],
      supertype: json['supertype'],
      subtypes: json['subtypes'] == null?[]:(json['subtypes'] as List?)?.map((e) => e.toString()).toList(),
      hp: json['hp'],
      types: json['types'] == null?[]:(json['types'] as List?)?.map((e) => e.toString()).toList(),
      evolvesFrom: json['evolvesFrom'],
      attacks: json['attacks'] == null?[]:(json['attacks'] as List?)
          ?.map((e) => Attack.fromJson(e))
          .toList(),
      weaknesses: json['weaknesses'] == null?[]:(json['weaknesses'] as List?)
          ?.map((e) => Weakness.fromJson(e))
          .toList(),
      resistances: json['resistances'] == null?[]:(json['resistances'] as List?)
          ?.map((e) => Resistance.fromJson(e))
          .toList(),
      retreatCost: json['retreatCost'] != null 
    ? (json['retreatCost'] as List).map((e) => e.toString()).toList() 
    : [],
      convertedRetreatCost: json['convertedRetreatCost'],
      set: json['set'] != null ? CardSet.fromJson(json['set']) : null,
      number: json['number'],
      artist: json['artist'],
      rarity: json['rarity'],
      flavorText: json['flavorText'],
      nationalPokedexNumbers:
          json['nationalPokedexNumbers'] == null? (json['nationalPokedexNumbers'] as List?)?.map((e) => e as int).toList():[],
      legalities:
          json['legalities'] != null ? Legalities.fromJson(json['legalities']) : null,
      images: json['images'] != null ? CardImages.fromJson(json['images']) : null,
      tcgplayer:
          json['tcgplayer'] != null ? TcgPlayer.fromJson(json['tcgplayer']) : null,
      cardmarket:
          json['cardmarket'] != null ? CardMarket.fromJson(json['cardmarket']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'supertype': supertype,
      'subtypes': subtypes,
      'hp': hp,
      'types': types,
      'evolvesFrom': evolvesFrom,
      'attacks': attacks?.map((e) => e.toJson()).toList(),
      'weaknesses': weaknesses?.map((e) => e.toJson()).toList(),
      'resistances': resistances?.map((e) => e.toJson()).toList(),
      'retreatCost': retreatCost,
      'convertedRetreatCost': convertedRetreatCost,
      'set': set?.toJson(),
      'number': number,
      'artist': artist,
      'rarity': rarity,
      'flavorText': flavorText,
      'nationalPokedexNumbers': nationalPokedexNumbers,
      'legalities': legalities?.toJson(),
      'images': images?.toJson(),
      'tcgplayer': tcgplayer?.toJson(),
      'cardmarket': cardmarket?.toJson(),
    };
  }
}

class CardSet {
  final String? id;
  final String? name;
  final String? series;
  final String? releaseDate;
  final CardSetImages? images; // Added images field

  CardSet({this.id, this.name, this.series, this.releaseDate, this.images});

  factory CardSet.fromJson(Map<String, dynamic> json) {
    return CardSet(
      id: json['id'],
      name: json['name'],
      series: json['series'],
      releaseDate: json['releaseDate'],
      images: json['images'] != null ? CardSetImages.fromJson(json['images']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'series': series,
      'releaseDate': releaseDate,
      'images': images?.toJson(), // Ensure proper JSON serialization
    };
  }
}


class CardSetImages {
  final String? symbol;
  final String? logo;

  CardSetImages({this.symbol, this.logo});

  factory CardSetImages.fromJson(Map<String, dynamic> json) {
    return CardSetImages(
      symbol: json['symbol'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'logo': logo,
    };
  }
}

class Attack {
  final String? name;
  final List<String>? cost;
  final int? convertedEnergyCost;
  final String? damage;
  final String? text;

  Attack({this.name, this.cost, this.convertedEnergyCost, this.damage, this.text});

  factory Attack.fromJson(Map<String, dynamic> json) {
    return Attack(
      name: json['name'],
      cost: (json['cost'] as List?)?.map((e) => e.toString()).toList(),
      convertedEnergyCost: json['convertedEnergyCost'],
      damage: json['damage'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cost': cost,
      'convertedEnergyCost': convertedEnergyCost,
      'damage': damage,
      'text': text,
    };
  }
}

class Weakness {
  final String? type;
  final String? value;

  Weakness({this.type, this.value});

  factory Weakness.fromJson(Map<String, dynamic> json) {
    return Weakness(
      type: json['type'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
    };
  }
}

class Resistance {
  final String? type;
  final String? value;

  Resistance({this.type, this.value});

  factory Resistance.fromJson(Map<String, dynamic> json) {
    return Resistance(
      type: json['type'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
    };
  }
}

class CardImages {
  final String? small;
  final String? large;

  CardImages({this.small, this.large});

  factory CardImages.fromJson(Map<String, dynamic> json) {
    return CardImages(
      small: json['small'],
      large: json['large'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'small': small,
      'large': large,
    };
  }
}

class TcgPlayer {
  final String? url;
  final String? updatedAt;
  final TcgPlayerPrices? prices; // Added prices field

  TcgPlayer({this.url, this.updatedAt, this.prices});

  factory TcgPlayer.fromJson(Map<String, dynamic> json) {
    return TcgPlayer(
      url: json['url'],
      updatedAt: json['updatedAt'],
      prices: json['prices'] != null ? TcgPlayerPrices.fromJson(json['prices']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'updatedAt': updatedAt,
      'prices': prices?.toJson(), 
    };
  }
}

class TcgPlayerPrices {
  final HoloFoil? holofoil;
  final HoloFoil? reverseHolofoil;

  TcgPlayerPrices({this.holofoil, this.reverseHolofoil});

  factory TcgPlayerPrices.fromJson(Map<String, dynamic> json) {
    return TcgPlayerPrices(
      holofoil: json['holofoil'] != null ? HoloFoil.fromJson(json['holofoil']) : null,
      reverseHolofoil: json['reverseHolofoil'] != null ? HoloFoil.fromJson(json['reverseHolofoil']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'holofoil': holofoil?.toJson(),
      'reverseHolofoil': reverseHolofoil?.toJson(),
    };
  }
}

// HoloFoil class for price details
class HoloFoil {
  final double? low;
  final double? mid;
  final double? high;
  final double? market;
  final double? directLow;

  HoloFoil({this.low, this.mid, this.high, this.market, this.directLow});

  factory HoloFoil.fromJson(Map<String, dynamic> json) {
    return HoloFoil(
      low: json['low']?.toDouble() ?? 0.0,
      mid: json['mid']?.toDouble() ?? 0.0,
      high: json['high']?.toDouble() ?? 0.0,
      market: json['market']?.toDouble() ?? 0.0,
      directLow: json['directLow']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'low': low,
      'mid': mid,
      'high': high,
      'market': market,
      'directLow': directLow,
    };
  }
}

class CardMarket {
  final String? url;
  final String? updatedAt;
  final CardMarketPrices? prices; // Added prices field

  CardMarket({this.url, this.updatedAt, this.prices});

  factory CardMarket.fromJson(Map<String, dynamic> json) {
    return CardMarket(
      url: json['url'],
      updatedAt: json['updatedAt'],
      prices: json['prices'] != null ? CardMarketPrices.fromJson(json['prices']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'updatedAt': updatedAt,
      'prices': prices?.toJson(),
    };
  }
}

// New class for CardMarket Prices
class CardMarketPrices {
  final double? averageSellPrice;
  final double? lowPrice;
  final double? trendPrice;
  final double? germanProLow;
  final double? suggestedPrice;
  final double? reverseHoloSell;
  final double? reverseHoloLow;
  final double? reverseHoloTrend;

  CardMarketPrices({
    this.averageSellPrice,
    this.lowPrice,
    this.trendPrice,
    this.germanProLow,
    this.suggestedPrice,
    this.reverseHoloSell,
    this.reverseHoloLow,
    this.reverseHoloTrend,
  });

  factory CardMarketPrices.fromJson(Map<String, dynamic> json) {
    return CardMarketPrices(
      averageSellPrice: json['averageSellPrice']?.toDouble() ?? 0.0,
      lowPrice: json['lowPrice']?.toDouble() ?? 0.0,
      trendPrice: json['trendPrice']?.toDouble() ?? 0.0,
      germanProLow: json['germanProLow']?.toDouble() ?? 0.0,
      suggestedPrice: json['suggestedPrice']?.toDouble() ?? 0.0,
      reverseHoloSell: json['reverseHoloSell']?.toDouble() ?? 0.0,
      reverseHoloLow: json['reverseHoloLow']?.toDouble() ?? 0.0,
      reverseHoloTrend: json['reverseHoloTrend']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'averageSellPrice': averageSellPrice,
      'lowPrice': lowPrice,
      'trendPrice': trendPrice,
      'germanProLow': germanProLow,
      'suggestedPrice': suggestedPrice,
      'reverseHoloSell': reverseHoloSell,
      'reverseHoloLow': reverseHoloLow,
      'reverseHoloTrend': reverseHoloTrend,
    };
  }
}

class Legalities {
  final String? standard;
  final String? expanded;
  final String? unlimited;

  Legalities({this.standard, this.expanded, this.unlimited});

  factory Legalities.fromJson(Map<String, dynamic> json) {
    return Legalities(
      standard: json['standard'],
      expanded: json['expanded'],
      unlimited: json['unlimited'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'standard': standard,
      'expanded': expanded,
      'unlimited': unlimited,
    };
  }
}

