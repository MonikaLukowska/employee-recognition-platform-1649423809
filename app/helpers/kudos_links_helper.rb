module KudosLinksHelper
  def disabled?(kudo)
    policy(kudo).update? ? '' : 'disabled'
  end
end
