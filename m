From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001605]: Sixpack 5.1 can not record with cs46xx
Date: Tue, 6 Dec 2005 16:01:24 +0100
Message-ID: <00aa6898c472a895a4eb353a91531e1e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 167A31A9
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2005 16:01:25 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1605> 
======================================================================
Reported By:                shadowfox
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1605
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Mandriva 10.2
Kernel Version:             2.6.11-6mdk
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             11-28-2005 10:52 CET
Last Modified:              12-06-2005 16:01 CET
======================================================================
Summary:                    Sixpack 5.1 can not record with cs46xx
Description: 


I have a Terratec Sixpack 5.1 soundcard using module cs46xx of ALSA
1.0.10.
I can neither record my voice by gnome recorder nor talk to others through
Skype
although I can hear my sound from my speaks with a microphone.
The record function of my card is out of work.
But everything is OK in my ms windows system.
Thanks
======================================================================

----------------------------------------------------------------------
 shadowfox - 11-29-05 14:56 
----------------------------------------------------------------------
It is solved.
Btw I am not sure  that some of functions of items mean.
Dose anything offer more infos in detail about this?
Thanks a lot.

----------------------------------------------------------------------
 tiwai - 12-06-05 16:01 
----------------------------------------------------------------------
A contribution of a better document would be really helpful ;)
Anyway, closing this now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-28-05 10:52 shadowfox      New Issue                                    
11-28-05 10:52 shadowfox      File Added: asound.state                     
11-28-05 10:52 shadowfox      Distribution              => Mandriva 10.2   
11-28-05 10:52 shadowfox      Kernel Version            => 2.6.11-6mdk     
11-28-05 10:56 shadowfox      Note Added: 0006857                          
11-28-05 18:52 tiwai          Note Added: 0006864                          
11-29-05 14:56 shadowfox      Note Added: 0006873                          
12-06-05 16:01 tiwai          Status                   new => resolved     
12-06-05 16:01 tiwai          Resolution               open => not an issue
12-06-05 16:01 tiwai          Assigned To               => tiwai           
12-06-05 16:01 tiwai          Note Added: 0006929                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
