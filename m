From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001786]: Speaker produce sound even head phone is plugged in
Date: Fri, 27 Jan 2006 04:10:02 +0100
Message-ID: <844881e37f1f76a017ccbbbea1074f73@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CCDEC1A2
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2006 04:10:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1786> 
======================================================================
Reported By:                siukamming
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1786
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debain unstable
Kernel Version:             2.6.14(Debain version) , 2.6.15(customized version)
======================================================================
Date Submitted:             01-27-2006 04:10 CET
Last Modified:              01-27-2006 04:10 CET
======================================================================
Summary:                    Speaker produce sound even head phone is plugged in
Description: 
On my notebook Dell 630M(915GM + sigmatel 9200), the speaker still produce
sound even headphone is plugged in. Now the speaker and headphone produce
sound simultaneously. Suppose the speaker stop to produce sound as
headphone is plugged in. 
I tested Windows. The speaker really stop produce sound as headphone is
plugged in. So it should be the driver problem. 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-27-06 04:10 siukamming     New Issue                                    
01-27-06 04:10 siukamming     File Added: codec#0                          
01-27-06 04:10 siukamming     Distribution              => Debain unstable 
01-27-06 04:10 siukamming     Kernel Version            => 2.6.14(Debain
version) , 2.6.15(customized version)
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
