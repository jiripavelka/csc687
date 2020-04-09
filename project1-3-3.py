#!/usr/bin/env python
from sklearn.manifold import MDS

mapFile = "chrX_1Mb_distance_map.txt"
coordFile = "chrX_1Mb_coordinates2.txt"

with open(mapFile) as f:
  content = [line.split() for line in f]
f.close()

embedding = MDS(n_components=3)
transformed = embedding.fit_transform(content)

f = open(coordFile, "w")
for line in transformed:
  f.write(" ".join(str(x) for x in line))
  f.write("\n")
f.close()
