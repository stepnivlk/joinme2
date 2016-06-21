require 'hashie'

module MashedParser
  protected

  def json
    mashed super
  end

  private

  def mashed(thing)
    if thing.is_a?(Hash)
      Hashie::Mash.new(thing)
    else
      thing
    end
  end
end
