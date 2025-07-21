#!/usr/bin/env python3

import sh
import re

def clean_shell(dirty):
    return re.sub(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])', '', str(dirty))

# pyright: reportAttributeAccessIssue=false
monitors = sh.hyprctl("-j", "monitors", "show" )
active_workspace_id = int(clean_shell(sh.jq(".[] | select(.focused == true).activeWorkspace.id",
                                            _in = monitors)))

clients = sh.hyprctl("-j", "clients")
window_count = int(clean_shell(sh.jq(f"map(select(.workspace.id == {active_workspace_id})) | length",
                                     _in = clients)))

print(window_count)

match window_count:
    case 2:
        pass
    case 3:
        pass
    case 4:
        pass
    case _:
        pass
