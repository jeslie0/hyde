import System.Environment
import System.Directory
import System.IO
import Data.List

str :: String
str = "---\nlayout: agda\n---\n" -- The text to prefix the files with.

folderLocation :: String
folderLocation = "/home/james/Dropbox/Documents/jeslie0.github.io/UniAgda/" -- The location of the folder of files to prefix. Must end in "/"

  
inserter :: String -> String
inserter xs = str ++ xs

otherSubList :: Integer -> [b] -> [b]
otherSubList _ [] = []
otherSubList 0 list = list
otherSubList n (_:xs) = otherSubList (n-1) xs

fileInserter :: FilePath -> IO ()
fileInserter path = do
  handle <- openFile path ReadMode
  (tempName, tempHandle) <- openTempFile "." "temp"
  contents <- hGetContents handle
  let updatedContents = inserter contents
  hPutStr tempHandle updatedContents
  hClose handle
  hClose tempHandle
  removeFile path
  renameFile tempName path


main = do
  lst_of_files_in_folder <- getDirectoryContents folderLocation
  let lst_of_files = map (\xs -> folderLocation ++ xs) $ delete "." $ delete ".." lst_of_files_in_folder
  sequence $ map fileInserter lst_of_files


