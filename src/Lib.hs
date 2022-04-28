{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Lib
  ( someFunc,
  )
where

import Data.ByteString.Lazy.Char8 (ByteString)
import Data.FileEmbed (makeRelativeToProject)
import Data.Morpheus (interpreter)
import Data.Morpheus.Document (importGQLDocument)
import Data.Morpheus.Types (Arg (Arg), RootResolver (..), Undefined (..))
import Data.Text (Text)
import Foreign.C (eDIRTY)
import GHC.IO.Device (IODeviceType (Directory))

makeRelativeToProject "src/schema.gql" >>= importGQLDocument

rootResolver :: RootResolver IO () Query Undefined Undefined
rootResolver =
  RootResolver
    { queryResolver = Query {deity},
      mutationResolver = Undefined,
      subscriptionResolver = Undefined
    }
  where
    deity (Arg name) =
      pure
        Deity
          { name = pure name,
            power = pure (Just "Shapeshifting \n ")
          }

someFunc :: IO ()
someFunc = putStrLn "someFunc"
