module Api
    module V1
      class OrdersController < ApplicationController
        before_action :authenticate_user!
  
        def show
          # Mock order retrieval logic
          order = {
            id: params[:id],
            location_id: 1,
            company_id: 2229,
            dispatch_day_id: nil,
            delivery_method: "StarTrack Express",
            notes: "Can I get this in a compatible format, please?",
            printed_at: "2024-07-05T10:37:27.000+08:00",
            labelled_at: "2024-07-05T11:28:36.000+08:00",
            shipped_at: nil,
            delivery_name: nil,
            delivery_address1: "C/- Bart",
            delivery_address2: "123 Fake St",
            delivery_suburb: "Springfield",
            delivery_state: "VIC",
            delivery_postcode: "3000",
            delivery_country: "Australia",
            delivery_notes: "Mind the dog. She bites.",
            dispatched_consignment_note: "5IK12342132",
            dispatched: 1,
            order_type_id: 1,
            remote_order_id: 119191,
            order_items: [
              {
                sku_id: "XASD-3011",
                sku_code: "ASDFGHG-1000",
                remote_order_item_id: "119191-1",
                name: "The Big Bag - 1kg",
                quantity: 16,
                roast_profile_id: 1,
                grind_id: 1
              }
            ]
          }
  
  
          # Generate new tokens to return with the response
          new_tokens = current_user.generate_tokens
  
          render json: order, headers: new_tokens
        end
  
        private
  
        def authenticate_user!
          user = User.find_by(email: request.headers["uid"])
          if user && valid_token?(user)
            @current_user = user
          else
            render json: { error: 'Invalid or expired token' }, status: :unauthorized
          end
        end
  
        def valid_token?(user)
          request.headers["access-token"] == user.tokens[:access_token] &&
            request.headers["client"] == user.tokens[:client] &&
            request.headers["expiry"].to_i > Time.now.to_i
        end
  
        def current_user
          @current_user
        end
      end
    end
  end
  