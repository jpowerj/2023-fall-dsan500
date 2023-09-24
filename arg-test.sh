commitMsg="Auto-commit"
if [ $# -eq 1 ]
  then
    commitMsg="$1"
fi

echo $commitMsg
