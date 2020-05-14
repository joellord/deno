shopt -s nullglob

echo "Searching /deno-entrypoint for .js/.ts files to run..."

for file in /deno-entrypoint/*.[jt]s
do
  echo "Found file ${file}, executing"
  echo "---"
  deno run $file
  echo -e "---\n\n"
done

echo "Deno is installed and ready to go"
deno --version