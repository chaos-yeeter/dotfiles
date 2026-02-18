return {
	"nvim-treesitter/nvim-treesitter",
	-- FIXME: we have pinned to master branch to avoid upgrading to latest `main` branch
	--        upgrade to main when it's stable
	branch = "master",
	build = ":TSUpdate",
}
