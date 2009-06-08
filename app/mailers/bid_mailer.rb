class BidMailer < ActionMailer::Base
  default :from => "eHarbor <app@example.com>"
  
  def outbid_notification(bid)
    @bid = bid
    mail(:to => bid.user.email,
         :subject => "You have been outbid")
  end
end
