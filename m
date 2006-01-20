From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001764]: Recording signal quality is inacceptable (using OSS API)
Date: Fri, 20 Jan 2006 13:12:03 +0100
Message-ID: <cdb68482346471f0b47322a1f09cebea@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CFDEA153
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 13:12:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1764> 
======================================================================
Reported By:                Freek
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1764
Category:                   PCI - intel8x0
Reproducibility:            have not tried
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-20-2006 13:12 CET
Last Modified:              01-20-2006 13:12 CET
======================================================================
Summary:                    Recording signal quality is inacceptable (using OSS
API)
Description: 
When using the ALSA driver for an i8x0 soundcard the recording quality is
unacceptable.
There is background noise and the input signal quality per se is also
bad.
I used the 2.6.14 in-tree supplied ALSA driver.
There were no ALSA specific libs or programms used nor installed to
record.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-20-06 13:12 Freek          New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
