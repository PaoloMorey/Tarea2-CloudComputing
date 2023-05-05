from pyspark import SparkContext
file_csv = "/tmp/files/movies.csv"

with open(file_csv, 'r') as f_in, open('/tmp/files/input_file.txt', 'w') as f_out:
	content = f_in.read()
	f_out.write(content)

sc = SparkContext("local", "Tarea 2 - Cloud Computing")
words = sc.textFile("/tmp/files/input_file.txt").flatMap(lambda line:line.split(" "))
wordCounts = words.map(lambda word: (word, 1)).reduceByKey(lambda a,b:a + b)
wordCountsOrdered = wordCounts.sortBy(lambda x: x[1], ascending=False)

wordCountsOrdered.saveAsTextFile("/tmp/files/output_files")