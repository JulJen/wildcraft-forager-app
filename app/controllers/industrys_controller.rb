class IndustrysController < ApplicationController
  before_action :require_logged_in

  def index
    @industrys = Industry.all
  end
