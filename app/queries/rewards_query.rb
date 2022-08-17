class RewardsQuery
  def initialize(params = {})
    @params = params
  end

  def results
    prepare_collection
    filter_by_category

    @results
  end

  private

  attr_reader :params

  def prepare_collection
    @results = Reward.order(created_at: :desc).includes(:category).with_attached_photo
  end

  def filter_by_category
    return if params[:category].blank?

    category_id = Category.find_by(title: params[:category])

    @results = @results.where(category_id: category_id)
  end
end
