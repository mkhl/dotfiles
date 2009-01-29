#!/usr/bin/env python

from optparse import OptionParser
import os, sys, string
from cStringIO import StringIO
import urllib2, urllib, subprocess, pprint

optparser = OptionParser("usage: %prog [-p] file1 file2 file3\n\nPass files to me and I'll post them to http://gist.github.com")
optparser.set_defaults(gistread="", debug=False)
optparser.add_option( "-p", "--private",
        action="store_true", dest="private",
        help="Make the Gist private." )
optparser.add_option( "-c", "--clone",
        action="store_true", dest="clone",
        help="Clone this repository, only valid with the -r option." )
optparser.add_option( "-d", "--debug",
        action="store_true", dest="debug",
        help="Run in debug mode." )
optparser.add_option( "-r", "--read",
        action="store", dest="gistread", type="string",
        help="The Gist to read.." )
optparser.add_option( "-e", "--ext",
        action="store", dest="gistext", type="string",
        help="The extension you want this gist to have. Overrides the filename extension. (ex: .js .xml .php)" )


(opts, filenames) = optparser.parse_args()

if opts.debug:
    pp = pprint.PrettyPrinter(indent=4)
    print "Running in Debug Mode.."
    if opts.gistext:
        print "Using Ext: %s" % opts.gistext



def copy(content):
    system = sys.platform
    if system == 'darwin':
        p = subprocess.Popen(['pbcopy'], stdin=subprocess.PIPE)
        p.stdin.write(content)
        p.stdin.close()
        retcode = p.wait()
    elif system == 'linux':
        p = subprocess.Popen(['xclip'], stdin=subprocess.PIPE)
        p.stdin.write(content)
        p.stdin.close()
        retcode = p.wait()
        

def write(filenames):
    out = {}
    counter = 1

    for i in filenames:
        ext_key = "file_ext[gistfile%s]" % counter
        name_key = "file_name[gistfile%s]" % counter
        content_key = "file_contents[gistfile%s]" % counter
        if i == sys.stdin:
            if opts.debug:
                print "Getting file from STDIN"
            name = ''
            fileStr = sys.stdin.read()
        elif os.path.isfile(i):
            if opts.debug:
                print "Getting file from: %s" % i

            info = os.path.splitext(i)
            name = os.path.basename(i)
            f = open(i)
            fileStr = StringIO(f.read()).getvalue()
            if info[1]:
                out[ext_key] = info[1]

        if opts.gistext:
            out[ext_key] = opts.gistext
        else:
            out[ext_key] = '.txt'

        out[name_key] = name
        out[content_key] = fileStr
        counter = counter + 1
        
    if opts.private:
        out['private'] = 'on'

    out['login'] = os.popen('git config --global github.user').read().strip()
    out['token'] = os.popen('git config --global github.token').read().strip()

    if opts.debug:
        print "POST DATA:"
        pp.pprint(out)
    else:
        url = 'http://gist.github.com/gists'
        data = urllib.urlencode(out)
        req = urllib2.Request(url, data)
        response = urllib2.urlopen(req)

        url = response.geturl()
        copy(url)
        print url


def read(id):
    if opts.clone:
        print "Cloning Gist: %s" % id
        cmd = 'git clone git://gist.github.com/%s.git gist-%s' % (id, id)
        os.popen(cmd)
    else:
        url = "http://gist.github.com/%s.txt" % id;
        req = urllib2.Request(url)
        response = urllib2.urlopen(req)
        
        data = response.read()
        copy(data)
        print data


if opts.gistread:
    read(opts.gistread)
    sys.exit(0)


if len(filenames) == 0:
    if sys.stdin:
        filenames.append(sys.stdin)
        #print sys.stdin.read()
    else:
        print "No files given.."
        sys.exit(1)

write(filenames)
