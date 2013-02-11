# Todo

## Workflow API

JB-gist-hack should configure the production branch.

It may imply that the Rakefile is only present in the development branch - the production branch should not be touched manually.

It should do sanity checks when modifying the repository. Specifically it should check if the development branch is the production branch.

### page

((Should be modularized to use "providers" that may do different things without breaking the JB-gist-hack workflow.))

#### local

Just like Jekyll-Bootstrap: create a new post.

#### gist

- create a new Gist
- create submodule the Gist that was just created

something like this:

	jist -p -d "2012-11-25-hello-world" _pages/2012-11-25-hello-world.md
	git submodule add git://gist.github.com/4143829 _posts/2012-11-25-hello-world
	rm _pages/2012-11-25-hello-world.md

### post

((Should be modularized to use "providers" that may do different things without breaking the JB-gist-hack workflow.))

#### local

Just like Jekyll-Bootstrap: create a new post.

#### gist

- create a new Gist
- create submodule the Gist that was just created

something like this:

	jist -p -d "2012-11-25-hello-world" _pages/2012-11-25-hello-world.md
	git submodule add git://gist.github.com/4143829 _posts/2012-11-25-hello-world
	rm _pages/2012-11-25-hello-world.md

### deploy

- sync production repository with development repository
- change submodules in production repository to read-only (git://)
- commit
- push

### preview

Just like deploy but instead of pushing, start local instance of Jekyll

## Generation API

### Gist comments (comment provider)

### Gist forks (comment provider?)

### Gist includes

There should be a way to use Gists as includes without using Javascript for that. Maybe even use the other files in the posts Gist repository for that.

## Questions

- How to use jist as a library
- How to create a Gist as a here document in ruby

## References

- <https://github.com/weichert/jekyll-bootstrap>
- <https://gist.github.com/weichert>
- <http://developer.github.com/v3/gists/>
- <https://github.com/ConradIrwin/jist>
