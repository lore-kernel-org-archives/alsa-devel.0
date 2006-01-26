From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001397]: mic volume very low
Date: Thu, 26 Jan 2006 09:17:47 +0100
Message-ID: <1e478f4c2849cb5dee9ae7ebd3dedf7c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C5527197
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 09:17:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1397> 
======================================================================
Reported By:                pengu
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1397
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Kubuntu
Kernel Version:             2.6.10-5-686
======================================================================
Date Submitted:             09-05-2005 02:21 CEST
Last Modified:              01-26-2006 09:17 CET
======================================================================
Summary:                    mic volume very low
Description: 
Hello,

This bug is similar to the bug # 0001232

I have a Shuttle SB83G5 (  FB83 mainboad - Intel 915G chipset - Intel
Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family))
The Audio is Realtek ALC658.
The mic record volume is very low, not audible even with the boost
activated.
There is only a front mic, so I cannot try on an other plug.

======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 21:59 
----------------------------------------------------------------------
Any improvement in later releases?

----------------------------------------------------------------------
 pengu - 01-26-06 09:17 
----------------------------------------------------------------------
I've just installed the 1.0.11rc2 , but nothing changes. The sound is still
very low, even with the "boost" option checked.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-05-05 02:21 pengu          New Issue                                    
09-05-05 02:21 pengu          Distribution              => Kubuntu         
09-05-05 02:21 pengu          Kernel Version            => 2.6.10-5-686    
12-30-05 21:59 rlrevell       Note Added: 0007266                          
01-26-06 09:17 pengu          Note Added: 0007786                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
