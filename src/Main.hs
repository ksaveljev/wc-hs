{-# LANGUAGE DeriveDataTypeable #-}

import System.Console.CmdArgs
import Control.Arrow ((&&&))

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

countChars :: String -> String
countChars = show . length

countLines :: String -> String
countLines = show . length . lines

countWords :: String -> String
countWords = show . length . words

flat :: (String, (String, String)) -> String
flat (a, (b, c)) = " " ++ a ++ " " ++ b ++ " " ++ c

optionHandler :: WC -> String -> String
optionHandler WC {chars  = True} = countChars
optionHandler WC {lines_ = True} = countLines
optionHandler WC {words_ = True} = countWords
optionHandler _                  = flat . (countLines &&& countWords &&& countChars)

main :: IO ()
main = cmdArgs wc >>= interact . optionHandler
