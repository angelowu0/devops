# bash -n errors
rotate_logs.sh: line 4: syntax error near unexpected token `do'
rotate_logs.sh: line 4: `log_dir=$2for f in $(ls $log_dir/*.log); do'

# bash -x errors
+ archive_dir=
rotate_logs.sh: line 4: syntax error near unexpected token `do'
rotate_logs.sh: line 4: `log_dir=$2for f in $(ls $log_dir/*.log); do'

# shellcheck errors

In rotate_logs.sh line 3:
archive_dir=$1
^---------^ SC2034 (warning): archive_dir appears unused. Verify use (or export if used externally).


In rotate_logs.sh line 4:
log_dir=$2for f in $(ls $log_dir/*.log); do
                   ^------------------^ SC2046 (warning): Quote this to prevent word splitting.
                        ^------^ SC2154 (warning): log_dir is referenced but not assigned.
                        ^------^ SC2086 (info): Double quote to prevent globbing and word splitting.
                                         ^-- SC1089 (error): Parsing stopped here. Is this keyword correctly matched up?

Did you mean:
log_dir=$2for f in $(ls "$log_dir"/*.log); do

For more information:
  https://www.shellcheck.net/wiki/SC2034 -- archive_dir appears unused. Verif...
  https://www.shellcheck.net/wiki/SC2046 -- Quote this to prevent word splitt...
  https://www.shellcheck.net/wiki/SC2154 -- log_dir is referenced but not ass...


# Diagnosis
1: Improper indentation, seems to have caused many syntax errors

2: Unquoted shell variables

3: Arithmetic missing $(())

4: Using ls rather than globbing

5: Count not initialised

6: archive_dir never checked to exist

7: no exec permission

8: No argument validation

8: nullglob, globbing defaults to literal "*" file when no files in directory

9: missing set -euo pipefail