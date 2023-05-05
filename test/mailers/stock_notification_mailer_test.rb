require "test_helper"

class StockNotificationMailerTest < ActionMailer::TestCase
  test "back_in_stock" do
    mail = StockNotificationMailer.back_in_stock
    assert_equal "Back in stock", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
