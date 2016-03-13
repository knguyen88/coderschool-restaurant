module ApplicationHelper
  def selected_item_ids
    session[:order_items].values
        .map { |item| item['id'] }
        .join(',')
  end
end
