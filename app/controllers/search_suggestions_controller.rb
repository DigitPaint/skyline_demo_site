class SearchSuggestionsController < ApplicationController
	def index
		solr = RSolr.connect
		
		response = solr.select({:q => params[:value], :extendedResults => true, :suggestionCount=>20, :facet=>true , "facet.field" => "spell", "facet.prefix"=>params[:value]})  
		
  	#extract spelling suggestions from response  	
    @suggestions = response['facet_counts']['facet_fields']['spell'].map{|sug| sug if sug.is_a?(String)}.compact!
    
  	render :json => @suggestions.to_json  	
	end
end
