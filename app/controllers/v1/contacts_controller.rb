class V1::ContactsController < ApplicationController
    def index 
      @contacts = Contact.order("created_at DESC")
      render json: @contacts, status: :ok
    end

    def create 
      @contact = Contact.new(contact_params)
      if @contact.save
        render json: @contact, status: :ok
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
