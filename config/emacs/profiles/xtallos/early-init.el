;;; early-init.el --- Early customization -*- lexical-binding: t; -*-
;;
;; Copyright (c) 2022, Chris Montgomery <chris@cdom.io>
;;
;; Author: Chris Montgomery <https://github.com/montchr>
;; Maintainer: Chris Montgomery <chris@cdom.io>
;;
;; Created: 05 Feb 2022
;;
;; URL: https://github.com/montchr/dotfield/tree/main/config/emacs
;;
;; License: GPLv3
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see
;; <http://www.gnu.org/licenses/>.
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;; See Emacs Help for more information on The Early Init File.
;; Basically, this file contains frame customizations.
;;
;;; Code:

;; Less clutter
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist '(vertical-scroll-bars))

;; Disable titlebar on frames
;; https://github.com/d12frosted/homebrew-emacs-plus/issues/433#issuecomment-1025547880
(add-to-list 'default-frame-alist '(undecorated . t))

;; Prevent `package.el' from loading packages before `straight.el' can.
;; https://github.com/raxod502/straight.el/#getting-started
(setq package-enable-at-startup nil)

(set-language-environment "UTF-8")
;; Undo an unwanted side effect of `set-language-environment'
(setq default-input-method nil)

(provide 'early-init)
;;; early-init.el ends here
