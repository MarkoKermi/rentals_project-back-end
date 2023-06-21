class VespasRepresenter
  def initialize(vespas)
    @vespas = vespas
  end

  def as_json
    vespas.map do |vespa|
      {
        id: vespa.id,
        name: vespa.name,
        description: vespa.description,
        photo: vespa.photo,
        price: vespa.price,
        model: vespa.model,
        date_added: vespa.created_at
      }
    end
  end

  private

  attr_reader :vespas
end
