module Admin
  class CouponsController < BaseController
    before_action :set_coupon, only: %i[show edit update destroy download_pass]

    def index
      @coupons = Coupon.all.limit(20)
    end

    def new
      @coupon = Coupon.new
    end

    def show
    end

    def create
      @coupon = Coupon.new(coupon_params)
      if @coupon.save
        redirect_to admin_coupons_path, notice: "Coupon created successfully"
      else
        render :new
      end
    end

    def edit
      @coupon = Coupon.find(params[:id])
    end

    def update
      @coupon = Coupon.find(params[:id])
      if @coupon.update(coupon_params)
        redirect_to admin_coupons_path, notice: "Coupon updated successfully"
      else
        render :edit
      end
    end

    def destroy
      @coupon = Coupon.find(params[:id])
      @coupon.destroy
      redirect_to admin_coupons_path, notice: "Coupon deleted successfully"
    end

    def download_pass
      pass = @coupon.generate_pass
      send_data pass, type: 'application/vnd.apple.pkpass', disposition: 'attachment', filename: 'coupon.pkpass'
    end

    private

    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    def coupon_params
      params.require(:coupon).permit(:title, :description, :code, :expires_at)
    end
  end
end