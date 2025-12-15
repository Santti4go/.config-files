## Usage

Instead of clonning this entire repository on your local `.config` you can copy just the folders you want by creating symlink so you can still pull updates

```bash
mkdir .config-santti
cd .config-santti
git clone git@github.com:Santti4go/.config-files
# create the symlink just for 'nvim', as example
ln -sr .config-files/nvim/ ~/.config/
```
