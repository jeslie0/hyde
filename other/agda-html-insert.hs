import System.Directory
import System.IO
import Data.List

str :: String
str = "#+SETUPFILE: /home/james/Dropbox/Documents/jeslie0.github.io/public/css/org-html-themes/org/theme-readtheorg-local.setup\n"  -- The text to prefix the files with.

folderLocation :: String
folderLocation = "/home/james/Dropbox/Documents/Agda/Univalent-Agda/org/" -- The location of the folder of files to prefix. Must end in "/"

  
inserter :: String -> String
inserter xs = str ++ xs

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
  let lst_of_files = map (\xs -> folderLocation ++ xs) $ delete "." $ delete ".." $ delete "ltximg" lst_of_files_in_folder
  sequence $ map fileInserter lst_of_files


