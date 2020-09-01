> test_output.txt

for f in tests/*.lua; do
	[ -f "${f}" ] || break
	lua5.3 "${f}" >> test_output.txt -v
done

cat test_output.txt
