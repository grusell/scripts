#!/usr/bin/env python

import argparse
import os

class WallPaper(object):
  def __init__(self):
    self.args             = self.__parse()
    self._prefix           = os.getenv('HOME') + '/.wallpapers2/'
    self._lock             = self._prefix + 'lock'
    self._hist             = self._prefix + 'history.db'
    self._category         = self._prefix + 'category'
    self._wallpaper_dir    = self._prefix + 'Wallpapers'
    self._current          = self._prefix + 'current'
    self._resolution       = self._prefix + 'resolution'
    self._log              = self._prefix + 'log'
    self._sources          = self._prefix + 'sources'
    self._bgsetter         = 'fbsetbg -a'
    self._default_category = 'all'

  def __parse(self):
    parser = argparse.ArgumentParser(description='Wallpaper changer thingus')

    parser.add_argument('-c',
        '--category',
        help='Wallpaper Category',
        action='store_true')

    parser.add_argument('-r',
        '--resolution',
        help='Wallpaper resolution',
        action='store_true')

    parser.add_argument('-d',
        '--dump-cache',
        help='Display wallpaper cache',
        action='store_true')

    parser.add_argument('-f',
        '--flush-cache',
        help='Flush the wallpaper cache',
        action='store_true')

    parser.add_argument('-l',
        '--lock',
        help='Lock the current wallpaper',
        action='store_true')
    
    parser.add_argument('-u',
        '--unlock',
        help='Unlock the curent wallpaper',
        action='store_true')

    parser.add_argument('-C',
        '--clear',
        help='Clear previous category and resolution',
        action='store_true')

    parser.add_argument('-p',
        '--previous',
        help='Set wallpaper to the previous wallpaper',
        action='store_true')

    return parser.parse_args()

  def lock(self):
    f = open(self._lock,'w')

  def unlock(self):
    os.remove(self._lock)

  def is_locked(self):
    os.path.exists(self._lock)

if __name__ == '__main__':
  wallpaper = WallPaper()

  if wallpaper.is_locked and not wallpaper.args.unlock:
    print "currently locked, bailing out"
    exit
