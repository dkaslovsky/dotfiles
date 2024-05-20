print("--------->>>>>>>> ENABLE AUTORELOAD <<<<<<<<<------------")
c = get_config()
c.InteractiveShellApp.exec_lines = []
c.InteractiveShellApp.exec_lines.append('%load_ext autoreload')
c.InteractiveShellApp.exec_lines.append('%autoreload 2')

print("--------->>>>>>>> ENABLE CUSTOM ERROR BACKGROUND COLOR <<<<<<<<<------------")
try:
    from IPython.core import ultratb
    ultratb.VerboseTB._tb_highlight = "bg:ansired"
except Exception as e:
    print(f"Error patching background color for tracebacks: {e}")

