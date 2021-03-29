class DetailsController < ApplicationController
    before_action :set_detail, only: [:edit, :update, :destroy ] 
    def create 

        @detail = Detail.new(detail_params)
        @detail.orderer_id = current_user.id 

        if @detail.save
            redirect_to order_path(@detail.order_id)
        end 
    end

    def destroy    
        if  @detail.orderer_id == current_user.id
            @detail.destroy  
        end
        redirect_to order_path(params[:order_id])                 
    end
    
    def edit  
        @order = Order.find(params[:order_id])   
    end

    def update
        if  @detail.orderer_id == current_user.id and @detail.update(detail_params)
            redirect_to order_path(params[:order_id])
        else
            render 'edit'
        end
           
    end

    private 
        def detail_params
            params.require(:detail).permit(:amount, :item, :price, :comment).merge!(order_id: params[:order_id])
        end

        def set_detail
            @detail = Detail.find(params[:id])            
        end
end
