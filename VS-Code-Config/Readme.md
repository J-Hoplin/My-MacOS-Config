# Visual Studio Code extensions
***

### Capture my brew installed list

```bash
code --list-extensions | xargs -L 1 echo code --install-extension > extension.sh
```