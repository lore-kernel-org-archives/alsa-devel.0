From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000931]: Wish for M-Audio Revolution 5.1 Support
Date: Thu, 29 Dec 2005 22:07:53 +0100
Message-ID: <6c538caf5b520e806889c49185cbdc23@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 998AA199
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2005 22:07:53 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=931> 
======================================================================
Reported By:                Thinky
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   931
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Debian unstable
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-22-2005 10:40 CET
Last Modified:              12-29-2005 22:07 CET
======================================================================
Summary:                    Wish for M-Audio Revolution 5.1 Support
Description: 
Could you add support for that soundcard?
I hope parts of the ice1724/12 driver can be reused so that it is not a
too hard task.
======================================================================

----------------------------------------------------------------------
 cyan - 12-29-05 21:42 
----------------------------------------------------------------------
Great, it works, thank you.
 There is some more work to do (other outputs, volume in alsamixer is now
separate for left and right chanell...), but these things are just
details.

----------------------------------------------------------------------
 rlrevell - 12-29-05 22:07 
----------------------------------------------------------------------
Great, closing.  Please open new bug reports for any problems.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-22-05 10:40 Thinky         New Issue                                    
02-22-05 10:40 Thinky         Distribution              => Debian unstable 
02-22-05 10:40 Thinky         Kernel Version            => 2.6.10          
02-22-05 10:53 perex          Note Added: 0003696                          
02-27-05 17:42 Thinky         Note Added: 0003742                          
03-02-05 17:40 Thinky         Note Added: 0003780                          
12-02-05 11:54 perex          Note Added: 0006888                          
12-03-05 22:21 cyan           Note Added: 0006904                          
12-03-05 22:36 cyan           Issue Monitored: cyan                        
12-06-05 15:58 tiwai          Note Added: 0006928                          
12-29-05 21:42 cyan           Note Added: 0007189                          
12-29-05 22:07 rlrevell       Status                   new => resolved     
12-29-05 22:07 rlrevell       Resolution               open => fixed       
12-29-05 22:07 rlrevell       Assigned To               => rlrevell        
12-29-05 22:07 rlrevell       Note Added: 0007190                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
