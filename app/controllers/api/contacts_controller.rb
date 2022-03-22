class Api::ContactsController < ApplicationController
    def index 
      @contacts = Contact.order_by_created_at_desc
      render json: @contacts, status: :ok
    end

    def search 
      @contacts = Contact.search_all_by_first_name(params[:key])
      debugger
      if @contacts
        render json: @contacts, status: :ok
      else 
        render json: {message: "Name not found"}, status: :ok
      end

    end

    def create 
      @contact = Contact.new(contact_params)
      if @contact.save 
        render json: @contact, status: :ok, location: api_contacts_url(@contact) 
      else  
        render json: @contact.errors, status: :unprocessable_entity 
      end
    end

    def destroy
      begin  
        @contact = Contact.find(params[:id])
        if @contact.destroy
          render json: @contact, status: :ok 
        else
          render json: @contact.erros, status: :ok 
        end
      rescue => exception
        render json: { status: "ERROR", message: "Contact do not exist"}, status: 404 
      end
    end

    def update 
      begin
        @contact = Contact.find(params[:id])
        if @contact.update(contact_params)
          render json: @contact, status: :ok
        else
          render json: @contact.erros, status: :ok     
        end
      rescue => exception
        render json: @contact, status: 404 
      end
    end

    def show 
        begin
          @contact = Contact.find(params[:id])
        
          if @contact
            render json: @contact , status: :ok
          end  
            
        rescue => exception
          render json: @contact, status: 404  
        end
              
    end

    private 
        
        def contact_params
          params.require(:contact).permit(:first_name, :last_name, :email)
        end

end
