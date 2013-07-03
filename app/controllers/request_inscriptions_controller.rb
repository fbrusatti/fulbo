class RequestInscriptionsController < ApplicationController
  before_filter :load_requester

  def create
    requested_id = params[:requested_id]
    requested_type = params[:requested_type]
    @requester.inscription_requesters.create(requested_id: requested_id,
                                             requested_type: requested_type)
    head :ok
  end

  private
    def load_requester()
      resource, id = request.path.split('/')[1, 2]
      @requester = resource.singularize.classify.constantize.find(id)
    end
end
