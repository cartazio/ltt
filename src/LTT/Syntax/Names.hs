  {-# LANGUAGE GADTs, ScopedTypeVariables, DataKinds, KindSignatures #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE DeriveFoldable#-}
{-# LANGUAGE DeriveTraversable#-}

module LTT.Syntax.Names where





import Numeric.Natural -- once safeword is done ... switch to that
import Data.Data (Data)
import Data.Typeable (Typeable)


data SourceSpan = SourceSpan

data SourceName =
  deriving(Typeable)
data SourceLocation
  deriving(Typeable)
data QualName
  deriving(Typeable)

data NameSort =
   Local  -- Debruijn
   | Global -- fully resolved symbol that is visible in current scope
  deriving (Data,Typeable,Enum,Show,Eq,Ord)

data SrcNnmInfo = SrcNameInfo { srcName :: SourceName , srcLoc :: SourceLocation }
  deriving (Data,Typeable,Show,Eq,Ord)

data Name :: NameSort -> * where
  LName :: !Natural -- Debruijn
          -> SrcNnmInfo -> Name 'Local
  GName :: !QualName -- fully qualified name / symbol / module entry reference
          -> SrcNnmInfo -> Name 'Global


type LocalName = Name 'Local
type GlobalName = Name 'Global

data AName = ALocalName LocalName | AGlobalName GlobalName
  deriving (Data,Typeable,Enum,Show,Eq,Ord)
-- question, would pattern synonyms be helpful / useful here?

