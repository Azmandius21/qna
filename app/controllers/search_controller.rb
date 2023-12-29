class SearchController < ApplicationController
  def search
    @query = params[:query]
    @search_area = params[:search_area]
    @result = if @search_area == 'all'
      ThinkingSphinx.search(@query)
    else
      to_class(@search_area).search(@query)
    end
  end
end
