#####
# Author: Gustavo Yokoyama Ribeiro
# Update: 20071207
# (C) Copyright 2010 Gustavo Yokoyama Ribeiro
# Licensed under CreativeCommons Attribution-ShareAlike 3.0 Unsupported
# http://creativecommons.org/licenses/by-sa/3.0/ for more info.

#file /vobs/linuxjava/platform/build/wvim/rootfs.scma11ref/usr/SYSqtapp/wvimps/wvimps
#file /vobs/linuxjava/platform/build/im/rootfs.ascension/usr/SYSqtapp/wvimps/wvimps
#file /vobs/linuxjava/platform/build/im/rootfs.elba/usr/SYSqtapp/wvimps/wvimps
file /vobs/core_imps/code/im/.build/rootfs.elba/usr/SYSqtapp/wvimps/wvimps

cd /vobs/core_imps/code/im/lj/binary

#dir /vobs/core_imps/code/dl_hdr/src
#dir /vobs/core_imps/code/dl_util/src
#dir /vobs/core_imps/code/dl_wvim/src
#dir /vobs/core_imps/code/ghdr
#dir /vobs/core_imps/code/util/hdr
#dir /vobs/core_imps/code/util/src
#dir /vobs/core_imps/code/wvim/src
#dir /vobs/core_imps/code/wvim/hdr
#dir /vobs/core_imps/code/im/lj/afw
#dir /vobs/core_imps/code/im/lj/pladapt
#dir /vobs/core_imps/code/im/lj/uistyle/chameleon/
#dir /vobs/core_imps/code/imps/baseClasses
#dir /vobs/core_imps/code/imps/cmdPool
#dir /vobs/core_imps/code/imps/cmdPool/pool
#dir /vobs/core_imps/code/imps/cmdPool/public
#dir /vobs/core_imps/code/imps/cmdPool/requests
#dir /vobs/core_imps/code/imps/cmdPool/util
#dir /vobs/core_imps/code/imps/database
#dir /vobs/core_imps/code/imps/database/fileTransfer
#dir /vobs/core_imps/code/imps/database/fileTransfer/public
#dir /vobs/core_imps/code/imps/database/peerLists
#dir /vobs/core_imps/code/imps/database/peerLists/public
#dir /vobs/core_imps/code/imps/database/peerLists/flyweightDb
#dir /vobs/core_imps/code/imps/database/peerLists/flyweightDb/db
#dir /vobs/core_imps/code/imps/database/peerLists/flyweightDb/flyweight
#dir /vobs/core_imps/code/imps/database/peerLists/flyweightDb/util
#dir /vobs/core_imps/code/imps/listener
#dir /vobs/core_imps/code/imps/listener/public
#dir /vobs/core_imps/code/imps/plugin/
#dir /vobs/core_imps/code/imps/plugin/public
#dir /vobs/core_imps/code/imps/plugin/wvim
#dir /vobs/core_imps/code/imps/plugin/wvim/public
#dir /vobs/core_imps/code/imps/public
#dir /vobs/core_imps/code/imps/public/baseClasses
#dir /vobs/core_imps/code/imps/public/database
#dir /vobs/core_imps/code/imps/public/serverRequest
#dir /vobs/core_imps/code/imps/public/session
#dir /vobs/core_imps/code/imps/public/settings
#dir /vobs/core_imps/code/imps/serverRequest
#dir /vobs/core_imps/code/imps/session
#dir /vobs/core_imps/code/imps/settings

# Print unicode string
# Usage pwc <unicode_variable>
define pwc
    set $i=0
    while $i < $arg0.d->len
        printf "%c", $arg0.d->unicode[$i++].cl
    end
    printf "\n"
end

target remote 192.168.1.42:123456

#br WVIMListCategories::startInstance
#br DL_WVimGetContactListIDList
#br ImpsListManager::getListContactListId
#br DL_WVimUpdateContactList
#br DL_WVIM_SP::callback_im_login

#br DL_WVIM_SP::callback_im_get_list
#br WvimRequestCmdGetContacts::startCommand
#br WvimRequestCmdGetList::startCommand
#br WvimRequestCmdGetList::onResponseReceived


#br WVIMRequestFactory::createMoveContacts
#br WvimReqContact::createMoveContacts

#br DL_WVIM_SP::callback_im_get_list

#br WVIMCmdCreateContactList::sendRequestToServer
#br WVIMRequestFactory::createCreateContactList
#br WvimReqList::createCreateList
#br WvimRequestCmdCreateContactList::startCommand
#br WvimRequestCmdCreateContactList::onResponseReceived

#br WVIMRequestFactory::createSearch
#br WvimRequestCmdSearch::startCommand
#br WvimRequestCmdSearch::onResponseReceived
#br WvimRequestCmdSearch::beforeDestruction
#br ImpsCmdPoolImpl::initialize
#br WVIMCmdSearch::start
#br WVIMCmdSearch::handleRequestResponse


#br WVIMViewerContext::handleDialogDone
#br WVIMListContext::stateEnter
#br WVIMListContext::stateExit
#br WVIMListContext::updateTitle
#br WindowList::setTitle
#br WindowManager::disposeWindow
#br WindowManager::cleanup
#br WindowManager::currentWindowHasFocus
#br WindowManager::getInstance
#br Window::hasFocus
#br Window::dispose
#br Window::isDisposed
#br Window::cover
#br Window::uncover
#br Window::isCovered
#br WVIMListContext::createList
#br ScreenConversation::appendTextToLog
#br DialogList::dispose
#br DialogList::isDisposed
#br WindowManager::disposeWindow
#br WindowManager::cleanup
