class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    initialize_search
    handle_search_name
    clear
  end

  #Remove search criteria

  def clear
      session[:search_name] = nil
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact = set_contact
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
    @contact = set_contact
  end

  # POST /contacts
  # POST /contacts.json
  def create
    
    @contact = Contact.new(contact_params)
    @contact.user = current_user

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :index, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update

    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # User owned contact (singular)
    def set_contact
      @contact ||= current_user.contacts.find(params[:id])
    end

    # User owned contact list
    def set_contacts
      @contacts ||= current_user.contacts
    end

    def initialize_search
      session[:search_name] ||= params[:search_name]
    end

    def handle_search_name
      if [:search_name]
        @contacts = set_contacts.where("first_name LIKE ?", "%#{session[:search_name]}%").or(set_contacts.where("last_name LIKE ?", "%#{session[:search_name]}%"))
        clear
      else
        @contacts = set_contact
      end
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :primary_phone, :email, :user_id)
    end


end
