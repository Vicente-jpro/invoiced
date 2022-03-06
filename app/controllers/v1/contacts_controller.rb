class V1::ContactsController < ApplicationController
    def index 
      @contacts = Contact.order("created_at DESC")
      render json: { status: "SUCCESS", message: "Loaded Contacts", data: @contacts}, status: :ok
    end

    def create 
      @contact = Contact.new(contact_params)
      if @contact.save
        render json:{status: "SUCCESS", message: "Created Successfully", data: @contact}, status: :ok
      else  
        render json: {status: "ERROR", message: "Error to create a contact", data: @contact.errors}, status: :unprocessable_entity 
      end
    end

    def destroy
      @contact = Contact.find(params[:id])
      if @contact.destroy
        render json: {status: "SUCCESS", message: "Deleted contact", data: @contact}, status: :ok 
      else
        render json: {status: "ERROR", message: "Error deleting contact", data: @contact.erros}, status: :ok 
      end
    end

    def update 
    end

    def show 
      @contact = Contact.find(params[:id])
      debugger
      if @contact
        render json: { status: "SUCCESS", message: "Loaded Contact", data: @contact}, status: :ok
      else  
        render json: { status: "ERROR", message: "Contact not found", data: @contact}, status: :ok
      end
    end

    private 
        def contact_params
          params.require(:contact).permit(:first_name, :last_name, :email)
        end

end
