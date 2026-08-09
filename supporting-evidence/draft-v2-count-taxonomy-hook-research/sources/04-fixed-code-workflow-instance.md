# Source S04 — Fixed ALE code

- Repository: https://github.com/rdi-berkeley/agents-last-exam
- Commit: `1e615e456de7cef57706680613cb80ee13c7fc76`
- Example: `tasks/engineering/gcode/main.py`

## Short quotation

> “Hide the reference.”

## Evidence extracted

- A workflow implementation can expose several instances that share scoring logic.
- The GCode example contains 18 workpiece instances with distinct PowerMill projects and a shared collision/STL scoring pipeline.
- The runnable lifecycle separates input staging from post-run reference staging.

## Boundary

An instance is not necessarily a trivial numeric substitution. Conversely, shared code does not prove that every declared variant is equally informative, rights-cleared or final-QC accepted.
