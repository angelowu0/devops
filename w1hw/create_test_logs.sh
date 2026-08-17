mkdir -p test_logs && cd test_logs

# app.log — 12 errors → SHOULD be flagged
{
  echo "INFO server started"
  for i in {1..12}; do echo "ERROR db timeout $i"; done
} > app.log

# api.log — 3 errors → should NOT be flagged
{
  echo "INFO ok"
  for i in {1..3}; do echo "ERROR bad token $i"; done
} > api.log

# worker.log — exactly 10 errors → should NOT be flagged (boundary test)
for i in {1..10}; do echo "ERROR job failed $i"; done > worker.log

# db.log — 0 errors → should NOT be flagged
{ echo "INFO backup ok"; echo "INFO vacuum ok"; } > db.log