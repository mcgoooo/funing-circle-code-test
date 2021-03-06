class PrimeGenerator
  def self.first(prime_count = 1)
    primes = []
    enumerator = 0
    while primes.length < prime_count
      primes.push(enumerator) if prime?(enumerator)
      enumerator += 1
    end

    primes
  end

  def self.prime?(number)
    return false if number <= 1
    max = Math.sqrt(number)

    (2..max).any? do |i|
      return false if (number % i).zero?
    end

    true
  end
end
