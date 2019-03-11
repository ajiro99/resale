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
    recommend = %w(・Wi-FiSDカード付きでスマホに転送できる♪
                   ・6000円相当のおまけ付きでお得♪
                   ・超人気機種のミラーレスカメラ♪
                   ・カメラにWiFiを搭載しているので、撮ったその場でスマホに写真を送れる
                   ・液晶が回転するので自撮りも簡単
                   ・初心者でも安心の1ヶ月間の保証付き
                   ・軽量コンパクトで持ち運び楽チン♪).join("\n")

    deliver = %w(・ボディキャップ
                 ・レンズリアキャップ
                 ・レンズフロントキャップ
                 ・ストラップ
                 ・説明書
                 ・CDロム
                 ・フラッシュ
                 ・充電器
                 ・充電器ケーブル
                 ・バッテリー
                 ・USBケーブル
                 ・AVケーブル
                 ・元箱).join("\n")

    @description = Template.with_category(product_description[:category]).first.description
                           .gsub('%recommend%', recommend)
                           .gsub('%deliver%', deliver)
                           .gsub('%body%', body_name)
                           .gsub('%color%', StockingProduct.color.options.to_h.key(product_description[:color]))
                           .gsub('%lense%', lense)
                           .gsub('%remarks%', remarks.presence || '')
                           .gsub('%extra%', extra.join("\n"))

    @description = @description.gsub('❤️', '⭐️') if product_description[:account] == Sale.account.find_value(:sub)
    render :new
  end

  private

  def product_description_params
    params.require(:product_description).permit(:account, :category, :body, :color, :lense, extra_ids: [])
  end
end
