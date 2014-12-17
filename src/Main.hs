{-# LANGUAGE DeriveDataTypeable #-}

import System.Console.CmdArgs
import Control.Arrow ((&&&))
import qualified Data.ByteString.Char8 as C

data WC = WC { chars  :: Bool
             , lines_ :: Bool
             , words_ :: Bool
             } deriving (Data, Typeable)

wc :: WC
wc = WC { chars  = def &= name "m" &= help "print the byte counts"
        , lines_ = def &= help "print the character counts"
        , words_ = def &= help "print the word counts"
        }
        &= help ("Print newline, word, and byte counts for each FILE, " ++
                 "and a total line if more than one FILE is specified." ++
                 " With no FILE, or when FILE is -, read standard " ++
                 "input. A word is a non-zero-length sequence of " ++
                 "characters delimited by white space.")
        &= summary "wc v0.0.1, (C) Rodney Gomes"

countChars :: C.ByteString -> C.ByteString
countChars = C.pack . show . C.length

countLines :: C.ByteString -> C.ByteString
countLines = C.pack . show . length . C.lines

countWords :: C.ByteString -> C.ByteString
countWords = C.pack . show . length . C.words

space :: C.ByteString
space = C.pack " "

flat :: (C.ByteString, (C.ByteString, C.ByteString)) -> C.ByteString
flat (a, (b, c)) = C.concat [a, space, b, space, c]

addNewLine :: C.ByteString -> C.ByteString
addNewLine x = C.concat [x, C.pack "\n"]

optionHandler :: WC -> C.ByteString -> C.ByteString
optionHandler WC {chars  = True} = addNewLine . countChars
optionHandler WC {lines_ = True} = addNewLine . countLines
optionHandler WC {words_ = True} = addNewLine . countWords
optionHandler _                  = addNewLine . flat . (countLines &&& countWords &&& countChars)

main :: IO ()
main = cmdArgs wc >>= C.interact . optionHandler
