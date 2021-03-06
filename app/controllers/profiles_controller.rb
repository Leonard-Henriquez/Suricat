# frozen_string_literal: true

class ProfilesController < ApplicationController
  def index
    @importances = policy_scope(Importance)
    @importances_values = @importances.all.map { |i| [i.name, i.value] }.to_h
  end

  def map
    @markers_pending = @user_opportunities.where(status: :pending).map do |u_op|
      title = "#{u_op.title} @#{u_op.company_name}"
      {
        title: title,
        lat: u_op.opportunity.latitude,
        lng: u_op.opportunity.longitude,
        infoWindow: {
          content: "<p>#{title}</p>"
        }
      }
    end

    @markers_applied = @user_opportunities.where(status: :applied).map do |u_op|
      title = "#{u_op.title} @#{u_op.company_name}"
      {
        title: title,
        lat: u_op.opportunity.latitude,
        lng: u_op.opportunity.longitude,
        infoWindow: {
          content: "<p>#{title}</p>"
        }
      }
    end

    authorize @user_opportunities
  end
end
