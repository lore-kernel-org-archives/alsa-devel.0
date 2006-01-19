From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001762]: alsa-driver-cvs build fails if configured with relative kernel source path
Date: Thu, 19 Jan 2006 21:55:15 +0100
Message-ID: <6a124ae2866c1e42d78b5d373c9e9928@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 380FC16F
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 21:55:15 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1762> 
======================================================================
Reported By:                Will
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1762
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.x
======================================================================
Date Submitted:             01-19-2006 21:55 CET
Last Modified:              01-19-2006 21:55 CET
======================================================================
Summary:                    alsa-driver-cvs build fails if configured with
relative kernel source path
Description: 
If you configure alsa-driver giving a *relative* path such as ../linux for
the kernel source tree, the build always fails. This looks like a new
issue because relative paths work ok with alsa-driver-1.0.9 and earlier
versions.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-19-06 21:55 Will           New Issue                                    
01-19-06 21:55 Will           Kernel Version            => 2.6.x           
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
