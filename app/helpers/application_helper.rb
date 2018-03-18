module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Prophet Ratings - NCAA Basketball Predictive Analytics"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "desc" ? "asc" : "desc"
    icon = sort_direction == "asc" ? "glyphicon glyphicon-chevron-up" : "glyphicon glyphicon-chevron-down"
    icon = column == sort_column ? icon : ""
    link_to "#{title} <span class='#{icon}'></span>".html_safe, {column: column, direction: direction}
  end
end
