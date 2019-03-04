class ProductDescriptionsController < ApplicationController

  def new ;end

  def create
    product_description = product_description_params
    body = Body.find(product_description[:body].to_i)
    body_name = body.name
    remarks = body.remarks
    lense = Lense.find(product_description[:lense].to_i).name
    extra =
      Extra.where(
        id: product_description[:extra_ids].reject(&:blank?).map!(&:to_i)
      ).map do |extra|
        "・#{extra.name}【新品】"
      end

    @description = Template.with_category(product_description[:category]).first.description
                          .gsub('%body%', body_name)
                          .gsub('%lense%', lense)
                          .gsub('%remarks%', remarks.presence || '')
                          .gsub('%extra%', extra.join("\n"))


    @description = @description.gsub('❤️', '⭐️') if product_description[:account] == Sale.account.find_value(:sub)
    render :new
  end

  private

  def product_description_params
    params.require(:product_description).permit(:account, :category, :body, :lense, extra_ids: [])
  end
end
