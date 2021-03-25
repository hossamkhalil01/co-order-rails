class DetailsController < ApplicationController

    def create 

        @detail = Detail.new(detail_params)
        @detail.orderer_id = current_user.id 

        if @detail.save
            redirect_to order_path(@detail.order_id)
        end 
    end

    def destroy 
        @detail = Detail.find(params[:id])     
        if  @detail.orderer_id == current_user.id
            @detail.destroy  
        end
        redirect_to order_path(params[:order_id])                 
    end
 

    private 
        def detail_params
            params.require(:detail).permit(:amount, :item, :price, :comment).merge!(order_id: params[:order_id])
        end
end
