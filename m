From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001068]: enable dmix by default
Date: Thu, 21 Apr 2005 08:39:41 +0200
Message-ID: <bf13bb9cd02c73b5dda3b93bba2514da@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5E4B31A8
	for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2005 08:39:41 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1068> 
======================================================================
Reported By:                mandreiana
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1068
Category:                   mixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-21-2005 06:49 CEST
Last Modified:              04-21-2005 08:39 CEST
======================================================================
Summary:                    enable dmix by default
Description: 
Please see this bug report:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=155421

Someone suggested to change /etc/asound.conf so dmix is turned on, but
please enable it by default.
======================================================================

----------------------------------------------------------------------
 pzad - 04-21-05 07:59 
----------------------------------------------------------------------
AFAIK this was done in alsa 1.0.9rc2.

----------------------------------------------------------------------
 mandreiana - 04-21-05 08:39 
----------------------------------------------------------------------
On a system with alsa 1.0.8 (Fedora Core 4 test 2), what minimum packages
do I need to upgrade to test this?

I have
alsa-utils-1.0.8-4
alsa-lib-1.0.8-4
and the drivers are in kernel.

Thanks!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-21-05 06:49 mandreiana     New Issue                                    
04-21-05 07:59 pzad           Note Added: 0004546                          
04-21-05 08:39 mandreiana     Note Added: 0004547                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
