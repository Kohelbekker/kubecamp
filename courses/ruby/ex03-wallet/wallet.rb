class Wallet 

  def initialize(*args)
    @penny = 0
    @nickel = 0
    @dime = 0
    @quarter = 0
    @dollar = 0

    args.each do |x|
      @penny += 1 if x == :penny
      @nickel += 1 if x == :nickel
      @dime += 1 if x == :dime
      @quarter += 1 if x == :quarter
      @dollar += 1 if x == :dollar
    end
  end

  def take(*args) 
    args.each do |x|
      @penny -= 1 if x == :penny && @penny.positive?
      @nickel -= 1 if x == :nickel && @nickel.positive?
      @dime -= 1 if x == :dime && @dime.positive?
      @quarter -= 1 if x == :quarter && @quarter.positive?
      @dollar -= 1 if x == :dollar && @dollar.positive?
    end
  end

  def <<(coin) 
      @penny += 1 if coin == :penny
      @nickel += 1 if coin == :nickel
      @dime += 1 if coin == :dime
      @quarter += 1 if coin == :quarter
      @dollar += 1 if coin == :dollar
  end

  def cents
    @cents = @penny + 5 * @nickel + 10 * @dime + 25 * @quarter + 100 * @dollar
  end

  def dollars
    @dollars = @cents / 100.0
  end
end

