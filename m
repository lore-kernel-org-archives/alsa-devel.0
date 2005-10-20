From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001469]: Japanese characters are broken with alsaconf
Date: Thu, 20 Oct 2005 17:03:29 +0200
Message-ID: <ad7e3c65a4e8e8e111013bf6f008f77b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E0855185
	for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2005 17:03:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1469> 
======================================================================
Reported By:                speedking
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1469
Category:                   alsaconf
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-05-2005 18:01 CEST
Last Modified:              10-20-2005 17:03 CEST
======================================================================
Summary:                    Japanese characters are broken with alsaconf
Description: 
"alsaconf" displays broken characters for k/d button messages while using
Japanese.
======================================================================

----------------------------------------------------------------------
 speedking - 10-19-05 18:13 
----------------------------------------------------------------------
The distro is RHEL 3 U5 x86 and x86_64.

----------------------------------------------------------------------
 speedking - 10-20-05 17:03 
----------------------------------------------------------------------
It looks like we have to install ncurses.  Can download it at
http://www.gnu.org/software/ncurses/ncurses.html but it's very complicated
to install it. I tried multiple things but I'm not sure I did correctly.
It does not work the way I have it installed.  Any help you could offer on
installing it for RHEL3 U5 would be appreciated.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-05-05 18:01 speedking      New Issue                                    
10-05-05 18:36 tiwai          Note Added: 0006431                          
10-19-05 17:47 speedking      Note Added: 0006493                          
10-19-05 18:11 tiwai          Note Added: 0006494                          
10-19-05 18:13 speedking      Note Added: 0006495                          
10-20-05 17:03 speedking      Note Added: 0006507                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
