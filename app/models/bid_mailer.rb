class BidMailer < ActionMailer::Base
  
  def outbid_notification(bid)
    from "eHarbor <app@example.com>"
    recipients "#{bid.user.nickname} <#{bid.user.email}>"
    subject "You have been outbid"
    body :bid => bid
  end
  
  def seller_notification(bid)
    from "eHarbor <app@example.com>"
    recipients "#{bid.listing.user.nickname} <#{bid.listing.user.email}>"
    subject "New bid"
    body :bid => bid
  end
end