class PaginatingDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :limit_value, :entry_name, :total_count, :offset_value,
    :first_page?, :last_page?, :next_page, :prev_page, :out_of_range?
end