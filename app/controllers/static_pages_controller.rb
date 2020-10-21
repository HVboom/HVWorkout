# frozen_string_literal: true

class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:about]

  def home
  end

  def about
  end
end
