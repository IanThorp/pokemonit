require "pokemonit/gem/version"
require "unirest"

module Pokemon
  class Damage
    attr_reader :name
    def initialize(options)
      @name = options["name"]
    end

    def self.all
      data = []
      Unirest.get("http://pokeapi.co/api/v2/pokemon/?limit=151").body["results"].map {|pokemon| data << Damage.new(pokemon)}
      data.map {|pokemon| pokemon.name}
    end

    def self.name(name)
      data = []
      Unirest.get("http://pokeapi.co/api/v2/pokemon/?limit=151").body["results"].map {|pokemon| data << Damage.new(pokemon)}
      pokemon_names = data.map {|pokemon| pokemon.name}
      pokemon_index = pokemon_names.index(name) + 1
      pokemon_object = self.get_pokemon(pokemon_index)
      types = self.get_types(pokemon_object)
      dmg_arr = []
      types.each {|type_obj| dmg_arr << self.get_dmg(type_obj)}
      dmg_arr.unshift(pokemon_names.first)
    end

  private
    def self.get_pokemon(pokemon_index)
      Unirest.get("http://pokeapi.co/api/v2/pokemon/#{pokemon_index}").body
    end

    def self.get_types(pokemon)
      types = []
      pokemon["types"].each {|type_obj| types << type_obj["type"]}
      types
    end

    def self.get_dmg(type_obj)
      all_dmg = {
      no_damage_to: [],
      no_damage_from: [],
      half_damage_to: [],
      half_damage_from: [],
      double_damage_to: [],
      double_damage_from: []
      }
      type_data = Unirest.get("#{type_obj['url']}").body

      all_dmg.keys.each {|key| type_data["damage_relations"][key.to_s].each do |dmg_amount|
          all_dmg[key] << dmg_amount["name"]
        end
      }
      all_dmg[:type_name] = type_data["name"]
      all_dmg

    end
  end
end
# Pokemon::Damage.name("jigglypuff")