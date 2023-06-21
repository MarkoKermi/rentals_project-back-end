class VespaRepresenter
  def initialize(vespa)
    @vespa = vespa
  end

  def as_json
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

  private

  attr_reader :vespa
end
