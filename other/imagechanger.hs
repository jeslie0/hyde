import System.Environment
import System.IO

subList :: (Integral a) => a -> [b] -> [b]
subList _ [] = []
subList 0 _ = []
subList n (x:xs) = x : subList (n-1) xs

otherSubList :: (Integral a) => a -> [b] -> [b]
otherSubList _ [] = []
otherSubList 0 list = list
otherSubList n (x:xs) = otherSubList (n-1) xs

replace :: (Eq a) => [a] -> [a] -> [a] -> [a]
replace [] _ sentence = sentence
replace _ _ [] = []
replace wrd neWrd sentence
  | wrd == subList (length wrd) sentence = neWrd ++ replace wrd neWrd shortSentence
  | otherwise                            = head sentence : replace wrd neWrd (tail sentence)
  where
    shortSentence = otherSubList (length wrd) sentence


main = do
  args <- getArgs
  handle <- openFile (args !! 0) ReadMode
  contents <- hGetContents handle
  let updatedContents = replace "2e3440" "ffffff" contents
      finalUpdate = replace "d8dee9" "2e3440" updatedContents
  writeFile (args !! 1) finalUpdate
  hClose handle
