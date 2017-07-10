import sys
import json
from pymlask.mlask import MLAsk

obj = MLAsk().analyze(sys.argv[1])
print(json.dumps(obj))
