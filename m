From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000520]: [PATCH] 91_debian_alsaconf_noclear
Date: Tue, 21 Sep 2004 20:03:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040921180305.14DFA39004@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8A57F2D4
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2004 20:03:05 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 18E6526658
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2004 20:03:05 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000520
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Bug ID:                     520
Category:                   alsaconf
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-21-2004 20:03 CEST
Last Modified:              09-21-2004 20:03 CEST
======================================================================
Summary:                    [PATCH] 91_debian_alsaconf_noclear
Description: 
This is a patch for alsaconf which makes it not clear the
screen, but print a newline instead.  The advantage is that
error messages are not cleared.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 20:03 jdthood        New Bug                                      
09-21-04 20:03 jdthood        File Added: 91_debian_alsaconf_noclear.dpatch                    
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
