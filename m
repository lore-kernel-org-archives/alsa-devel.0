From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0001772]: License on one file lacks GPL version option
Date: Sun, 22 Jan 2006 20:27:00 +0100
Message-ID: <e018521481749452fd248c6f6131cdb3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2436E14B
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2006 20:27:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1772> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   1772
Category:                   echomixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-22-2006 20:27 CET
Last Modified:              01-22-2006 20:27 CET
======================================================================
Summary:                    License on one file lacks GPL version option
Description: 
Most alsa-tools source files contain this text:

   This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License
   as published by the Free Software Foundation; either version 2
   of the License, or (at your option) any later version.

However, one file contains this text:

 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; version 2 of the License.

The latter text does not grant the user the option of using a later
version of the GPL.

I found the anomalous license statement in:

  echomixer/echomixer.c

I have written to the author asking whether or not he really meant not
to grant the version option.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-22-06 20:27 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
