class ItemsRemoverJob
  include Sidekiq::Job

  def perform
    Item.where('created_at < ?', 1.hour.ago).delete_all
  end
end
