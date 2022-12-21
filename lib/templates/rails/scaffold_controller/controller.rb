# frozen_string_literal: true

class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_name %>, only: %i[show edit update destroy]

  def index
    @<%= plural_name %> = <%= class_name %>.order('created_at DESC')
  end

  def new
    @<%= singular_name %> = <%= class_name %>.new
  end

  def edit
  end

  def create
    @<%= singular_name %> = <%= class_name %>.new(<%= singular_name %>_params)
    if @<%= singular_name %>.save
      redirect_to <%= plural_name %>_path, notice: '<%= human_name %> is successfully created.'
    else
      render :new
    end
  end

  def update
    if @<%= singular_name %>.update_attributes(<%= singular_name %>_params)
      redirect_to <%= plural_name %>_path,
                  notice: '<%= human_name %> is successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @<%= singular_name %>.destroy
      redirect_to <%= plural_name %>_path,
                  notice: '<%= human_name %> is successfully deleted.'
    end
  end

  def show; end

  private

  def <%= singular_name %>_params
    params.require(:<%= singular_name %>).permit(
      <%- attributes.each do |attribute| -%>
      <%- if attributes.last == attribute -%> :<%= attribute.column_name %><%- elsif attributes.first == attribute -%>      :<%= attribute.column_name %>,<%- else -%> :<%= attribute.column_name %>,<%- end -%>
      <%- end -%>
    )
  end

  def set_<%= singular_name %>
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
  end

end
