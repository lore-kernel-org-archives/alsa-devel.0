From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001414]: Hercules Digifire - ADC control only mutes left channel
Date: Fri, 30 Dec 2005 23:31:33 +0100
Message-ID: <28d35b54affdafaf413e6b9979f53e8e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B70A2154
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:31:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1414> 
======================================================================
Reported By:                a_r_schulz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1414
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Mandrivia
Kernel Version:             2.6.13
======================================================================
Date Submitted:             09-11-2005 19:12 CEST
Last Modified:              12-30-2005 23:31 CET
======================================================================
Summary:                    Hercules Digifire - ADC control only mutes left
channel
Description: 
I would like to use my card for recording with audacity in LINUX, but it's
a little hard to get the levels right, since the ADC slider in both
alsamixer and kmix affect only the left input channel, leaving the right
channel at full volume. Had this problem with all 2.6 kernel versions so
far, but did not really care up to now...
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:31 
----------------------------------------------------------------------
Any improvement in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-11-05 19:12 a_r_schulz     New Issue                                    
09-11-05 19:12 a_r_schulz     Distribution              => Mandrivia       
09-11-05 19:12 a_r_schulz     Kernel Version            => 2.6.13          
12-30-05 23:31 rlrevell       Note Added: 0007291                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
