# gentoo-overlay

some dummy change

`eselect repository add tkaepp git https://github.com/tkaepp/gentoo-overlay.git`
`emaint sync -r tkaepp`

# Accept Keywords
`sudo nvim /etc/portage/package.accept_keywords/tkaepp`

```
*/*::tkaepp ~amd64
dev-python/trove-classifiers ~amd64
dev-python/calver ~amd64
```
