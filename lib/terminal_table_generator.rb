require './lib/prime_generator'
require './lib/table'
require 'terminal-table'

class TerminalTableGenerator
  STYLE = {
    border_x: '-',
    border_y: '',
    border_top: false,
    border_bottom: false
  }.freeze

  ROW_DESCRIPTER_LENGTH = 4
  attr_accessor :table

  def initialize(prime_count_raw)
    prime_count = convert_prime_count(prime_count_raw)

    unless prime_count.is_a?(Integer) && prime_count > 0
      err = "Only positive integers allowed \"#{prime_count_raw}\" is not valid"
      raise ArgumentError, err
    end

    @primes = PrimeGenerator.first(prime_count)
    @multiplication_table = Table.new(@primes).rows
    @table = Terminal::Table.new rows: rows,
                                 headings: headers,
                                 style: STYLE
  end

  private

  def convert_prime_count(prime_count)
    Float(prime_count).to_i
  rescue
    false
  end

  def headers
    [row_header('')] + @primes
  end

  def rows
    @multiplication_table.each_with_index.map do |row, index|
      [row_header(@primes[index])] + row
    end
  end

  def row_header(header)
    "#{header.to_s.ljust(ROW_DESCRIPTER_LENGTH)} |"
  end
end
