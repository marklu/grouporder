class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
  end
  def create
  end
  def destroy
    @organization = Organization.find(params[:id])
    @organization.delete
    redirect_to organizations_path
  end
end
