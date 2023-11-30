require "test_helper"

class PokemonLocatorServiceTest < ActiveSupport::TestCase
  test 'when pokemon exist in database' do
    assert_no_difference "Pokemon.count", "No new pokemons created" do
      pokemon = PokemonLocatorService.new('charmander').call

      assert_equal "4", pokemon.number
    end
  end

  test "when pokemon doesn't exists in the database" do
    assert_difference "Pokemon.count" do
      pokemon = PokemonLocatorService.new('pikachu').call

      assert_equal "25", pokemon.number
    end
  end

  test "when pokemon is invalid" do
    assert_no_difference "Pokemon.count", "No new pokemons created" do
      pokemon = PokemonLocatorService.new("pika").call

      assert_nil pokemon
    end
  end

  test "when pokemon with multiple names is invalid" do
    assert_no_difference "Pokemon.count", "No new pokemons created" do
      pokemon = PokemonLocatorService.new("pika pika").call

      assert_nil pokemon
    end
  end
end