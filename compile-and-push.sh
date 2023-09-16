quarto render
git add -A .
git commit -m "Auto-commit"
git push

# But now we also copy the shared documents to the S03 page, and push that one as well

cp -r w03/ ../dsan5000-03/w03/
cp -r w04/ ../dsan5000-03/w04/
cp -r writeups/ ../dsan5000-03/writeups/
cd ../dsan5000-03/
quarto render
git add -A .
git commit -m "Auto-commit"
git push
