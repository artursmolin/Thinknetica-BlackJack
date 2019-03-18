class Hand
  attr_reader :cards

  def initialize
    self.cards = []
  end

  def sum
    sum = 0
    a_cards = cards.select { |card| card.rank == 'A' }
    normal_cards = cards.reject { |card| card.rank == 'A' }
    sum = normal_cards .map(&:points) .reduce(:+)
    sum += if sum <= 10 && a_cards.count == 1
             11
           else
             a_cards.count * 1
           end
    sum
  end

  private

  attr_writer :cards
end
