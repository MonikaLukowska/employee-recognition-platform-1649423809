class OrdersDecorator < SimpleDelegator
  def initialize(params, param)
    @param = param
    @params = params
  end

  def status
    @status = @params[:status]
  end

  def current?
    @params[:status] == @param || (@param == 'all' && !@params[:status]) ? 'bg-warning' : ''
  end
end
