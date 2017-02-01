#!/usr/bin/env python

from mercurial import cmdutil

cmdtable = {}
command = cmdutil.command(cmdtable)

@command('prompt', [], 'hg prompt STRING')
def prompt(ui, repo, **opts):
    book = getattr(repo, '_activebookmark', None)
    if book and repo._bookmarks[book] == repo['.'].node():
        ui.status(book)
    else:
        ui.status(repo.dirstate.branch())
