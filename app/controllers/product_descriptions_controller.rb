require 'selenium-webdriver'
class ProductDescriptionsController < ApplicationController

  RECOMMEND = %w(・Wi-FiSDカード付きでスマホに転送できる♪
                 ・6000円相当のおまけ付きでお得♪
                 ・超人気機種のミラーレスカメラ♪
                 ・カメラにWiFiを搭載しているので、撮ったその場でスマホに写真を送れる
                 ・液晶が回転するので自撮りも簡単
                 ・初心者でも安心の1ヶ月間の保証付き
                 ・軽量コンパクトで持ち運び楽チン♪).join("\n")

  DELIVER = %w(・ボディキャップ
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
    price = product_description[:price]

    title = Template.with_category(product_description[:category]).first.title.gsub('%body%', body_name)
    description = Template.with_category(product_description[:category]).first.description
                          .gsub('%recommend%', RECOMMEND)
                          .gsub('%deliver%', DELIVER)
                          .gsub('%body%', body_name)
                          .gsub('%color%', StockingProduct.color.options.to_h.key(product_description[:color]))
                          .gsub('%lense%', lense)
                          .gsub('%remarks%', remarks.presence || '')
                          .gsub('%extra%', extra.join("\n"))

    description = description.gsub('❤️', '⭐️') if product_description[:account] == Sale.account.find_value(:sub)

    exhibition(title, description, price)
    render :new
  end

  private

  def product_description_params
    params.require(:product_description)
          .permit(:account, :category, :body, :color, :lense, :price, extra_ids: [])
  end

  def exhibition(title, description, price)
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: {
        args: ['--user-data-dir=/Users/enechange/Library/Application\ Support/Google/Chrome/']
      }
    )

    driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps
    driver.get('https://www.mercari.com/jp/sell/')

    # 商品名
    get_input_tags(driver)[0].send_keys(title)

    # 商品説明
    driver.find_element(class_name: 'textarea-default').send_keys(description)

    # カテゴリー
    select = get_select_tags(driver)
    set_select_box(select[0], '7')

    select_2 = get_select_tags(driver)
    set_select_box(select_2[1], '97')

    select_3 = get_select_tags(driver)
    set_select_box(select_3[2], '843')

    # ブランド
    get_input_tags(driver)[1].send_keys('オリンパス')

    # 商品の状態
    set_select_box(select[1], '3')

    # 配送料の負担
    set_select_box(select[2], '2')

    # 配送の方法
    select_4 = get_select_tags(driver)
    set_select_box(select_4[5], '14')

    # 発送元の地域
    set_select_box(select[3], '13')

    # 発送までの日数
    set_select_box(select[4], '2')

    get_input_tags(driver)[2].send_keys(price)

    # ラクマ
    driver.execute_script('window.open()')
    driver.switch_to.window(driver.window_handles[1])
    driver.get('https://fril.jp/item/new')

    # カテゴリ
    driver.find_element(:id, 'category_name').click
    driver.find_element(:css, "#select-category > div > div > div.modal-body > div > div:nth-child(9) > a").click
    sleep 0.5
    driver.find_element(:css, "#menu_8 > div:nth-child(4) > a").click
    sleep 0.5
    driver.find_element(:css, "#menu_8_3 > a:nth-child(1)").click

    # ブランド
    driver.find_element(:id, 'brand_name').click
    driver.find_element(:id, 'brand-search-text').send_keys('オリンパス')
    driver.find_element(:css, "#select-brand > div > div > div.modal-body > div > div > div.brand-all-list > div > ul > li > a").click

    # 状態
    driver.find_element(:css, "#status > option:nth-child(3)").click

    # 配送方法
    driver.find_element(:id, 'delivery_method').click
    driver.find_element(:css, "#select-delivery-method > div > div > div.modal-body > div > div:nth-child(3)").click

    # 価格
    driver.find_element(:id, 'sell_price').send_keys((price.to_i * 0.95).floor)
  end

  def get_input_tags(driver)
    driver.find_elements(class_name: 'input-default')
  end

  def get_select_tags(driver)
    driver.find_elements(tag_name: 'select')
  end

  def set_select_box(select, value)
    Selenium::WebDriver::Support::Select.new(select).select_by(:value, value)
  end
end
