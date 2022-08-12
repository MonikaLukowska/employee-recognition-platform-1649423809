class FilterRewards
  attr_accessor :initial_scope

  def initialize(initial_scope)
    @initial_scope = initial_scope
  end

  def call(category)
    filter_by_category(initial_scope, category)
  end

  private

  def filter_by_category(scoped, category = nil)
    category ? scoped.where(category_id: Category.find_by(title: category)) : scoped
  end
end
