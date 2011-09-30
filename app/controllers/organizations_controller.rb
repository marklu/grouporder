class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
  end
  def add_multiple
    @organization_names = params[:organizations].split("\n")
    for name in @organization_names do
      Organization.find_or_create_by_name(name)
    end
    redirect_to organizations_path
  end
  def destroy
    @organization = Organization.find(params[:id])
    @organization.delete
    redirect_to organizations_path
  end
end
