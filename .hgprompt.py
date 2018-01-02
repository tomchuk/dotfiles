import os
import subprocess
import sys

HG = None


def get_hg():
    global HG
    if HG:
        return HG
    wd = os.path.abspath(os.path.curdir)
    while wd != '/':
        hg = os.path.join(wd, '.hg')
        if os.path.isdir(hg):
            HG = hg
            return hg
        wd = os.path.abspath(os.path.join(wd, '..'))


def dirty():
    # regenerate fsmonitor.state in the background
    DEVNULL = open(os.devnull, 'w')
    subprocess.Popen(['hg', 'status'], stdout=DEVNULL, stderr=DEVNULL)

    try:
        sf = open(os.path.join(get_hg(), 'fsmonitor.state'), 'rb')
        sf.seek(4)
        return bool(sf.read().decode('utf-8').split('\0')[3:-1])
    except:
        return False
    finally:
        sf.close()


def bm_or_br():
    bm = os.path.join(get_hg(), 'bookmarks.current')
    br = os.path.join(get_hg(), 'branch')
    if os.path.exists(bm):
        with open(bm) as f:
            return f.read().strip()
    elif os.path.exists(br):
        with open(br) as f:
            return f.read().strip()


if __name__ == '__main__':
    if not get_hg():
        sys.exit(1)
    b = bm_or_br()
    d = dirty()
    if b is not None and d is not None:
        sys.stdout.write('{}\n{}'.format(b, d))
        sys.exit(0)
    sys.exit(1)
