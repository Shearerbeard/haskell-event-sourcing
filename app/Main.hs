{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.ByteString (ByteString)
import Data.Either
import Data.Maybe
import Data.String
import Lib
import Web.Stripe
import Web.Stripe.Customer
import Prelude (IO, fromInteger, print, ($))

main :: IO ()
main = do
  let key = "sk_test_51KtfMBHho03e1UbZtFkaAoCBBRLb45qg2zeoWFyYn55l8fMFvVrcIIXozhRS3RThiQqu4m9aCI1xf9YDjUpNPizD001ZcXIbp3"
  let config = StripeConfig (StripeKey key) Nothing
  result <- stripe config $ getCustomers -&- Limit 100

  case result of
    Right stripelist -> print (list stripelist :: [Customer])
    Left stripeError -> print stripeError